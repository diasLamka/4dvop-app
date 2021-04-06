#
# Cookbook:: nginx
# Recipe:: server
#
# Copyright:: 2020, The Authors, All Rights Reserved.

package 'nginx' 
package 'git'

directory '/usr/share/nginx/html/' do
  action :delete
  recursive true
end

git '/usr/share/nginx/html/' do
  repository 'https://github.com/diranetafen/static-website-example.git'
  revision 'master'
  action :sync
end

execute 'change nginx listen port for 8080' do
  command "sed -i 's/80 default_server/8080 default_server/g' /etc/nginx/sites-enabled/default"
end

ruby_block "Replace port" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/nginx/nginx.conf")
    fe.search_file_replace_line(/80 default_server/,
                               "listen *:8080 default_server;")
    fe.write_file
  end
end

service 'nginx' do
  action [:start, :enable]
end
