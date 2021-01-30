service_name = if os.debian? || os.darwin?
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

# Attempt to ssh to localhost
describe command('ssh -oStrictHostKeyChecking=no -v localhost') do
  # No way of actually sshing in without a keypair or password
  # but being prompted for an authentication method should be sufficient to
  # test that SSH is working as expected, for the most part
  its('stderr') { should match 'Next authentication method' }
end
