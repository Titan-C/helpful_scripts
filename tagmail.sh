if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
    source /tmp/.Xdbus
fi

# delete mail
notmuch search --output=files tag:deleted | xargs  -I {} rm -v "{}"

# Mail download
mbsync -aV

# Notmuch tagging
notmuch new
notmuch tag +clusjobs -inbox -tome from:root@local.u-psud.fr or from:root@orlando.u-psud.fr subject:Job tag:inbox
notmuch tag +coding -inbox -tome from:github.com or from:bitbucket.org or from:gitlab.com tag:inbox
notmuch tag +ci -inbox -tome from:travis-ci.com or from:travis-ci.org tag:inbox
notmuch tag +LPS -inbox -tome subject:tous.lps tag:inbox
notmuch tag +LPSPHD -inbox -tome subject:tousthesards.lps tag:inbox
