require 'spec_helper'

describe 'openssh::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge(described_recipe) }

  it 'installs the openssh packages' do
    expect(chef_run).to install_package('openssh-client')
    expect(chef_run).to install_package('openssh-server')
  end

  it 'starts the ssh service' do
    expect(chef_run).to start_service('ssh')
    expect(chef_run).to set_service_to_start_on_boot('ssh')
  end

  it 'writes the ssh_config' do
    template = chef_run.template('/etc/ssh/ssh_config')
    expect(template).to be
    expect(template.mode).to eq('0644')
    expect(template.owner).to eq('root')
    expect(template.group).to eq('root')
  end

  describe 'sshd_config' do

    it 'writes the sshd_config' do
      template = chef_run.template('/etc/ssh/sshd_config')
      expect(template).to be
      expect(template.mode).to eq('0644')
      expect(template.owner).to eq('root')
      expect(template.group).to eq('root')
    end

    it 'writes a match group block' do
      chef_run.node.set['openssh']['server']['match'] = { 'Group admins' => { 'permit_tunnel' => 'yes' } }
      chef_run.converge(described_recipe)
      expect(chef_run).to create_file_with_content '/etc/ssh/sshd_config', /Match Group admins\n\s\sPermitTunnel yes/
    end

  end
end
