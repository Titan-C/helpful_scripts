# -*- coding: utf-8 -*-
r"""
Generate Org-Mode agenda file from ical web sources
===================================================

Goal of the script
"""
# Created: Fri Jan 11 22:54:35 2019
# Author: Óscar Nájera
# License:GPL-3

import configparser
import hashlib
import json
import logging
import os
import subprocess

import requests
from icalendar import Calendar
from org_agenda import ical2org


def passwordstore(address: str) -> str:
    """Get password from passwordstore address"""

    process = subprocess.run(["pass", "show", address],
                             stdout=subprocess.PIPE,
                             check=True)
    if process.returncode == 0:
        return process.stdout.split()[0]


def get_icalendar(section):
    url = section["url"]
    hash_url = hashlib.sha1(url.encode("UTF-8")).hexdigest()[:10]
    url_file = f"/tmp/agenda-{hash_url}"
    if os.path.exists(url_file):
        with open(url_file) as txt:
            return Calendar.from_ical(txt.read())

    user = section["user"]
    password = passwordstore(section["passwordstore"])

    ical_reply = requests.get(url, auth=(user, password))

    if ical_reply.status_code == 200:
        with open(url_file, 'w') as txt:
            txt.write(ical_reply.text)
        return Calendar.from_ical(ical_reply.text)


def get_config():

    config = configparser.ConfigParser()

    logger = logging.getLogger("Org_calendar")
    config_file = os.path.expanduser('~/.calendars.conf')
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
        logger.info("Finished Downloading Calendar: %s", calendar)
        events += [
            ical2org.orgEntry(entry) for entry in ical.walk()
            if entry.name == "VEVENT"
        ]

    outfile = os.path.expanduser(defaults["outfile"])
    with open(outfile, "w") as fid:
        logger.info("Writing calendars to: %s", outfile)
        fid.write("\n\n".join([str(x).strip() for x in events if str(x)]))
