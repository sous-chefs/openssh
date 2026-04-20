# frozen_string_literal: true

provides :openssh_client
unified_mode true

include Openssh::Helpers

use '_partial/_base'

property :config_path, String, default: lazy { join_path(config_dir, 'ssh_config') }
property :mode, String, default: '0644'
property :global_options, Hash, default: lazy { default_client_global_options }
property :host_options, Hash, default: lazy { default_client_host_options }
property :package_names, [String, Array], default: lazy { default_client_package_names }

action_class do
  include Openssh::Helpers
end

action :create do
  if new_resource.manage_package
    package new_resource.package_names do
      action :install
    end
  end

  file new_resource.config_path do
    content lazy { render_client_config(new_resource.global_options, new_resource.host_options) }
    owner new_resource.owner
    group new_resource.group
    mode new_resource.mode
  end
end

action :delete do
  file new_resource.config_path do
    action :delete
  end

  if new_resource.manage_package
    package new_resource.package_names do
      action :remove
    end
  end
end
