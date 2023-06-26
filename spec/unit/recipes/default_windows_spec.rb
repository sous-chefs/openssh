require 'spec_helper'

describe 'openssh::default' do
  context 'Windows' do
    platform 'windows', '2016'

    let(:ssh_config_path) { join_path('C:\\ProgramData\\ssh', 'ssh_config') }
    let(:sshd_config_path) { join_path('C:\\ProgramData\\ssh', 'sshd_config') }

    describe 'ssh_config' do
      it 'writes the ssh_config' do
        template = chef_run.template(ssh_config_path)
          expect(template).to be
      end
    end

    describe 'sshd_config' do
      it 'writes the sshd_config' do
        template = chef_run.template(sshd_config_path)
          expect(template).to be
      end
        
      it 'allow legacy default AuthorizedKeysFile behavior' do
        expect(chef_run).to_not render_file(sshd_config_path).with_content(/AuthorizedKeysFile.*/)
      end

      it 'writes a match group block' do
        chef_run.node.override['openssh']['server']['match'] = { 'Group admins' => { 'permit_tunnel' => 'yes' } }
        chef_run.converge('openssh::default')
        expect(chef_run).to render_file(sshd_config_path).with_content(/Match Group admins\n\s\sPermitTunnel yes/)
      end
  
      it 'skips match group block' do
        chef_run.node.override['openssh']['server']['match'] = {}
        chef_run.converge('openssh::default')
        expect(chef_run).to_not render_file(sshd_config_path).with_content(/Match Group admins\n\s\sPermitTunnel yes/)
      end
  
      it 'write multiple SSH subsystems from Hash' do
        chef_run.node.override['openssh']['server']['subsystem'] = {
          sftp: '/usr/lib/openssh/sftp-server',
          test: '/my/subsystem/bin',
        }
        chef_run.converge('openssh::default')
        expect(chef_run).to render_file(sshd_config_path).with_content(%r{Subsystem sftp \/usr\/lib\/openssh\/sftp-server\nSubsystem test.*})
      end
  
      it 'skips subsystems block' do
        chef_run.node.override['openssh']['server']['subsystem'] = {}
        chef_run.converge('openssh::default')
        expect(chef_run).to_not render_file(sshd_config_path).with_content(/^Subsystem?/)
      end
  
      it 'supports legacy subsystem format' do
        chef_run.node.override['openssh']['server']['subsystem'] = 'sftp /usr/lib/openssh/sftp-server'
        chef_run.converge('openssh::default')
        expect(chef_run).to render_file(sshd_config_path).with_content(%r{Subsystem sftp \/usr\/lib\/openssh\/sftp-server\n})
      end
  
      it 'allows subsystem from Array attribute' do
        chef_run.node.override['openssh']['server']['subsystem'] = [
          'sftp /usr/lib/openssh/sftp-server',
          'test /my/subsystem/bin',
        ]
        chef_run.converge('openssh::default')
        expect(chef_run).to render_file(sshd_config_path).with_content(%r{Subsystem sftp \/usr\/lib\/openssh\/sftp-server\nSubsystem test.*})
      end
  
      context 'port set without listen address set' do
        cached(:chef_run) do
          ChefSpec::SoloRunner.new(platform: 'windows', version: '2016') do |node|
            node.normal['openssh']['server']['port'] = 1234
          end.converge('openssh::default')
        end
  
        it 'writes out port at the top of the config' do
          expect(chef_run).to render_file(sshd_config_path)
            .with_content(/# Do NOT modify this file by hand!\n\nPort 1234/)
        end
      end
  
    end

  end  
end