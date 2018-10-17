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
notmuch tag +cmk-commits -new -- to:cmk-internal-commits@mathias-kettner.de
notmuch tag +immonews -new -- from:immobilienscout24.de
notmuch tag +immonews/communications -new -- from:nachrichten.immobilienscout24.de or subject:Kontaktaufnahme and tag:immonews
notmuch tag +immonews -new -- from:immobilienscout24.de and subject:Kontact
notmuch tag +socialnews -new -- from:facebookmail.com or from:mail.instagram.com
notmuch tag +linkedin +socialnews -new -- from:linkedin.com
notmuch tag +CMK-JIRA -new -- subject:\[CMK-JIRA\]
notmuch tag +alle-mk -new -- to:alle@mathias-kettner.de
notmuch tag +promotions -- from:newsletter

# afew tagging
$HOME/.local/bin/afew --tag --new -v
