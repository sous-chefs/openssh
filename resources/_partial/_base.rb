# frozen_string_literal: true

property :config_dir, String, default: lazy { default_ssh_config_dir }
property :owner, String, default: 'root'
property :group, String, default: 'root'
property :manage_package, [true, false], default: true
