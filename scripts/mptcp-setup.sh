#!/bin/bash

# Copyright 2022 The marketplace-openmptcprouter Authors All rights reserved.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

echo "STEP 1: Install OpenMPTCProuter ..."
curl -sSL https://www.openmptcprouter.com/server/debian-x86_64.sh -o /tmp/openmptcprouter-install.sh
chmod 700 /tmp/openmptcprouter-install.sh
/tmp/openmptcprouter-install.sh
echo "OpenMPTCProuter installation complete."


echo "STEP 2: Update README ..."
touch /root/README
perl -C -Mutf8 -i -p0e \
    's/^\n+█▀+\n█ OpenMPTCProuter.*OpenMPTCProuter █\n▄+█\n//sme' \
    /root/README
cat <<EOF >> /root/README


█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
█ OpenMPTCProuter

OpenMPTCProuter (OMR) uses MultiPath TCP (MPTCP) and OpenWrt to
aggregate multiple Internet connections. Consider donating at:

                 openmptcprouter.com
                 ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄

This Droplet serves as the aggregation endpoint for your local
OMR. You shouldn't need to do much here, outside:

1. Grabbing your server key from:

        /root/openmptcprouter_config.txt

2. Periodically updating your Droplet:

        apt update
        apt upgrade
        reboot # if necessary


For more information on getting started / setting up your local
OMR, checkout:

- OMR's website:

        openmptcprouter.com

- This project's github page:

        https://github.com/digitalocean/marketplace-openmptcprouter


Troubleshooting
===============

"Hello IT. Have you tried turning it off and back on again?"

Once you have your local OMR setup, if you're having any trouble,
try rebooting both this server and your local OMR.

"60% of the time, it works every time."

OpenMPTCProuter █
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█
EOF
echo "README update complete."
