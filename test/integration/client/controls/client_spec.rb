# frozen_string_literal: true

require_relative '../../spec_helper'

control 'openssh-client-package-01' do
  impact 1.0
  title 'The client package is installed'

  describe package(openssh_client_package_name) do
    it { should be_installed }
  end
end

control 'openssh-client-config-01' do
  impact 0.7
  title 'The client configuration exists with the expected defaults'

  describe file('/etc/ssh/ssh_config') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('content') { should match(/^Host \*$/) }
    its('content') { should match(/^UseRoaming no$/) }
  end
end
