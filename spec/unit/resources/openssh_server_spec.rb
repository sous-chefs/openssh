# frozen_string_literal: true

require 'spec_helper'

describe 'openssh_server' do
  step_into :openssh_server
  platform 'ubuntu', '24.04'

  let(:ca_key) do
    'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJt7VN0YkI2jVnWUod8I/Qy9Am4lq0VOmFUTbzrMVTM8iut8E7heWu8G5QsDFLi3BNcU5wnwWO8rTWZZh1CJq6+zVn010rUYZhDxjlvFD4ZOUrN4RqsxSPBAaW2tgNXwoNeBgx/ZIrDSqj1xKP2Dixri2AxAuTQvxLn249dAv6MRwBGWJDtqOo0606VdQ933lq7eoYy57wvLtHBQHqZnjboIUtBxQTLyHrGTc0UdUrWRTtU8geynX2ABRWYKrHsXixgqPcYiiJOyrMufQEWzXr4u6PQs5LiSVsM9b6n8Aq184LDJiybDhQXEYnO8VeCV8v8GaDOGV4HB9W/15Fpxd/ ca'
  end

  let(:revoked_key) do
    'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeNFbS05i75Na662aH5uzXvdWqWxLELs1kEy3L60EYJpZ9GzJ4ByR7Gk2EQE5Knvpm/ck3en6ef1nyJzniELrPwO1OwVqVfNGjiz+4cl9EjReuk+wKWhoHpM2clEpp52Kl0TSBKt+oDCsv0REc0uSyi7rWkQSuRqnZvoxx3M7UIWJhMpFYKM2Few8c90ckHG4SY1Qcj2E/zI5ueVDz/jRfogF10dgSC8J4H6OO9+4N42EASQDbWFx1CO5jqB+1dmf3/7KbvdZUsO9zF1D5Kphk+bLm4SnIQsOJE5cfnqSNIvP6UcW2gNxHD4inxGQvz5Gljk3yYZ7n6HwDHo7hukpP user'
  end

  context 'with default properties' do
    recipe do
      openssh_server 'default'
    end

    it { is_expected.to install_package('openssh-server') }
    it { is_expected.to create_directory('/run/sshd') }
    it { is_expected.to enable_service('ssh') }
    it { is_expected.to start_service('ssh') }

    it do
      is_expected.to create_file('/etc/ssh/sshd_config').with(
        mode: '0644',
        owner: 'root',
        group: 'root'
      )
    end

    it { is_expected.to render_file('/etc/ssh/sshd_config').with_content(/^ChallengeResponseAuthentication no$/) }
    it { is_expected.to render_file('/etc/ssh/sshd_config').with_content(/^UsePAM yes$/) }
  end

  context 'with custom ports and trust data' do
    recipe do
      openssh_server 'default' do
        port [1234, 1235]
        ca_keys ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJt7VN0YkI2jVnWUod8I/Qy9Am4lq0VOmFUTbzrMVTM8iut8E7heWu8G5QsDFLi3BNcU5wnwWO8rTWZZh1CJq6+zVn010rUYZhDxjlvFD4ZOUrN4RqsxSPBAaW2tgNXwoNeBgx/ZIrDSqj1xKP2Dixri2AxAuTQvxLn249dAv6MRwBGWJDtqOo0606VdQ933lq7eoYy57wvLtHBQHqZnjboIUtBxQTLyHrGTc0UdUrWRTtU8geynX2ABRWYKrHsXixgqPcYiiJOyrMufQEWzXr4u6PQs5LiSVsM9b6n8Aq184LDJiybDhQXEYnO8VeCV8v8GaDOGV4HB9W/15Fpxd/ ca']
        revoked_keys ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeNFbS05i75Na662aH5uzXvdWqWxLELs1kEy3L60EYJpZ9GzJ4ByR7Gk2EQE5Knvpm/ck3en6ef1nyJzniELrPwO1OwVqVfNGjiz+4cl9EjReuk+wKWhoHpM2clEpp52Kl0TSBKt+oDCsv0REc0uSyi7rWkQSuRqnZvoxx3M7UIWJhMpFYKM2Few8c90ckHG4SY1Qcj2E/zI5ueVDz/jRfogF10dgSC8J4H6OO9+4N42EASQDbWFx1CO5jqB+1dmf3/7KbvdZUsO9zF1D5Kphk+bLm4SnIQsOJE5cfnqSNIvP6UcW2gNxHD4inxGQvz5Gljk3yYZ7n6HwDHo7hukpP user']
      end
    end

    it do
      is_expected.to render_file('/etc/ssh/sshd_config')
        .with_content(/^Port 1234$/)
        .with_content(/^Port 1235$/)
    end

    it { is_expected.to create_file('/etc/ssh/ca_keys') }
    it { is_expected.to create_file('/etc/ssh/revoked_keys') }
    it { is_expected.to render_file('/etc/ssh/ca_keys').with_content(/#{Regexp.escape(ca_key)}/) }
    it { is_expected.to render_file('/etc/ssh/revoked_keys').with_content(/#{Regexp.escape(revoked_key)}/) }
  end
end
