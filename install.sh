#!/bin/bash
#----------------------------------------------------------------------------
# Settings
CC2_HOSTNAME=cc2.atarax.is
#----------------------------------------------------------------------------

# Prepare things
sudo mkdir -p /usr/local/bin
if [ ! -d /usr/local/bin ]; then
    echo /usr/local/bin is not a directory, bailing
    exit 1
fi

# Download and unzip the latest version of Cloud C2
cd /usr/local/bin
sudo wget -q https://c2.hak5.org/download/latest -O cloudc2.zip
sudo unzip cloudc2.zip
cc2binary=c2*amd64_linux

if [ ! -e $cc2binary ]; then
    echo $cc2binary is not an executable, bailing
    exit 1
fi

# Create systemd service file.
cat <<'EOF' > /tmp/cloudc2.service
# Replace parameters as necessary for your instance
[Unit]
Description=Hak5 Cloud C2
After=cloudc2.service
[Service]
Type=idle
ExecStart=/usr/local/bin/$cc2binary -hostname $CC2_HOSTNAME -db /var/cloudc2/c2.db
[Install]
WantedBy=multi-user.target
EOF
sudo mv /tmp/cloudc2.service /etc/systemd/system/cloudc2.service

# Create directory for database file
sudo mkdir /var/cloudc2

# $cc2binary -hostname $CC2_HOSTNAME -db /var/cloudc2/c2.db
# maybe stash this in / retrieve from s3
# sudo mv c2.db /var/cloudc2/

# Reload, enable on boot, start and inspect the newly created Cloud C2 service
sudo systemctl daemon-reload
sudo systemctl enable cloudc2.service
sudo systemctl start cloudc2.service
sudo systemctl status cloudc2.service
