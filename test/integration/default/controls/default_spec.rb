# frozen_string_literal: true

require_relative '../../spec_helper'

control 'openssh-default-packages-01' do
  impact 1.0
  title 'The client and server packages are installed'

  describe package(openssh_client_package_name) do
    it { should be_installed }
  end

  describe package(openssh_server_package_name) do
    it { should be_installed }
  end
end

control 'openssh-default-client-config-01' do
  impact 0.7
  title 'The client configuration is rendered with the expected defaults'

  describe file('/etc/ssh/ssh_config') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('content') { should match(/^Host \*$/) }
    its('content') { should match(/^UseRoaming no$/) }
  end
end

control 'openssh-default-server-config-01' do
  impact 0.7
  title 'The server configuration is rendered with the expected defaults'

  describe file('/etc/ssh/sshd_config') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('content') { should match(/^ChallengeResponseAuthentication no$/) }
    its('content') { should match(/^Subsystem sftp #{Regexp.escape(openssh_sftp_subsystem)}$/) }
  end
end

control 'openssh-default-service-01' do
  impact 0.5
  title 'The SSH service is enabled and listening'

  describe service(openssh_service_name) do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(22) do
    it { should be_listening }
  end
end
