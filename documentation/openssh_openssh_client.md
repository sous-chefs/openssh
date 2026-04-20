# openssh_openssh_client

Manages the OpenSSH client package and `/etc/ssh/ssh_config`.

## Actions

| Action | Description |
|--------|-------------|
| `:create` | Installs the client package and writes the client config (default) |
| `:delete` | Removes the client config and client package |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `config_dir` | `String` | `'/etc/ssh'` | Base SSH configuration directory |
| `owner` | `String` | `'root'` | Owner for the config file |
| `group` | `String` | `'root'` | Group for the config file |
| `manage_package` | `true`, `false` | `true` | Install or remove the client package |
| `config_path` | `String` | `'/etc/ssh/ssh_config'` | Full path to the client config |
| `mode` | `String` | `'0644'` | Mode for the client config |
| `global_options` | `Hash` | `{'use_roaming' => 'no'}` | Top-level SSH client directives |
| `host_options` | `Hash` | `{'*' => {}}` | Host-specific client directives |
| `package_names` | `String`, `Array` | platform default | Package name or names to manage |

## Examples

### Basic usage

```ruby
openssh_client 'default'
```

### Custom host options

```ruby
openssh_client 'default' do
  host_options(
    '*' => {
      'strict_host_key_checking' => 'ask',
      'send_env' => 'LANG LC_*'
    }
  )
end
```
