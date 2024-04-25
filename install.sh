#!/bin/bash

# Prepare things
sudo mkdir -p /usr/local/bin

# Is there a point to error checking here?
if [ ! -d /usr/local/bin ]; then
    echo /usr/local/bin is not a directory, bailing
    exit 1
fi

cd /usr/local/bin

# Download and unzip the latest version of Cloud C2
sudo wget -q https://c2.hak5.org/download/latest -O cloudc2.zip
sudo unzip cloudc2.zip

BIN_FILE=c2*amd64_linux
CC2_HOSTNAME=cc2.atarax.is

if [ ! -e $BIN_FILE ]; then
    echo $BIN_FILE is not an executable, bailing
    exit 1
fi

# $BIN_FILE -hostname $CC2_HOSTNAME

# Run Cloud C2 as a service
# Move Cloud C2 binary.
#sudo mv $BIN_FILE /usr/local/bin

# Create directory for database file
sudo mkdir /var/cloudc2

# Move database file
#sudo mv c2.db /var/cloudc2/

# not quite ready

exit 0
# Create systemd service file.
sudo vi /etc/systemd/system/cloudc2.service

# Replace parameters as necessary for your instance
[Unit]
Description=Hak5 Cloud C2
After=cloudc2.service
[Service]
Type=idle
ExecStart=/usr/local/bin/$BIN_FILE -hostname $CC2_HOSTNAME -db /var/cloudc2/c2.db
[Install]
WantedBy=multi-user.target

# Reload, enable on boot, start and inspect the newly created Cloud C2 service
sudo systemctl daemon-reload
sudo systemctl enable cloudc2.service
sudo systemctl start cloudc2.service
sudo systemctl status cloudc2.service
