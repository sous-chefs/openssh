name              "openssh"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs openssh"
version           "1.2.3"

recipe "openssh", "Installs openssh"
recipe "openssh::iptables", "Set up iptables to allow SSH inbound"

%w{ redhat centos fedora ubuntu debian arch scientific suse }.each do |os|
  supports os
end

depends "iptables"
