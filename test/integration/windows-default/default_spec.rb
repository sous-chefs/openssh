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
script_stderr = <<-EOF
  Start-Process ssh "-oStrictHostKeyChecking=no -oPasswordAuthentication=no -v localhost" -NoNewWindow -Wait -RedirectStandardOutput stdOut.log -RedirectStandardError stdErr.log; gc stdErr.log; rm *.log
EOF

describe powershell(script_stderr) do
  # No way of actually sshing in without a keypair or password
  # but being prompted for an authentication method should be sufficient to
  # test that SSH is working as expected, for the most part
  its('stdout') { should match /Next authentication method/ }
end

script_stdout = <<-EOF
  Start-Process ssh "-oStrictHostKeyChecking=no -oPasswordAuthentication=no -v localhost" -NoNewWindow -Wait -RedirectStandardOutput stdOut.log -RedirectStandardError stdErr.log; gc stdOut.log; rm *.log
EOF

describe powershell(script_stdout) do
  # No way of actually sshing in without a keypair or password
  # but being prompted for an authentication method should be sufficient to
  # test that SSH is working as expected, for the most part
  its('stdout') { should eq '' }
end
