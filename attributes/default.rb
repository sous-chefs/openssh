#
# Cookbook Name:: openssh
# Attributes:: openssh
#
# Copyright 2012, Opscode, Inc.
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

# Platform-specific settings
case platform
when "redhat","centos","scientific","fedora","suse","amazon"
  default['openssh']['permit_root_login'] = "without-password"
else
  default['openssh']['permit_root_login'] = "yes"
end

# General settings
default['openssh']['ipv4_listen_addr'] = "0.0.0.0"
default['openssh']['port'] = 22
default['openssh']['log_level'] = "INFO"
default['openssh']['login_grace_time'] = 120
default['openssh']['password_authentication'] = true
default['openssh']['permit_empty_passwords'] = false
