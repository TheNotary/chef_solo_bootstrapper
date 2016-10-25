#!/bin/bash

# This runs as root on the server

# chef_binary=/var/lib/gems/1.9.1/bin/chef-solo
# chef_binary=/usr/local/bin/chef-solo
user_name=vagrant
chef_binary=/usr/bin/chef-solo
ruby_binary=/usr/local/rvm/rubies/ruby-2.3.1/bin/ruby
berks_binary=/usr/local/rvm/gems/ruby-2.3.1/bin/berks

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

  aptitude install -y gcc make curl # &&
    # sudo su -c 'curl -L https://www.opscode.com/chef/install.sh | bash -s -- -v 12.10.24'
fi &&

if ! test -f "$ruby_binary"; then
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.1
  chown -R ${user_name} /usr/local/rvm
  echo "---\ngem: --no-ri --no-rdoc" > ~/.gemrc

  bash -l -c "gem install chef -v 12.10.24"
  bash -l -c "gem install berkshelf -v 5.1.0"
fi &&

# Use Knife to manually download required cookbooks
  # mkdir -p /home/${user_name}/.chef/cookbooks
  # cd /home/${user_name}/.chef/cookbooks
  # git init
  # git commit --allow-empty -m "inits repo"
  # cd ~/chef

bash -l -c "cd cookbooks/* && ${berks_binary} vendor ../ && cd ../.."
chown -R ${user_name} /home/${user_name}
chown -R ${user_name} /usr/local/rvm

bash -l -c "rvmsudo chef-solo -c solo.rb"
# bash -l -c "${chef_binary} -c solo.rb -j solo.json"
