#
# Cookbook Name:: auth-proxy
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'nodejs'
include_recipe 'redis::server'
include_recipe 'git'

execute "install-dependencies" do
  cwd "/opt/auth-proxy"
  command "npm install"
  action :nothing
end

git "/opt/auth-proxy" do
  repository "https://github.com/tizzo/auth-proxy.git"
  reference "master"
  action :sync
  notifies :run, "execute[install-dependencies]", :immediately
end

config = node['auth_proxy']['config'].to_hash

routes = data_bag("proxy_routes")
routes_data = []

routes.each do |route_id|
  routes_data << data_bag_item("proxy_routes", route_id).to_hash
end

config.merge!({:routes => routes_data})

file "/opt/auth-proxy/config.json" do
  content config.to_json
  notifies :restart, "service[auth-proxy]"
end

execute "reload-upstart-config" do
  command "initctl reload-configuration"
  action :nothing
end

link "/etc/init/auth-proxy.conf" do
  to "/opt/auth-proxy/init/upstart.conf"
  notifies :run, "execute[reload-upstart-config]", :immediately
end

service "auth-proxy" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end
