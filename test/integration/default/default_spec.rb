service_name = if os.debian?
                 'ssh'
               else
                 'sshd'
               end

use_roaming_value = if os.redhat? && os[:release].to_i < 7
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

describe file('/var/run/sshd') do
  it { should be_directory }
  it { should be_mode 0755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe ssh_config do
  its('UseRoaming') { should eq use_roaming_value }
end
