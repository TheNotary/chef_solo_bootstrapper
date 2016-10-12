# --- Install packages we need ---
package 'ntp'
package 'sysstat'
package 'git'
package 'make'
package 'gcc'

# --- Set host name ---
# Note how this is plain Ruby code, so we can define variables to
# DRY up our code:
# hostname = 'epd-dokku.local'
hostname = 'chef-test-vm.local'
# username is pretty fragile...
username = File.basename(Dir['/home/*'].first)
username = "kentos"

username = "vagrant"

etc_motd_file = ""

etc_motd_file += "#{hostname}\n\nThis server does: \n-Dokku"



#########################
# Put dotfiles in place #
#########################

git "#{ENV['HOME']}/dotfiles" do
  repository "https://github.com/TheNotary/dotfiles.git"
  action :checkout
end

# you still need to run ./make.sh as the actual non-root user acct though...
execute "#{ENV['HOME']}/dotfiles/make.sh" do
  command "#{ENV['HOME']}/dotfiles/make.sh"
  # user username
  cwd "#{ENV['HOME']}/dotfiles"
  creates "#{ENV['HOME']}/.my_aliases"
end

["#{ENV['HOME']}/.this_machine", "/home/#{username}/.this_machine"].each do |this_machine_path|
  file this_machine_path do
    content "bash_display_style=server"
    action :create_if_missing
  end
end



######################
# Install Containers #
######################

# MOTD
etc_motd_file += "\n\nThis server also hosts the following dockerized services:"

["/home/#{username}/dev", "/home/#{username}/dev/docker_repos", "/docker_data"].each do |dir|
  directory dir do
    owner username
    group username
    mode '0755'
    action :create
  end
end


# Open VPN Server
etc_motd_file += "  -openvpn server\n"

git "/home/#{username}/dev/docker_repos/docker-openvpn" do
  repository "https://github.com/TheNotary/docker-openvpn.git"
  action :checkout
end

# execute "build openvpn container" do
#   command "make build"
#   environment({ "OVPN_DATA" => "ovpn-data"})
#   cwd "/home/#{username}/dev/docker_repos/docker-openvpn"
#   user username
# end

# FIXME: this step can't be automated because it requests a password...
# execute "create configurations for openvpn" do
#   command "make configure"
#   environment({"OVPN_DATA"=>"ovpn-data"})
#   cwd "/home/#{username}/dev/docker_repos/docker-openvpn"
#   # user username
#   creates "/home/#{username}/dev/docker_repos/docker-openvpn/CLIENTNAME.ovpn"
# end

# And running it from chef will cause issue too...

# https://docs.docker.com/engine/admin/host_integration/

file '/etc/systemd/system/openvpn-docker.service' do
  content <<-HEREDOC

  HEREDOC
end



# Write out managed Files

file '/etc/motd' do
  content etc_motd_file
end


# execute "#{ENV['HOME']}/dotfiles/make.sh" do
#   # user username
#   cwd "#{ENV['HOME']}/dotfiles"
# end
# wget https://raw.githubusercontent.com/dokku/dokku/v0.7.0/bootstrap.sh
# sudo DOKKU_TAG=v0.7.0 bash bootstrap.sh
