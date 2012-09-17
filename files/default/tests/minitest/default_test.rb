describe_recipe "openssh::default" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "package" do
    it "installs" do
      node['openssh']['package_name'].each do |pkg|
        package(pkg).must_be_installed
      end
    end
  end

  # My test-kitchen VMs don't have 10.14 chef yet [CHEF-3235].
  #describe "files" do
  #  describe "ssh_config" do
  #    let(:config) { file "/etc/ssh/ssh_config" }

  #    describe "has proper modes" do
  #      it { config.must_have(:mode, "644") }
  #      it { config.must_have(:owner, "root") }
  #      it { config.must_have(:group, "root") }
  #    end
  #  end

  #  describe "sshd_config" do
  #    let(:config) { file "/etc/ssh/ssh_config" }

  #    describe "has proper modes" do
  #      it { config.must_have(:mode, "644") }
  #      it { config.must_have(:owner, "root") }
  #      it { config.must_have(:group, "root") }
  #    end
  #  end
  #end

  describe "services" do
    it "runs as a daemon" do
      service(node['openssh']['service_name']).must_be_running
    end

    it "boots on startup" do
      service(node['openssh']['service_name']).must_be_enabled
    end
  end
end
