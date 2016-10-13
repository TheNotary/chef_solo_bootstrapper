# Chef Solo Bootstrapper Template

Make a copy of this repo for each server you want.  Then configure that copy to your liking.  Then apply the bootstrapping to the server when you'd like to have it configured by Opscode Chef.  

## Usage/ Testing

To apply the bootstrapping to a brand new server such that it's configured exactly how you want it, follow these steps:

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

Running the deploy script consecutively should have no adverse effects on the system and should only apply new changes that have been made to the cookbooks run against the server.  


## Overview of System Orchestration

Lets say you have two servers; a home server and a raspberry pi security camera server.  To manage these servers without the need to maintain a third chef server, you would create a copy of this repo for each of these servers, one named bootstrap_for_home_server and another boot_strap_for_security_cam.  
  
From there, to customize the repo to install the specific packages to each of these server's needs, you would create a new cookbook in the cookbooks folder named say home_server.  Within those cookbooks you would define the configurations you desire.  These cookbooks could be pushed up to your git server as independant works of code-art.  Code shared between servers should be put into a seperate cookbook named after the stuff it does such as `unix_system_customizations`.  

## Auxiliary Materials

It's fun to use vagrant to test this chef repo.  You might be interested in my humble [chef_tester vagrant box](https://github.com/TheNotary/chef_tester).

This repo was appreciatively devised with help from:  
* https://www.youtube.com/watch?v=MHPpDdtqctM
* http://www.opinionatedprogrammer.com/2011/06/chef-solo-tutorial-managing-a-single-server-with-chef/
