# frozen_string_literal: true

provides :openssh_server
unified_mode true

include Openssh::Helpers

use '_partial/_base'

property :config_path, String, default: lazy { join_path(config_dir, 'sshd_config') }
property :mode, String, default: lazy { default_server_mode }
property :options, Hash, default: lazy { default_server_options }
property :port, [String, Integer, Array, nil], default: nil, coerce: proc { |value| value.nil? ? nil : Array(value).map(&:to_s) }
property :subsystems, [String, Array, Hash], default: lazy { default_server_subsystems }
property :match_blocks, Hash, default: {}
property :listen_interfaces, Hash, default: {}
property :ca_keys, Array, default: []
property :ca_keys_path, String, default: lazy { join_path(config_dir, 'ca_keys') }
property :revoked_keys, Array, default: []
property :revoked_keys_path, String, default: lazy { join_path(config_dir, 'revoked_keys') }
property :package_names, [String, Array], default: lazy { default_server_package_names }
property :sshd_binary, String, default: lazy { default_sshd_binary }
property :service_name, String, default: lazy { default_service_name }
property :manage_service, [true, false], default: true
property :generate_host_keys, [true, false], default: true
property :verify_config, [true, false], default: true

action_class do
  include Openssh::Helpers

  def resolved_options
    build_server_options(
      base_options: new_resource.options,
      port: new_resource.port,
      ca_keys_path: new_resource.ca_keys_path,
      revoked_keys_path: new_resource.revoked_keys_path,
      listen_interfaces: new_resource.listen_interfaces
    )
  end

  def runtime_directory
    default_runtime_directory
  end
end

action :create do
  if new_resource.manage_package
    package new_resource.package_names do
      action :install
    end
  end

  if runtime_directory
    directory runtime_directory do
      recursive true
    end
  end

  file new_resource.ca_keys_path do
    content render_key_file(new_resource.ca_keys, 'One CA public key per line')
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end

  file new_resource.revoked_keys_path do
    content render_key_file(new_resource.revoked_keys, 'One certificate/public key per line')
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end

  execute 'generate-missing-openssh-host-keys' do
    command 'ssh-keygen -A'
    only_if { new_resource.generate_host_keys && host_keys_missing?(resolved_options['host_key']) }
  end

  if new_resource.verify_config
    file new_resource.config_path do
      content lazy { render_server_config(resolved_options, new_resource.subsystems, new_resource.match_blocks) }
      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode
      verify "#{new_resource.sshd_binary} -t -f %{path}"
      notifies :restart, "service[#{new_resource.service_name}]", :delayed if new_resource.manage_service
    end
  else
    file new_resource.config_path do
      content lazy { render_server_config(resolved_options, new_resource.subsystems, new_resource.match_blocks) }
      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode
      notifies :restart, "service[#{new_resource.service_name}]", :delayed if new_resource.manage_service
    end
  end

  service new_resource.service_name do
    supports restart: true, reload: true, status: true
    action %i(enable start)
    only_if { new_resource.manage_service }
  end
end

action :delete do
  service new_resource.service_name do
    supports restart: true, reload: true, status: true
    action %i(stop disable)
    only_if { new_resource.manage_service }
  end

  file new_resource.config_path do
    action :delete
  end

  file new_resource.ca_keys_path do
    action :delete
  end

  file new_resource.revoked_keys_path do
    action :delete
  end

  Array(resolved_options['host_key']).each do |host_key_path|
    file host_key_path do
      action :delete
    end
  end

  if runtime_directory
    directory runtime_directory do
      recursive true
      action :delete
    end
  end

  if new_resource.manage_package
    package new_resource.package_names do
      action :remove
    end
  end
end
