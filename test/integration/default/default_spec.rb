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

describe ssh_config do
  its('UseRoaming') { should eq 'no' }
end
