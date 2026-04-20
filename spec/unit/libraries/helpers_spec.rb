# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../libraries/helpers'

describe Openssh::Helpers do
  let(:helper_class) do
    Class.new do
      include Openssh::Helpers

      attr_accessor :node

      def platform_family?(*families)
        families.include?(node['platform_family'])
      end

      def platform?(*platforms)
        platforms.include?(node['platform'])
      end
    end
  end

  let(:helper) { helper_class.new }

  describe '#default_service_name' do
    it 'returns ssh on ubuntu' do
      helper.node = {
        'platform' => 'ubuntu',
        'platform_family' => 'debian',
        'platform_version' => '24.04',
      }

      expect(helper.default_service_name).to eq('ssh')
    end

    it 'returns sshd on rocky' do
      helper.node = {
        'platform' => 'rocky',
        'platform_family' => 'rhel',
        'platform_version' => '9',
      }

      expect(helper.default_service_name).to eq('sshd')
    end
  end

  describe '#build_server_options' do
    before do
      helper.node = {
        'platform' => 'ubuntu',
        'platform_family' => 'debian',
        'platform_version' => '24.04',
        'network' => {
          'interfaces' => {
            'eth0' => {
              'addresses' => {
                '192.0.2.10' => { 'family' => 'inet' },
              },
            },
          },
        },
      }
    end

    it 'places port first and resolves listen interfaces' do
      options = helper.build_server_options(
        base_options: { 'use_p_a_m' => 'yes' },
        port: [22, 2222],
        ca_keys_path: '/etc/ssh/ca_keys',
        revoked_keys_path: '/etc/ssh/revoked_keys',
        listen_interfaces: { eth0: 'inet' }
      )

      expect(options.first).to eq(['port', [22, 2222]])
      expect(options['listen_address']).to eq(['192.0.2.10'])
      expect(options['trusted_user_c_a_keys']).to eq('/etc/ssh/ca_keys')
      expect(options['revoked_keys']).to eq('/etc/ssh/revoked_keys')
    end
  end

  describe '#supported_ssh_host_keys' do
    it 'uses modern linux host keys' do
      helper.node = {
        'platform' => 'ubuntu',
        'platform_family' => 'debian',
        'platform_version' => '24.04',
      }

      expect(helper.supported_ssh_host_keys).to eq(
        %w(
          /etc/ssh/ssh_host_rsa_key
          /etc/ssh/ssh_host_ecdsa_key
          /etc/ssh/ssh_host_ed25519_key
        )
      )
    end
  end
end
