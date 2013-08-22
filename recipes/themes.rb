#
# Cookbook Name:: redmine
# Recipe:: themes
#
# Author:: John Hopkins <john.hopkins@alere.com>
#
# Copyright 2013, Alere, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node["redmine"]["themes"]["enabled"]
  node["redmine"]["themes"]["git"].each do |theme|
    git "#{node['redmine']['path']}/public/themes/#{theme['name']}" do
      repository theme["repository"]
      reference theme["reference"]
      action :sync
    end

    directory "#{node['redmine']['path']}/public/themes/#{theme['name']}" do
      owner node['apache']['user']
      group node['apache']['group']
      mode '0755'
      recursive true
    end
  end
  
  template "#{node['redmine']['path']}/config/settings.yml" do
    source "settings.yml.erb"
  end
end
