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

echo "STEP 1: Update system ..."
export DEBIAN_FRONTEND=noninteractive
apt-get -qqy update
apt-get -qqy -o Dpkg::Options::="--force-confdef" \
             -o Dpkg::Options::="--force-confold" full-upgrade
apt-get -qqy -o Dpkg::Options::="--force-confdef" \
             -o Dpkg::Options::="--force-confold" install \
                iptables-persistent
apt-get -qqy autoremove
apt-get -qqy clean
echo "System update complete."


echo "STEP 2: Installing base README ..."
cat <<EOF > /root/README


          IT'S DANGEROUS TO GO ALONE! TAKE THIS.

                            ⚔️

             Hello new OpenMPTCProuter user!
             ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
EOF
echo "Base README installation complete."

echo "System setup complete."
