require 'spec_helper'

describe 'openssh::iptables' do
  context 'default attribute, no port set' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04', step_into: ['iptables_rule']).converge(described_recipe) }

    it 'renders the iptables rule in a template' do
      expect(chef_run).to create_template('/etc/iptables/rules.v4')
    end

    it 'contains the default port (22) for sshd' do
      expect(chef_run).to render_file('/etc/iptables/rules.v4')
        .with_content('-A INPUT -p tcp -m tcp -j ACCEPT --dport 22')
        .with_content('-A OUTPUT -p tcp -m tcp -j ACCEPT --sport 22')
    end
  end

  context 'non-default port set' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(step_into: ['iptables_rule']) do |node|
        node.normal['openssh']['server']['port'] = '4242'
      end.converge(described_recipe)
    end

    it 'contains the non-default port from the attribute' do
      expect(chef_run).to render_file('/etc/iptables/rules.v4')
        .with_content('-A INPUT -p tcp -m tcp -j ACCEPT --dport 4242')
        .with_content('-A OUTPUT -p tcp -m tcp -j ACCEPT --sport 4242')
    end
  end

  context 'supports multiple ports' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '20.04', step_into: ['iptables_rule']) do |node|
        node.normal['openssh']['server']['port'] = [1234, 1235]
      end.converge(described_recipe)
    end

    it 'contains both ports from' do
      expect(chef_run).to render_file('/etc/iptables/rules.v4')
        .with_content('-A INPUT -p tcp -m tcp -j ACCEPT --dport 1234')
        .with_content('-A OUTPUT -p tcp -m tcp -j ACCEPT --sport 1234')
        .with_content('-A INPUT -p tcp -m tcp -j ACCEPT --dport 1235')
        .with_content('-A OUTPUT -p tcp -m tcp -j ACCEPT --sport 1235')
    end
  end
end
