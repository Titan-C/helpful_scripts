#!/usr/bin/env bash

if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
    source /tmp/.Xdbus
fi

# delete mail
notmuch search --output=files tag:deleted | xargs  -I {} rm -v "{}"

# Mail download
mbsync -a

# Notmuch tagging
notmuch new

notmuch tag +ci -new -- from:travis-ci.com or from:travis-ci.org or from:appveyor.com or from:circleci.com
notmuch tag +ci -new -- from:mg.gitlab.com and subject:Pipeline
notmuch tag +CMK-JIRA -inbox -new -- from:infra@mathias-kettner.de or from:jira@tribe29.com
notmuch tag +alle-mk -new -- to:alle@mathias-kettner.de to:technik@tribe29.com
notmuch tag +cmk-commits -new -- to:cmk-internal-commits@mathias-kettner.de and subject:\[cmk\]
notmuch tag +mkde-commits -new -- to:cmk-internal-commits@mathias-kettner.de and subject:\[mkde\]
notmuch tag +cmc-commits -new -- to:cmk-internal-commits@mathias-kettner.de and subject:\[cmc\]
notmuch tag +cma-commits -new -- to:cma-commits@mathias-kettner.de and subject:\[cma\]
notmuch tag +immonews -new -- from:immobilienscout24.de
notmuch tag +immonews/communications -new -- from:nachrichten.immobilienscout24.de or subject:Kontaktaufnahme and tag:immonews
notmuch tag +socialnews -new -- from:facebookmail.com or from:mail.instagram.com
notmuch tag +linkedin +socialnews -new -- from:linkedin.com
notmuch tag +promotions -- from:newsletter
notmuch tag +toastmasters -- toastmaster NOT from:info@meetup.com

notmuch tag +sms -inbox -- folder:hi_pers/SMS
notmuch tag +calls -inbox -- folder:hi_pers/Calls

# afew tagging
$HOME/.local/bin/afew --tag --new -v

notmuch tag -inbox -- tag:lists
