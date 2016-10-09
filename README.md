# Chef Solo Bootstrapper Template

Make a copy of this repo for each server you want.  Then configure that copy to your liking.  Then apply the bootstrapping to the new VM you create.  

To apply the bootstrapping, follow these steps:

###### Usage/ Testing
1.  Create a new VM with some username
2.  Allow passwordless sudo for that username `myusername ALL=(ALL) NOPASSWD: ALL`
3.  Setup a .ssh/config entry for logging into the new machine
4.  Run `./deploy.sh new-server-host`


###### The first time, Under the Hood:

1.  The .sh script copies the chef files over to the remote machine via ssh
2.  Chef is installed on the remote machine
3.  `chef-solo -c solo.rb -j solo.json` is run on the remote machine which will install the chef recipe

Ref:  http://www.opinionatedprogrammer.com/2011/06/chef-solo-tutorial-managing-a-single-server-with-chef/





