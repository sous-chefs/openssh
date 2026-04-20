# frozen_string_literal: true

def openssh_service_name
  %w(debian ubuntu).include?(os[:family]) ? 'ssh' : 'sshd'
end

def openssh_client_package_name
  %w(debian ubuntu).include?(os[:family]) ? 'openssh-client' : 'openssh-clients'
end

def openssh_server_package_name
  'openssh-server'
end

def openssh_sftp_subsystem
  %w(debian ubuntu).include?(os[:family]) ? '/usr/lib/openssh/sftp-server' : '/usr/libexec/openssh/sftp-server'
end
