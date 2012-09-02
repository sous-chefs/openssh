#
# Cookbook Name:: openssh
# Recipe:: config
#
# Copyright 2008-2009, Opscode, Inc.
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

listen_interfaces = node['openssh']['listen_interfaces']
if listen_interfaces
  node.set['openssh']['listen_addresses'] = listen_interfaces.map do |interface|
    interface_node = node["network"]["interfaces"][interface]["addresses"]

    interface_node.select { |address, data| data["family"] == "inet" }[0][0]
  end
end

template node['openssh']['config'] do
  source "sshd_config.erb"
  mode   "0640"

  notifies :restart, resources(:service => "ssh")

  ### At this time only supporting Debian/Ubuntu based systems.
  only_if { platform? %w{debian ubuntu} }
end
