#
# Cookbook:: openssh
# Recipe:: default
#
# Copyright:: 2008-2019, Chef Software, Inc.
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

def listen_addr_for(interface, type)
  interface_node = node['network']['interfaces'][interface]['addresses']
  interface_node.select { |_address, data| data['family'] == type }.keys[0]
end

package node['openssh']['package_name'] unless node['openssh']['package_name'].empty?

template '/etc/ssh/ssh_config' do
  source 'ssh_config.erb'
  mode '0644'
  owner 'root'
  group node['root_group']
end

if node['openssh']['listen_interfaces']
  listen_addresses = [].tap do |a|
    node['openssh']['listen_interfaces'].each_pair do |interface, type|
      a << listen_addr_for(interface, type)
    end
  end

  node.default['openssh']['server']['listen_address'] = listen_addresses
end

template 'sshd_ca_keys_file' do
  source 'ca_keys.erb'
  path node['openssh']['server']['trusted_user_c_a_keys']
  mode node['openssh']['config_mode']
  owner 'root'
  group node['root_group']
end

template 'sshd_revoked_keys_file' do
  source 'revoked_keys.erb'
  path node['openssh']['server']['revoked_keys']
  mode node['openssh']['config_mode']
  owner 'root'
  group node['root_group']
end

# this will only execute on RHEL / Fedora systems where sshd has never been started
# 99.99% of the time this is going to be a docker container
if keygen_platform? && sshd_host_keys_missing?
  if platform_family?('fedora', 'rhel') && node['platform_version'].to_i >= 8 # fedora and RHEL 8+
    node['openssh']['server']['host_key'].each do |key|
      keytype = key.split('_')[-2]
      execute "/usr/libexec/openssh/sshd-keygen #{keytype}"
    end
  elsif platform_family?('rhel', 'amazon') # RHEL < 8 or Amazon Linux
    execute '/usr/sbin/sshd-keygen'
  elsif platform_family?('suse')
    execute '/usr/sbin/sshd-gen-keys-start'
  end
end

# we probably need this on multiple platforms but we 100% need it on debian based platforms
if platform_family?('debian')
  dir = platform?('ubuntu') && node['platform_version'].to_i >= 18 ? '/run/sshd' : '/var/run/sshd'
  directory dir
end

template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  mode node['openssh']['config_mode']
  owner 'root'
  group node['root_group']
  variables(options: openssh_server_options)
  verify '/usr/sbin/sshd -t -f %{path}'
  notifies :restart, 'service[ssh]'
end

service 'ssh' do
  service_name openssh_service_name
  supports value_for_platform_family(
    %w(debian rhel fedora aix) => [:restart, :reload, :status],
    %w(arch) => [:restart],
    'default' => [:restart, :reload]
  )
  action value_for_platform_family(
    %w(aix) => [:start],
    'default' => [:enable, :start]
  )
end
