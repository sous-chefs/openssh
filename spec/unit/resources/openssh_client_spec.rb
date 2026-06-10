# frozen_string_literal: true

require 'spec_helper'

describe 'openssh_client' do
  step_into :openssh_client
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      openssh_client 'default'
    end

    it { is_expected.to install_package('openssh-client') }

    it do
      is_expected.to create_file('/etc/ssh/ssh_config').with(
        mode: '0644',
        owner: 'root',
        group: 'root'
      )
    end

    it { is_expected.to render_file('/etc/ssh/ssh_config').with_content(/^UseRoaming no$/) }
    it { is_expected.to render_file('/etc/ssh/ssh_config').with_content(/^Host \*$/) }
  end

  context 'with custom package_names' do
    recipe do
      openssh_client 'default' do
        package_names %w(openssh-client ssh-askpass)
      end
    end

    it { is_expected.to install_package(%w(openssh-client ssh-askpass)) }
  end
end
