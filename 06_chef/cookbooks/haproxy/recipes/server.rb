#
# Cookbook:: haproxy
# Recipe:: server
#
# Copyright:: 2020, The Authors, All Rights Reserved.

package 'haproxy'

file '/etc/haproxy/haproxy.cfg' do
  content IO.read('/vagrant_data/4DVOP/06_chef/files/haproxy.cfg')
  action :create
end

service 'haproxy' do
  action [:start, :enable]
end