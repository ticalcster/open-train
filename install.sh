#!/usr/bin/env bash

# Run as root or insert `sudo -E` before `bash`:
#
# curl -sL https://raw.githubusercontent.com/ticalcster/open-train/master/install.sh | bash -
#   or
# wget -qO- https://raw.githubusercontent.com/ticalcster/open-train/master/install.sh | bash -
#

pip3 uninstall opentrain
pip3 install git+https://github.com/ticalcster/open-train.git#egg=opentrain

cat > /lib/systemd/system/train.service <<EOI
[Unit]
Description=Open Train
After=multi-user.target

[Service]
Type=idle
ExecStart=/usr/bin/python3 -m opentrain

[Install]
WantedBy=multi-user.target
EOI

chmod 644 /lib/systemd/system/train.service
systemctl daemon-reload
systemctl enable train.service
systemctl start train.service
systemctl status train.service

# |