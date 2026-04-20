# frozen_string_literal: true

require 'spec_helper'

describe 'openssh_firewall' do
  step_into :openssh_firewall
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      openssh_firewall 'default'
    end

    it { is_expected.to install_iptables_packages('install-iptables') }
    it { is_expected.to enable_iptables_service('manage-iptables') }

    it do
      is_expected.to create_iptables_rule('ssh-input-22').with(
        chain: :INPUT,
        jump: 'ACCEPT',
        protocol: 'tcp',
        match: 'tcp',
        extra_options: '--dport 22'
      )
    end

    it do
      is_expected.to create_iptables_rule('ssh-output-22').with(
        chain: :OUTPUT,
        jump: 'ACCEPT',
        protocol: 'tcp',
        match: 'tcp',
        extra_options: '--sport 22'
      )
    end
  end

  context 'with a custom port' do
    recipe do
      openssh_firewall 'default' do
        port 4242
      end
    end

    it { is_expected.to create_iptables_rule('ssh-input-4242').with(extra_options: '--dport 4242') }
    it { is_expected.to create_iptables_rule('ssh-output-4242').with(extra_options: '--sport 4242') }
  end
end
