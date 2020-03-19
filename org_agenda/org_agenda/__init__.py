# -*- coding: utf-8 -*-
r"""
Generate Org-Mode agenda file from ical web sources
===================================================

Goal of the script
"""
# Created: Fri Jan 11 22:54:35 2019
# Author: Óscar Nájera
# License:GPL-3

import argparse
import configparser
import hashlib
import json
import logging
import os
import subprocess

import requests
from org_agenda.ical2org import org_events


def passwordstore(address: str) -> str:
    """Get password from passwordstore address"""

    process = subprocess.run(
        ["pass", "show", address], stdout=subprocess.PIPE, check=True
    )
    if process.returncode == 0:
        return process.stdout.split()[0]

    raise ValueError("Unknown password address")


def get_icalendar(calendar, section, force):
    "Return calendar from download or cache"
    url = section["url"]
    hash_url = hashlib.sha1(url.encode("UTF-8")).hexdigest()[:10]
    url_file = f"/tmp/agenda-{hash_url}"
    if not force and os.path.exists(url_file):
        with open(url_file) as txt:
            return txt.read()

    user = section["user"]
    password = passwordstore(section["passwordstore"])

    logger = logging.getLogger("Org_calendar")
    logger.info("Downloading Calendar: %s", calendar)

    ical_reply = requests.get(url, auth=(user, password))

    if ical_reply.status_code == 200:
        with open(url_file, "w") as txt:
            txt.write(ical_reply.text)
        return ical_reply.text

    raise ValueError("Could not get calendar: %s" % calendar)


def get_config():
    "parse config file"

    config = configparser.ConfigParser()

    logger = logging.getLogger("Org_calendar")
    config_file = os.path.expanduser("~/.calendars.conf")
    logger.info("Reading config from: %s", config_file)
    config.read([config_file])

    return config


def parse_arguments():
    "Parse CLI"
    parser = argparse.ArgumentParser(description="Translate CalDav Agenda to orgfile")
    parser.add_argument(
        "-f", "--force", help="Force Download of Caldav files", action="store_true"
    )
    parser.add_argument("-v", "--verbose", action="count", default=0)

    return parser.parse_args()


def main():
    "Transform Calendars"
    args = parse_arguments()

    logger = logging.getLogger("Org_calendar")
    logger.addHandler(logging.StreamHandler())
    log_level = logging.INFO if args.verbose > 0 else logging.WARNING
    logger.setLevel(log_level)

    config = get_config()

    calendars = (
        get_icalendar(calendar, config[calendar], args.force)
        for calendar in config.sections()
    )

    ahead = int(config["DEFAULT"].get("ahead", 50))
    back = int(config["DEFAULT"].get("back", 14))
    outfile = os.path.expanduser(config["DEFAULT"]["outfile"])
    with open(outfile, "w") as fid:
        logger.info("Writing calendars to: %s", outfile)
        fid.write("\n\n".join(org_events(calendars, ahead, back)))
        fid.write("\n")
