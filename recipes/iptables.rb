#
# Cookbook:: openssh
# Recipe:: iptables
#
# Copyright:: 2013-2019, Chef Software, Inc.
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

iptables_packages 'install iptables'
iptables_service 'start iptables'

sshd_port = if node['openssh'].attribute?('server') && node['openssh']['server'].attribute?('port')
              if node['openssh']['server']['port'].is_a?(Array)
                node['openssh']['server']['port']
              else
                [node['openssh']['server']['port']]
              end
            else
              [22]
            end

sshd_port.each do |port|
  iptables_rule 'ssh_input' do
    chain :INPUT
    jump 'ACCEPT'
    protocol 'tcp'
    match 'tcp'
    extra_options "--dport #{port}"
  end

  iptables_rule 'ssh_output' do
    chain :OUTPUT
    jump 'ACCEPT'
    protocol 'tcp'
    match 'tcp'
    extra_options "--sport #{port}"
  end
end
