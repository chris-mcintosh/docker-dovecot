#!/bin/bash
# Docker entrypoint
#
# Author: gw0 [http://gw.tnode.com/] <gw.2021@ena.one>
set -e

# initialize on first run
echo "Initializing..."
mkdir -p /var/log/dovecot
touch /var/log/dovecot/dovecot.log
chown root:users /var/log/dovecot/dovecot.log
chmod 664 /var/log/dovecot/dovecot.log
for USER in $(ls -1 /home); do
  echo "User '$USER':"
  if ! id -u "$USER" >/dev/null 2>&1; then
    passFile="/vol/config/${USER}.pass"
    if [ -f "$passFile" ]; then
      echo "Found passFile: $passFile"
      userPass="$(cat $passFile)"
    else
      echo "Not found passFile: $passFile, Using default password"
      userPass="${DEFAULT_PASSWD}"
    fi
    useradd --groups=users --no-create-home --shell='/bin/true' "$USER"
    echo -e "$userPass\n$userPass\n" | passwd "$USER"
    chown -R "$USER:$USER" "/home/$USER"
    chmod 700 /home/$USER/{Maildir,sieve} || true
  fi
done

# start services
echo "Starting services..."
/etc/init.d/dovecot start
/etc/init.d/cron start

exec "$@"
