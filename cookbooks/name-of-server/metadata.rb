# This is the main information file of your Chef repo.  
# It's one of the places you specify the cookbooks you depend upon.

name 'name-of-server'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'all_rights'
description 'Installs/Configures name-of-server'
long_description 'Installs/Configures name-of-server'
version '0.1.0'

depends 'hostname'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/name-of-server/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/name-of-server' if respond_to?(:source_url)
