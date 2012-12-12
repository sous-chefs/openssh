name              "openssh"
maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Installs openssh"
version           "1.1.2"

recipe "openssh", "Installs openssh"

%w{ redhat centos fedora ubuntu debian arch scientific }.each do |os|
  supports os
end
