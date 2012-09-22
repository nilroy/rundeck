#
# Cookbook Name:: wt_streaming_viz
# Recipe:: uninstall
# Author: Kendrick Martin(<kendrick.martin@webtrends.com>)
#
# Copyright 2012, Webtrends
#
# All rights reserved - Do Not Redistribute
# This recipe uninstalls all DX versions

app_pool = node['wt_streaming_viz']['app_pool']
install_dir = "#{node['wt_common']['install_dir_windows']}\\Webtrends.Streaming.Viz"
log_dir = "#{node['wt_common']['install_dir_windows']}\\logs"

# remove the app
iis_app 'StreamingViz' do
	path "/"
	application_pool "#{app_pool}"
	action :delete
end

# remove the site
iis_site 'StreamingViz' do
	action [:stop, :delete]
end

# remove the pool
iis_pool app_pool do
    action [:stop, :delete]
    # ignore errors for now since the resource search will match CAMService when searching for CAM (this is fixed in IIS cookbook v1.2)
    ignore_failure true
end

directory install_dir do
  recursive true
  action :delete
end

directory log_dir do
  recursive true
  action :delete
end