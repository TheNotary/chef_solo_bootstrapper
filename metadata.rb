# This is the main information file of your Chef repo.  
# It's one of the places you specify the cookbooks you depend upon.
# FIXME:  this file is only relevant to actual cookbooks and thus isn't needed
# at all

name             'name-of-server'
maintainer       'YOUR_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures name-of-server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "hostname"
