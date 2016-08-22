# --- Install packages we need ---
package 'ntp'
package 'sysstat'
package 'git'

# --- Set host name ---
# Note how this is plain Ruby code, so we can define variables to
# DRY up our code:
hostname = 'epd-dokku.local'
# username is pretty fragile...
username = File.basename(Dir['/home/*'].first)

file '/etc/motd' do
  content "#{hostname}\n\nThis server does: \n-Dokku"
end

file '/etc/hostname' do
  content "#{hostname}\n"
end

service 'hostname.sh' do
  action :restart
end

file '/etc/hosts' do
  content "127.0.0.1 localhost #{hostname}\n"
end


#########################
# Put dotfiles in place #
#########################

git "#{ENV['HOME']}/dotfiles" do
  repository "https://github.com/TheNotary/dotfiles.git"
  action :checkout
end

# you still need to run ./make.sh as the actual non-root user acct though...
execute "#{ENV['HOME']}/dotfiles/make.sh" do
  # user username
  cwd "#{ENV['HOME']}/dotfiles"
end

["#{ENV['HOME']}/.this_machine", "/home/#{username}/.this_machine"].each do |this_machine_path|
  file this_machine_path do
    content "bash_display_style=server"
  end
end
