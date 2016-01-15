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

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 22 -j ACCEPT') }
end
