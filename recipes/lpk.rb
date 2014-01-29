# Cookbook Name:: openssh
# Recipe:: lpk
#
# Copyright 2014, Bloomberg Finance L.P.
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

case node['platform_family']
when 'redhat'
  package 'openssh-ldap'
  node.default['openssh']['server']['authorized_keys_command'] = '/usr/libexec/openssh/ssh-ldap-wrapper'
  node.default['openssh']['server']['use_l_p_k'] = 'yes'
  node.default['openssh']['server']['lpk_ldap_conf'] = '/etc/ldap.conf'
else
  # TODO: Use available patches from openssh-lpk for Ubuntu 12.04, etc?
  Chef::Log.warn('OpenSSH LDAP Public Key Authentication is not available on this platform!')
end

