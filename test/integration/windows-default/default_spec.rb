include Chef::Mixin::ShellOut

service_name = 'sshd'

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
ssh_cmd = 'ssh -oStrictHostKeyChecking=no -oPasswordAuthentication=no -v localhost'
stderr = shell_out(ssh_cmd).stderr
expected_string = 'Next authentication method'

describe "Command #{ssh_cmd}" do
  it "stderr is expected to include '#{expected_string}'" do
    # No way of actually sshing in without a keypair or password
    # but being prompted for an authentication method should be sufficient to
    # test that SSH is working as expected, for the most part
    expect(stderr).to(include expected_string)
  end
end
