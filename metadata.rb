# frozen_string_literal: true

name              'openssh'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Provides openssh_client, openssh_server, and openssh_firewall resources'
version           '3.0.0'
source_url        'https://github.com/sous-chefs/openssh'
issues_url        'https://github.com/sous-chefs/openssh/issues'
chef_version      '>= 16.0'

supports 'amazon', '>= 2023.0'
supports 'debian', '>= 12.0'
supports 'rocky', '>= 9.0'
supports 'ubuntu', '>= 22.04'

depends 'iptables', '>= 7.0'
