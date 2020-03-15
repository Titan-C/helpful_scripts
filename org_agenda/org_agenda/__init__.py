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
from icalendar import Calendar
from org_agenda import ical2org


def passwordstore(address: str) -> str:
    """Get password from passwordstore address"""

    process = subprocess.run(["pass", "show", address],
                             stdout=subprocess.PIPE,
                             check=True)
    if process.returncode == 0:
        return process.stdout.split()[0]


def get_icalendar(calendar, section, force):
    url = section["url"]
    hash_url = hashlib.sha1(url.encode("UTF-8")).hexdigest()[:10]
    url_file = f"/tmp/agenda-{hash_url}"
    if not force and os.path.exists(url_file):
        with open(url_file) as txt:
            return Calendar.from_ical(txt.read())

    user = section["user"]
    password = passwordstore(section["passwordstore"])

    logger = logging.getLogger("Org_calendar")
    logger.info("Downloading Calendar: %s", calendar)

    ical_reply = requests.get(url, auth=(user, password))

    if ical_reply.status_code == 200:
        with open(url_file, "w") as txt:
            txt.write(ical_reply.text)
        return Calendar.from_ical(ical_reply.text)


def get_config():

    config = configparser.ConfigParser()

    logger = logging.getLogger("Org_calendar")
    config_file = os.path.expanduser("~/.calendars.conf")
    logger.info("Reading config from: %s", config_file)
    config.read([config_file])

    return json.loads(json.dumps(config._sections))


def parse_arguments():
    parser = argparse.ArgumentParser(
        description="Translate CalDav Agenda to orgfile")
    parser.add_argument("-f",
                        "--force",
                        help="Force Download of Caldav files",
                        action="store_true")
    parser.add_argument("-v", "--verbose", action="count", default=0)

    return parser.parse_args()


def main():
    args = parse_arguments()

    logger = logging.getLogger("Org_calendar")
    logger.addHandler(logging.StreamHandler())
    log_level = logging.INFO if args.verbose > 0 else logging.WARNING
    logger.setLevel(log_level)

    config = get_config()
    defaults = config.pop("defaults")

    events = []
    for calendar in config:
        ical = get_icalendar(calendar, config[calendar], args.force)
        events += [
            ical2org.OrgEntry(entry) for entry in ical.walk()
            if entry.name == "VEVENT"
        ]

    outfile = os.path.expanduser(defaults["outfile"])
    ahead = int(defaults.get("ahead", 50))
    back = int(defaults.get("back", 14))
    filtered_events = map(str,
                          (x for x in events if x.date_block(ahead, back)))

    with open(outfile, "w") as fid:
        logger.info("Writing calendars to: %s", outfile)
        fid.write("\n\n".join(filtered_events))
        fid.write("\n")
