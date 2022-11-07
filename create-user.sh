set -eux
USERNAME=$1
adduser $1 --disabled-password --gecos ""
KEYS_FILE=/home/$USERNAME/.ssh/authorized_keys
curl https://github.com/$USERNAME.keys > $KEYS_FILE
chmod 700 $KEYS_FILE
chown $USERNAME:$USERNAME $KEYS_FILE
