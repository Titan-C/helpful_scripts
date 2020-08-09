#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Copyright (C) 2019 tribe29 GmbH - License: GNU General Public License v2
# This file is part of Checkmk (https://checkmk.com). It is subject to the terms and
# conditions defined in the file COPYING, which is part of this source code package.

# This agent uses UPNP API calls to the Fritz!Box to gather information
# about connection configuration and status.

# UPNP API CALLS THAT HAVE BEEN PROVEN WORKING
# Tested on:
# - AVM FRITZ!Box Fon WLAN 7360 111.05.51
# General Device Infos:
# http://fritz.box:49000/igddesc.xml
#
# http://fritz.box:49000/igdconnSCPD.xml
# get_upnp_info('WANIPConn1', 'urn:schemas-upnp-org:service:WANIPConnection:1', 'GetStatusInfo')
# get_upnp_info('WANIPConn1', 'urn:schemas-upnp-org:service:WANIPConnection:1', 'GetExternalIPAddress')
# get_upnp_info('WANIPConn1', 'urn:schemas-upnp-org:service:WANIPConnection:1', 'GetConnectionTypeInfo')
# get_upnp_info('WANIPConn1', 'urn:schemas-upnp-org:service:WANIPConnection:1', 'GetNATRSIPStatus')
#
# http://fritz.box:49000/igdicfgSCPD.xml
# get_upnp_info('WANCommonIFC1', 'urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1', 'GetAddonInfos')
# get_upnp_info('WANCommonIFC1', 'urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1', 'GetCommonLinkProperties')
#
# http://fritz.box:49000/igddslSCPD.xml
# get_upnp_info('WANDSLLinkC1', 'urn:schemas-upnp-org:service:WANDSLLinkConfig:1', 'GetDSLLinkInfo')

import argparse
import pprint
import re
import socket
import time
import traceback
import urllib.error
import urllib.request
import logging

import requests
from requests.auth import HTTPDigestAuth


def parse_args():

    parser = argparse.ArgumentParser(description="Check_MK Fritz!Box Agent")
    parser.add_argument(
        "host_address", metavar="HOST", help="Host name or IP address of your Fritz!Box"
    )
    parser.add_argument(
        "-t",
        "--timeout",
        type=int,
        default=10,
        metavar="SEC",
        help="""Set the network timeout to <SEC> seconds.
                                    Default is 10 seconds. Note: the timeout is not
                                    applied to the whole check, instead it is used for
                                    each API query.""",
    )
    parser.add_argument(
        "--debug",
        action="store_true",
        help="Debug mode: let Python exceptions come through",
    )

    return parser.parse_args()


class RequestError(Exception):
    pass


def get_info(url, data, headers):
    logging.debug("Connecting URL: %s", url)
    logging.debug("SoapAction: %s", headers["SoapAction"])

    handle = requests.post(url, data=data.encode("utf-8"), headers=headers, auth=auth)

    infos = handle.raw.info()
    logging.debug("Server: %s", infos["SERVER"])
    contents = handle.text
    logging.debug(contents)

    return infos, contents


def get_upnp_info(url, namespace, action):

    headers = {
        "User-agent": "Check_MK agent_fritzbox",
        "Content-Type": "text/xml",
        "SoapAction": namespace + "#" + action,
    }

    data = f"""<?xml version='1.0' encoding='utf-8'?>
    <s:Envelope s:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:s='http://schemas.xmlsoap.org/soap/envelope/'>
        <s:Body>
            <u:{action} xmlns:u="{namespace}" />
        </s:Body>
    </s:Envelope>"""

    # Fritz!Box with firmware >= 6.0 use a new url. We try the newer one
    # first and try the other one, when the first one did not succeed.

    infos, contents = get_info(url, data, headers)

    parts = infos["SERVER"].split("UPnP/1.0 ")[1].split(" ")
    g_device = " ".join(parts[:-1])
    g_version = parts[-1]

    # parse the response body
    match = re.search(
        "<u:%sResponse[^>]+>(.*)</u:%sResponse>" % (action, action),
        contents,
        re.M | re.S,
    )
    if not match:
        raise Exception("Response is not parsable")
    response = match.group(1)
    matches = re.findall("<([^>]+)>([^<]+)<[^>]+>", response, re.M | re.S)

    attrs = dict(matches)
    attrs.update({"device": g_device, "version": g_version})

    logging.debug("Parsed: %s\n" % pprint.pformat(attrs))

    return attrs


def main():
    args = parse_args()

    log_level = logging.DEBUG if args.debug else logging.WARNING
    logging.basicConfig(level=log_level)

    socket.setdefaulttimeout(args.timeout)
    base_url = "http://%s:49000/" % args.host_address

    try:
        status = {}
        for configs in [
            (
                base_url + "igdupnp/control/WANIPConn1",
                "urn:schemas-upnp-org:service:WANIPConnection:1",
                "GetStatusInfo",
            ),
            (
                base_url + "igdupnp/control/WANCommonIFC1",
                "urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1",
                "GetAddonInfos",
            ),
            (
                base_url + "igdupnp/control/WANCommonIFC1",
                "urn:schemas-upnp-org:service:WANCommonInterfaceConfig:1",
                "GetCommonLinkProperties",
            ),
            (
                base_url + "upnp/control/wancommonifconfig1",
                "urn:dslforum-org:service:WANCommonInterfaceConfig:1",
                "GetCommonLinkProperties",
            ),
            (
                base_url + "upnp/control/wandslifconfig1",
                "urn:dslforum-org:service:WANDSLInterfaceConfig:1",
                "GetStatisticsTotal",
            ),
        ]:
            try:
                attrs = get_upnp_info(*configs)
            except Exception:
                if args.debug:
                    raise
            else:
                status.update(attrs)

        return status

    except Exception:
        if args.debug:
            raise
        logging.debug("Unhandled error: %s" % traceback.format_exc())


if __name__ == "__main__":

    result = main()
    res = ":".join(
        map(
            str,
            (
                time.time(),
                result["NewUptime"],
                result["NewTotalBytesSent"],
                result["NewTotalBytesReceived"],
                result["NewX_AVM_DE_TotalBytesSent64"],
                result["NewX_AVM_DE_TotalBytesReceived64"],
            ),
        )
    )
    print(res)
    with open("fritz.txt", "a") as fid:
        fid.write(res + "\n")

    res = ":".join(
        map(
            str,
            (
                time.time(),
                result["NewATUCCRCErrors"],
                result["NewCRCErrors"],
                result["NewErroredSecs"],
                result["NewSeverelyErroredSecs"],
            ),
        )
    )
    print(res)
    with open("fritz.err.txt", "a") as fid:
        fid.write(res+'\n')
