#!/bin/bash

# This runs as root on the server
user_name=vagrant

chef_binary=/usr/local/rvm/gems/ruby-2.3.1/bin/chef-solo
ruby_binary=/usr/local/rvm/rubies/ruby-2.3.1/bin/ruby
berks_binary=/usr/local/rvm/gems/ruby-2.3.1/bin/berks


# TODO: create user if not exists!


# update system and install ruby
if ! test -f "$ruby_binary"; then
  # Upgrade headlessly (this is only safe-ish on vanilla systems)
  export DEBIAN_FRONTEND=noninteractive
  aptitude update && \
    apt-get -o Dpkg::Options::="--force-confnew" \
    --force-yes -fuy dist-upgrade &&

  aptitude install -y gcc make curl

  # Install Ruby via rvm
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
  \curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.1
  chown -R vagrant /usr/local/rvm
  echo "---\ngem: --no-ri --no-rdoc" > ~/.gemrc
fi &&

# Install chef as a gem
if ! test -f "$chef_binary"; then
  bash -l -c "gem install chef -v 12.10.24"
  bash -l -c "gem install berkshelf -v 5.1.0"
fi &&

# Install cookbook dependencies
bash -l -c "cd cookbooks; for d in ./*/; do (cd \"\$d\" && [ -e Berksfile ] && ${berks_binary} vendor ../ && cd ../); done; cd .."

# Ensure file permissions are set properly
chown -R ${user_name} /home/${user_name}
chown -R ${user_name} /usr/local/rvm

# Orchistrate system based on bundled cookbooks
bash -l -c "rvmsudo chef-solo -c solo.rb"
