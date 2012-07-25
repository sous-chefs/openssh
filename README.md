Description
===========

Installs openssh and provides a template to configure specific sshd_config options.

Requirements
============

## Platform:

* Debian/Ubuntu
* RHEL/CentOS/Scientific
* Fedora
* ArchLinux

Recipes
=======

default
-------

Selects the packages to install by package name and manages the sshd
service.

Attributes
==========

This cookbook uses a couple of attributes, broken up into two different kinds.

Platform specific
-----------------

* `node[:openssh][:permit_root_login]` - Whether to allow root to login via ssh. Default: 'yes', on RHEL/CentOS/Scientific 'without-password'
  Possible arguments are `yes`, `without-password`, `forced-commands-only`, or `no`.

General settings
----------------

* `node[:openssh][:port]` - Port to listen on. Default: 22
* `node[:openssh][:ipv4_listen_addr]` - IPv4 listening address. Default: 0.0.0.0
* `node[:openssh][:log_level]` - The sshd's log level. Default: INFO
  Possible values are: QUIET, FATAL, ERROR, INFO, VERBOSE, DEBUG, DEBUG1, DEBUG2, and DEBUG3
* `node[:openssh][:login_grace_time]` - Grace time during login until the session gets terminated. Default: 120s
* `node[:openssh][:password_authentication]` - Whether to allow password authentication or not. Default: yes
* `node[:openssh][:permit_empty_passwords]` - If password authentication is enabled whether to allow empty passwords. Default: no

Usage
=====

Ensure that the openssh packages are installed and the service is
managed with `recipe[openssh]`.

License and Author
==================

Author:: Adam Jacob <adam@opscode.com>  
Author:: Mike Adolphs <mike@fooforge.com>

Copyright:: 2008-2012, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
