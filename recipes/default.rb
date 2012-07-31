#
# Cookbook Name:: openssh
# Recipe:: default
#
# Copyright 2008-2012, Opscode, Inc.
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

packages = case node['platform']
  when "centos","redhat","fedora","scientific","amazon"
    %w{openssh-clients openssh}
  when "arch"
    %w{openssh}
  else
    %w{openssh-client openssh-server}
  end

packages.each do |pkg|
  package pkg
end

service "ssh" do
  case node['platform']
  when "centos","redhat","fedora","arch","scientific","amazon"
    service_name "sshd"
  else
    service_name "ssh"
  end
  supports value_for_platform(
    "debian" => { "default" => [ :restart, :reload, :status ] },
    "ubuntu" => {
      "8.04" => [ :restart, :reload ],
      "default" => [ :restart, :reload, :status ]
    },
    "centos" => { "default" => [ :restart, :reload, :status ] },
    "redhat" => { "default" => [ :restart, :reload, :status ] },
    "fedora" => { "default" => [ :restart, :reload, :status ] },
    "scientific" => { "default" => [ :restart, :reload, :status ] },
    "arch" => { "default" => [ :restart ] },
    "default" => { "default" => [:restart, :reload ] }
  )
  action [ :enable, :start ]
end

template "/etc/ssh/sshd_config" do
  source "sshd_config.erb"
  owner "root"
  group "root"
  mode 0644

  variables({
    :ipv4_listen_addr => node['openssh']['ipv4_listen_addr'],
    :port => node['openssh']['port'],
    :log_level => node['openssh']['log_level'],
    :login_grace_time => node['openssh']['login_grace_time'],
    :permit_root_login => node['openssh']['permit_root_login'],
    :permit_empty_passwords => node['openssh']['permit_empty_passwords'],
    :password_authentication => node['openssh']['password_authentication']
    })
  notifies :restart, resources(:service => "ssh")
end
