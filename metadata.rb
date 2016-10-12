# This is the main information file of your Chef repo.  
# It's one of the places you specify the cookbooks you depend upon.

name             'home_server'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures my home server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "hostname"
