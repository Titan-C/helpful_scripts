if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
    source /tmp/.Xdbus
fi

# delete mail
notmuch search --output=files tag:deleted | xargs  -I {} rm -v "{}"

# Mail download
mbsync -aV

# Notmuch tagging
notmuch new
notmuch tag +clusjobs -unread -inbox from:root@local.u-psud.fr subject:Job tag:inbox
notmuch tag +coding -inbox from:github.com or from:bitbucket.org or from:gitlab.com tag:inbox
notmuch tag +ci -inbox from:travis-ci.com or from:travis-ci.org tag:inbox
