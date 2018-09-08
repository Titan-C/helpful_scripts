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

# afew tagging
$HOME/.local/bin/afew --tag --new -v
