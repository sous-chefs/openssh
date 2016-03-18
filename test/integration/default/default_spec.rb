service_name = case os[:family]
               when 'ubuntu', 'debian'
                 'ssh'
               else
                 'sshd'
               end

use_roaming_value = if os[:family] == 'centos' && os[:release].to_i < 7
                      nil
                    else
                      'no'
                    end

describe service(service_name) do
  it { should be_enabled }
  it { should be_running }
end

describe port(22) do
  it { should be_listening }
end

describe ssh_config do
  its('UseRoaming') { should eq use_roaming_value }
end
