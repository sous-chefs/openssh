service_name = case os[:family]
               when 'ubuntu', 'debian'
                 'ssh'
               else
                 'sshd'
               end

describe service(service_name) do
  it { should be_enabled }
  it { should be_running }
end

describe port(22) do
  it { should be_listening }
end

use_roaming = if os[:family] == 'centos' && os[:release].to_i < 7
                nil
              else
                'no'
              end

describe ssh_config do
  its('UseRoaming') { should eq use_roaming }
end
