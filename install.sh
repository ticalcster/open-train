#!/usr/bin/env bash

# Run as root or insert `sudo -E` before `bash`:
#
# curl -sL https://raw.githubusercontent.com/ticalcster/open-train/master/install.sh | bash -
#   or
# wget -qO- https://raw.githubusercontent.com/ticalcster/open-train/master/install.sh | bash -
#

cat > /opt/test.py <<EOI
import time

while True:
    time.sleep(2)
    print('I am in the loop')
EOI


cat > /lib/systemd/system/train.service <<EOI
[Unit]
Description=Open Train
After=multi-user.target

[Service]
Type=idle
ExecStart=/usr/bin/python3 /opt/test.py > /var/log/train.log 2>&1

[Install]
WantedBy=multi-user.target
EOI

chmod 644 /lib/systemd/system/train.service
systemctl daemon-reload
systemctl enable train.service
systemctl status train.service

# |