# solo.rb is the config file for chef-solo.  Use it to specify where cookbooks
# can be found and various other options.
# By default you can find it in /etc/chef/solo.rb but you can use the -c switch
# when calling chef-solo to point to an alternate location

root = File.absolute_path(File.dirname(__FILE__))

file_cache_path root
cookbook_path [ "#{root}/cookbooks", "#{root}/../.berkshelf/cookbooks"]

json_attribs "#{root}/node.json"
