# frozen_string_literal: true

provides :openssh_firewall
unified_mode true

property :port, [String, Integer, Array, nil], default: nil, coerce: proc { |value| value.nil? ? nil : Array(value).map(&:to_s) }
property :ports, [String, Integer, Array], default: ['22'], coerce: proc { |value| Array(value).map(&:to_s) }
property :manage_iptables_service, [true, false], default: true
property :inbound_chain, Symbol, default: :INPUT
property :outbound_chain, Symbol, default: :OUTPUT

action :create do
  iptables_packages 'install-iptables'

  iptables_service 'manage-iptables' do
    action :enable
    only_if { new_resource.manage_iptables_service }
  end

  effective_ports = new_resource.port || new_resource.ports

  effective_ports.each do |port|
    iptables_rule "ssh-input-#{port}" do
      chain new_resource.inbound_chain
      jump 'ACCEPT'
      protocol 'tcp'
      match 'tcp'
      extra_options "--dport #{port}"
    end

    iptables_rule "ssh-output-#{port}" do
      chain new_resource.outbound_chain
      jump 'ACCEPT'
      protocol 'tcp'
      match 'tcp'
      extra_options "--sport #{port}"
    end
  end
end

action :delete do
  effective_ports = new_resource.port || new_resource.ports

  effective_ports.each do |port|
    iptables_rule "ssh-input-#{port}" do
      chain new_resource.inbound_chain
      jump 'ACCEPT'
      protocol 'tcp'
      match 'tcp'
      extra_options "--dport #{port}"
      action :delete
    end

    iptables_rule "ssh-output-#{port}" do
      chain new_resource.outbound_chain
      jump 'ACCEPT'
      protocol 'tcp'
      match 'tcp'
      extra_options "--sport #{port}"
      action :delete
    end
  end
end
