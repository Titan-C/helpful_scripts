#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""
Generate Org-Mode agenda file from ical web sources
===================================================

Goal of the script
"""
# Created: Fri Jan 11 22:54:35 2019
# Author: Óscar Nájera
# License:GPL-3

# TODO Accumulate calendars

import os
import json
import configparser
import subprocess
import logging

import requests
from icalendar import Calendar
import ical2org


def passwordstore(address: str) -> str:
    """Get password from passwordstore address"""

    process = subprocess.run(["pass", "show", address], stdout=subprocess.PIPE)
    if process.returncode == 0:
        return process.stdout.split()[0]


def get_icalendar(section):
    user = section["user"]
    password = passwordstore(section["passwordstore"])
    url = section["url"]

    ical_reply = requests.get(url, auth=(user, password))

    if ical_reply.status_code == 200:
        return Calendar.from_ical(ical_reply.text)


def get_config():

    config = configparser.ConfigParser()

    logger = logging.getLogger("Org_calendar")
    config_file = os.path.join(os.path.dirname(__file__), "calendars.conf")
    logger.info("Reading config from: %s", config_file)
    config.read([config_file])

    return json.loads(json.dumps(config._sections))


def main():

    logger = logging.getLogger("Org_calendar")
    logger.addHandler(logging.StreamHandler())
    logger.setLevel(logging.INFO)

    config = get_config()
    defaults = config.pop("defaults")

    events = []
    for calendar in config:
        logger.info("Downloading Calendar: %s", calendar)
        ical = get_icalendar(config[calendar])
        events += [
            ical2org.orgEntry(entry) for entry in ical.walk()
            if entry.name == "VEVENT"
        ]

    outfile = os.path.expanduser(defaults["outfile"])
    with open(outfile, "w") as fid:
        logger.info("Writing calendars to: %s", outfile)
        fid.write("\n\n".join([str(x).strip() for x in events if str(x)]))


if __name__ == "__main__":
    main()
