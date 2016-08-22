#!/bin/bash

# This runs as root on the server

# chef_binary=/var/lib/gems/1.9.1/bin/chef-solo
# chef_binary=/usr/local/bin/chef-solo
chef_binary=/usr/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
    #export DEBIAN_FRONTEND=noninteractive
    # Upgrade headlessly (this is only safe-ish on vanilla systems)
    aptitude update &&
    apt-get -o Dpkg::Options::="--force-confnew" \
        --force-yes -fuy dist-upgrade &&
    # Install Ruby and Chef
    #aptitude install -y ruby1.9 ruby-dev gcc make &&
    #sudo gem install --no-rdoc --no-ri chef --version 0.12.6

    aptitude install -y gcc make curl &&
    sudo su -c 'curl -L https://www.opscode.com/chef/install.sh | bash'
fi &&

"$chef_binary" -c solo.rb -j solo.json
