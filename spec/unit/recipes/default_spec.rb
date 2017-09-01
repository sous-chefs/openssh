require 'spec_helper'

describe 'openssh::default on any platform (happens to be Ubuntu)' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge('openssh::default') }

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

    it 'allow legacy default AuthorizedKeysFile behavior' do
      expect(chef_run).to_not render_file('/etc/ssh/sshd_config').with_content(/AuthorizedKeysFile.*/)
    end

    it 'writes a match group block' do
      chef_run.node.normal['openssh']['server']['match'] = { 'Group admins' => { 'permit_tunnel' => 'yes' } }
      chef_run.converge('openssh::default')
      expect(chef_run).to render_file('/etc/ssh/sshd_config').with_content(/Match Group admins\n\s\sPermitTunnel yes/)
    end

    it 'skips match group block' do
      chef_run.node.normal['openssh']['server']['match'] = {}
      chef_run.converge('openssh::default')
      expect(chef_run).to_not render_file('/etc/ssh/sshd_config').with_content(/Match Group admins\n\s\sPermitTunnel yes/)
    end

    context 'port set without listen address set' do
      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.normal['openssh']['server']['port'] = 1234
        end.converge('openssh::default')
      end

      it 'writes out port at the top of the config' do
        expect(chef_run).to render_file('/etc/ssh/sshd_config')
          .with_content(/# Do NOT modify this file by hand!\n\nPort 1234/)
      end
    end

    context 'supports multiple ports' do
      let(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.normal['openssh']['server']['port'] = [1234, 1235]
        end.converge('openssh::default')
      end

      it 'writes both ports to sshd_config' do
        expect(chef_run).to render_file('/etc/ssh/sshd_config')
          .with_content(/Port 1234/)
          .with_content(/Port 1235/)
      end
    end
  end
end

describe 'openssh::default on Debian 8' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'debian', version: '8.5').converge('openssh::default') }

  it 'installs the openssh packages' do
    expect(chef_run).to install_package('openssh-client')
    expect(chef_run).to install_package('openssh-server')
  end

  it 'starts the ssh service' do
    expect(chef_run).to start_service('ssh')
    expect(chef_run).to enable_service('ssh')
  end
end

describe 'openssh::default on Ubuntu 16.04' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04').converge('openssh::default') }

  it 'installs the openssh packages' do
    expect(chef_run).to install_package('openssh-client')
    expect(chef_run).to install_package('openssh-server')
  end

  it 'starts the ssh service' do
    expect(chef_run).to start_service('ssh')
    expect(chef_run).to enable_service('ssh')
  end
end

describe 'openssh::default on CentOS 6.8' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'centos', version: '6.8').converge('openssh::default') }

  it 'installs the openssh packages' do
    expect(chef_run).to install_package('openssh-clients')
    expect(chef_run).to install_package('openssh-server')
  end

  it 'starts the ssh service' do
    expect(chef_run).to start_service('ssh')
    expect(chef_run).to enable_service('ssh')
  end
end

describe 'openssh::default on Fedora' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'fedora', version: '25').converge('openssh::default') }

  it 'installs the openssh packages' do
    expect(chef_run).to install_package('openssh-clients')
    expect(chef_run).to install_package('openssh-server')
  end

  it 'starts the ssh service' do
    expect(chef_run).to start_service('ssh')
    expect(chef_run).to enable_service('ssh')
  end
end

describe 'openssh::default on openSUSE 13' do
  let(:chef_run) { ChefSpec::ServerRunner.new(platform: 'opensuse', version: '13.2').converge('openssh::default') }

  it 'installs the openssh packages' do
    expect(chef_run).to install_package('openssh')
  end

  it 'starts the ssh service' do
    expect(chef_run).to start_service('ssh')
    expect(chef_run).to enable_service('ssh')
  end
end
