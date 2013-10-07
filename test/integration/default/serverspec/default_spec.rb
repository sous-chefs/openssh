require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe 'openssh::default' do
  it 'starts the ssh service' do
    case backend(Serverspec::Commands::Base).check_os
    when 'Debian'
      expect(service('ssh')).to be_enabled
      expect(service('ssh')).to be_running
    when 'RedHat'
      expect(service('sshd')).to be_enabled
      expect(service('sshd')).to be_running
    end
  end

  it 'is listening on the configured port' do
    expect(port(22)).to be_listening
  end
end
