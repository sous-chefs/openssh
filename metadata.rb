name 'openssh'
maintainer 'Chef Software, Inc.'
maintainer_email 'cookbooks@chef.io'
license 'Apache-2.0'
description 'Installs and configures OpenSSH client and daemon'
version '2.8.1'

%w(aix amazon arch centos fedora freebsd opensuseleap oracle redhat scientific smartos suse ubuntu zlinux).each do |os|
  supports os
end

depends 'iptables', '>= 1.0'

source_url 'https://github.com/chef-cookbooks/openssh'
issues_url 'https://github.com/chef-cookbooks/openssh/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)
