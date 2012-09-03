maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs openssh"
version           "0.8.1"

recipe "openssh", "Installs openssh"

%w{ redhat centos fedora ubuntu debian arch scientific }.each do |os|
  supports os
end

attribute "openssh/config",
  :description => "Specifies the name of the configuration file.",
  :default => "/etc/ssh/sshd_config"

attribute "openssh/port",
  :description => "Specifies the port on which the server listens for connections.",
  :default => "22"

attribute "openssh/permit_root_login",
  :description => "Allows root logins",
  :default => "no"

attribute "openssh/password_authentication",
  :description => "Allows password authentication.",
  :default => "no"

attribute "openssh/listen_addresses",
  :description => "An Array containing the local addresses sshd should listen on.  Cannot use with `openssh/listen_interfaces`.",
  :default => ["0.0.0.0"]

attribute "openssh/listen_interfaces",
  :description => "An Array containing the interfaces names (e.g. eth0) sshd should listen on.  The cookbook will determine the IP addresses used by the specified interface(s).  Cannot use with `openssh/listen_addresses`."

attribute "openssh/client_alive_interval",
  :description => "The number of seconds before sshd attempts to disconnect.  Must be used with `openssh/client_alive_count_max`."

attribute "openssh/client_alive_interval",
  :description => "The number of client alive messages.  Must be used with `openssh/client_alive_interval`."
