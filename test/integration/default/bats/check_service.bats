@test 'check sshd service' {
  ps -ef | grep -v grep |grep sshd
}
