#
# Cookbook Name:: openssh
# Attribute:: default
#
# Author:: Jesse Howarth (<him@jessehowarth.com>)
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

default[:openssh][:server][:Protocol]                        = 2
default[:openssh][:server][:SyslogFacility]                  = "AUTHPRIV"
default[:openssh][:server][:PasswordAuthentication]          = "yes"
default[:openssh][:server][:ChallengeResponseAuthentication] = "no"
default[:openssh][:server][:GSSAPIAuthentication]            = "yes"
default[:openssh][:server][:GSSAPICleanupCredentials]        = "yes"
default[:openssh][:server][:UsePAM]                          = "yes"
default[:openssh][:server][:X11Forwarding]                   = "yes"
default[:openssh][:server][:Subsystem]                       = "sftp	/usr/libexec/openssh/sftp-server"
default[:openssh][:server][:AcceptEnv]                       = "LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT LC_IDENTIFICATION LC_ALL LANGUAGE XMODIFIERS"
