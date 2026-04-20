# frozen_string_literal: true

require_relative '../../spec_helper'

control 'openssh-server-package-01' do
  impact 1.0
  title 'The server package is installed'

  describe package(openssh_server_package_name) do
    it { should be_installed }
  end
end

control 'openssh-server-config-01' do
  impact 0.7
  title 'The server configuration exists with the expected defaults'

  describe file('/etc/ssh/sshd_config') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('content') { should match(/^ChallengeResponseAuthentication no$/) }
    its('content') { should match(/^UsePAM yes$/) }
    its('content') { should match(/^Subsystem sftp #{Regexp.escape(openssh_sftp_subsystem)}$/) }
  end
end

control 'openssh-server-service-01' do
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

control 'openssh-server-firewall-01' do
  impact 0.5
  title 'The firewall rules allow SSH traffic'

  describe iptables do
    it { should have_rule('-A INPUT -p tcp -m tcp --dport 22 -j ACCEPT') }
    it { should have_rule('-A OUTPUT -p tcp -m tcp --sport 22 -j ACCEPT') }
  end
end
