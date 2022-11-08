create_user() {
    GITHUB=$3
    set -eux
    USERNAME=$1
    PASSWORD=$2
    adduser $1 --disabled-password --gecos ""
    echo "$USERNAME:$PASSWORD" | chpasswd
    KEYS_FILE=/home/$USERNAME/.ssh/authorized_keys

    # Add github to known hosts if $GITHUB is set
    if [ -n "$GITHUB" ]; then
        curl https://github.com/$USERNAME.keys > $KEYS_FILE
        chmod 700 $KEYS_FILE
        chown $USERNAME:$USERNAME $KEYS_FILE
    fi
    set +e
}

# read users from file
# format: username password github

while read -r line; do
	(
    create_user $line
)
done
