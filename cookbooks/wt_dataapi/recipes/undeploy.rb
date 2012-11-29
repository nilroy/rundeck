#
# Cookbook Name:: wt_dataapi
# Recipe:: undeploy
#
# Copyright 2012, Webtrends
#
# All rights reserved - Do Not Redistribute
#

log_dir      = "#{node['wt_common']['log_dir_linux']}/dataapi"
install_dir  = "#{node['wt_common']['install_dir_linux']}/dataapi"


runit_service "dataapi" do
    action :disable
    run_restart false
end 

# try to stop the service, but allow a failure without printing the error
service "dataapi" do
  action [:stop, :disable]
  ignore_failure true
end

directory log_dir do
  recursive true
  action :delete
end

directory install_dir do
  recursive true
  action :delete
end