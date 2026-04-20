# openssh_openssh_server

Manages the OpenSSH server package, key material files, `/etc/ssh/sshd_config`, and the SSH service.

## Actions

| Action | Description |
|--------|-------------|
| `:create` | Installs the server package, writes config and key files, and enables/starts the service (default) |
| `:delete` | Stops the service and removes the managed config, key files, host keys, and server package |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `config_dir` | `String` | `'/etc/ssh'` | Base SSH configuration directory |
| `owner` | `String` | `'root'` | Owner for managed files |
| `group` | `String` | `'root'` | Group for managed files |
| `manage_package` | `true`, `false` | `true` | Install or remove the server package |
| `config_path` | `String` | `'/etc/ssh/sshd_config'` | Full path to the server config |
| `mode` | `String` | platform default | Mode for server config and key-list files |
| `options` | `Hash` | platform defaults | SSH server directives excluding subsystem and match blocks |
| `port` | `String`, `Integer`, `Array` | `nil` | Convenience property for one or more `Port` directives |
| `subsystems` | `String`, `Array`, `Hash` | platform default | `Subsystem` directives |
| `match_blocks` | `Hash` | `{}` | `Match` blocks keyed by match expression |
| `listen_interfaces` | `Hash` | `{}` | Interface-to-address-family map used to derive `ListenAddress` |
| `ca_keys` | `Array` | `[]` | Trusted CA keys written to `ca_keys_path` |
| `ca_keys_path` | `String` | `'/etc/ssh/ca_keys'` | Path for trusted CA keys |
| `revoked_keys` | `Array` | `[]` | Revoked keys written to `revoked_keys_path` |
| `revoked_keys_path` | `String` | `'/etc/ssh/revoked_keys'` | Path for revoked keys |
| `package_names` | `String`, `Array` | `['openssh-server']` | Package name or names to manage |
| `service_name` | `String` | platform default | SSH service name |
| `manage_service` | `true`, `false` | `true` | Enable and start the service |
| `generate_host_keys` | `true`, `false` | `true` | Run `ssh-keygen -A` when configured host keys are missing |
| `verify_config` | `true`, `false` | `true` | Verify `sshd_config` with `sshd -t` before replacing it |

## Examples

### Basic usage

```ruby
openssh_server 'default'
```

### Custom ports and keys

```ruby
openssh_server 'default' do
  port [22, 2222]
  ca_keys ['ssh-ed25519 AAAAC3Nza... example-ca']
  revoked_keys ['ssh-ed25519 AAAAC3Nza... revoked-user']
end
```

### Interface-based listen addresses

```ruby
openssh_server 'default' do
  listen_interfaces(
    'eth0' => 'inet',
    'eth1' => 'inet6'
  )
end
```
