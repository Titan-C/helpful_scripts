if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
    source /tmp/.Xdbus
fi

# Mail download
mbsync -aV

# Notmuch
notmuch search --output=files tag:deleted | xargs  -I {} rm -v "{}"

notmuch new
notmuch tag +clusjobs -unread -inbox from:root@local.u-psud.fr subject:Job tag:inbox
notmuch tag +coding -inbox from:github.com or from:bitbucket.org or from:gitlab.com tag:inbox
notmuch tag +ci -inbox from:travis-ci.com or from:travis-ci.org tag:inbox