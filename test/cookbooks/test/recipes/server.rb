# frozen_string_literal: true

apt_update 'update' if platform_family?('debian')

openssh_server 'default'
openssh_firewall 'default'

file '/etc/ssh/openssh-test-reload' do
  content 'Exercises openssh_server :reload on first converge'
  notifies :reload, 'openssh_server[default]', :delayed
end
