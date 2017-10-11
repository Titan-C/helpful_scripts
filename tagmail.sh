if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
    source /tmp/.Xdbus
fi

# delete mail
notmuch search --output=files tag:deleted | xargs  -I {} rm -v "{}"

# Mail download
mbsync -aV

# Notmuch tagging
notmuch new

notmuch tag +ci -inbox -- from:travis-ci.com or from:travis-ci.org or from:appveyor.com or from:circleci.com tag:inbox
notmuch tag +ci -coding -- from:mg.gitlab.com and subject:Pipeline tag:coding

# afew tagging
$HOME/.local/bin/afew -t -n -v
