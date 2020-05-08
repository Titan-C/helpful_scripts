#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""
Parse Bank statement
====================

From CSV to ledger
"""
# Created: Sat May 18 18:32:47 2019
# Author: Óscar Nájera
# License: GPL-3

import argparse
import csv
import shlex
import subprocess

from datetime import datetime
from collections import namedtuple

entry = namedtuple(
    "Statement_entry",
    [
        "entry",
        "saved",
        "type",
        "info",
        "amount",
        "curr",
        "payee",
        "pa_Auftraggeberkonto",
        "IBAN_Auftraggeberkonto",
        "Kategorie",
    ],
)


def translate_bankstatement(filename):
    with open(filename) as csvfile, open("/tmp/exit", "w") as fi:
        data = csv.reader(csvfile, delimiter=";")
        next(data)
        fi.write("date,payee,amount\n")
        for row in data:
            en = entry(*row)
            date = (
                datetime.strptime(en.saved, "%d.%m.%Y") if en.saved else datetime.now()
            )
            date = date.strftime("%Y-%m-%d")
            amount = en.amount.replace(",", ".")
            fi.write(f"""{date},{en.info.replace(',',' ')},{amount} {en.curr}\n""")


def convert_to_ledger():
    lo = shlex.split(
        'ledger convert /tmp/exit -f ~/dev/journal/accout_setup.ledger --account "Assets:Commerzbank Vorteil" --invert --rich-data -y %Y-%m-%d'
    )
    yo = subprocess.run(lo, capture_output=True)
    with open("/tmp/led", "wb") as fi:
        fi.write(yo.stdout)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create Ledger entries from bank")
    parser.add_argument("file", help="File containing the ndarray")
    args = parser.parse_args()
    translate_bankstatement(args.file)
    convert_to_ledger()
