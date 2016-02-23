#!/bin/bash
DEBIAN_FRONTEND=noninteractive sudo apt-get -qqy update
DEBIAN_FRONTEND=noninteractive sudo apt-get install -qqy git git-review python-pip python-dev openvswitch-switch
sudo mkdir -p /opt/stack
sudo chown -R vagrant: /opt/stack
sudo chown -R vagrant: /home/vagrant
sudo -H pip install --upgrade pip
pushd /opt/stack
[ -d devstack ] || git clone https://git.openstack.org/openstack-dev/devstack
pushd devstack
git checkout stable/kilo
cat > local.conf <<EOF
[[local|localrc]]
ADMIN_PASSWORD=password
SERVICE_TOKEN=password
DATABASE_PASSWORD=password
RABBIT_PASSWORD=password
SERVICE_PASSWORD=password

disable_service n-net
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta
disable_service tempest
#OFFLINE=True

# Github's Branch
GLANCE_BRANCH=stable/kilo
HORIZON_BRANCH=stable/kilo
KEYSTONE_BRANCH=stable/kilo
NOVA_BRANCH=stable/kilo
NEUTRON_BRANCH=stable/kilo
HEAT_BRANCH=stable/kilo
CEILOMETER_BRANCH=stable/kilo

EOF

sudo hostname devstack.local
echo '127.0.0.1 devstack.local devstack localhost' | sudo tee /etc/hosts

./stack.sh
./unstack.sh
sed -i 's/\#OFFLINE=True/OFFLINE=True/' local.conf
