require 'spec_helper'

describe 'openssh::iptables' do
  context 'default attribute, no port set' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'renders the iptables rule in a template' do
      expect(chef_run).to create_template('/etc/iptables.d/port_ssh')
    end

    it 'contains the default port (22) for sshd' do
      expect(chef_run).to render_file('/etc/iptables.d/port_ssh').
        with_content('-A FWR -p tcp -m tcp --dport 22 -j ACCEPT')
    end
  end

  context 'non-default port set' do
    let(:chef_run) do
      ChefSpec::Runner.new do |node|
        node.set['openssh']['server']['port'] = '4242'
      end.converge(described_recipe)
    end

    it 'contains the non-default port from the attribute' do
      expect(chef_run).to render_file('/etc/iptables.d/port_ssh').
        with_content('-A FWR -p tcp -m tcp --dport 4242 -j ACCEPT')
    end
  end
end
