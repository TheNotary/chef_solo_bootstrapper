# Chef Solo Bootstrapper Template

Make a copy of this repo for each server you want.  Then configure that copy to your liking.  Then apply the bootstrapping to the server when you'd like to have it configured by Opscode Chef.  

## Usage/ Testing

To apply the bootstrapping, follow these steps:

1.  Create a new VM with some username
2.  On the chef target, allow passwordless sudo for that username `myusername ALL=(ALL) NOPASSWD: ALL`
3.  Setup a .ssh/config entry for logging into the new machine and do the appropriate `ssh-copy-id -i ~/.ssh/YOUR_PUB_KEY new-server-host` command to allow passwordless login
4.  Run `./deploy.sh new-server-host`


## How it Works
The first time you run the `deploy.sh` script, Under the Hood...

1.  The .sh script copies the chef files over to the remote machine via ssh
2.  Chef is installed on the remote machine
3.  `sudo chef-solo -c solo.rb -j node.json` is run on the remote machine which will install the chef recipe
4.  The runlist within `node.json` is consulted, and each cookbook specified there is deployed from `cookbooks/`


## Auxiliary Materials

It's fun to use vagrant to test this chef repo.  You might be interested in my humble [chef_tester vagrant box](https://github.com/TheNotary/chef_tester).

This repo was appreciatively devised with help from:  
* https://www.youtube.com/watch?v=MHPpDdtqctM
* http://www.opinionatedprogrammer.com/2011/06/chef-solo-tutorial-managing-a-single-server-with-chef/
