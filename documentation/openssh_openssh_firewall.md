# openssh_openssh_firewall

Manages SSH allow rules through the `iptables` cookbook resources.

## Actions

| Action | Description |
|--------|-------------|
| `:create` | Installs or starts iptables resources and creates SSH allow rules (default) |
| `:delete` | Removes the managed SSH allow rules |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `port` | `String`, `Integer`, `Array` | `nil` | Convenience property for one or more SSH ports |
| `ports` | `String`, `Integer`, `Array` | `['22']` | SSH ports to allow when `port` is not set |
| `manage_iptables_service` | `true`, `false` | `true` | Enable and start the iptables service resource |
| `inbound_chain` | `Symbol` | `:INPUT` | Chain for inbound rules |
| `outbound_chain` | `Symbol` | `:OUTPUT` | Chain for outbound rules |

## Examples

### Basic usage

```ruby
openssh_firewall 'default'
```

### Custom port

```ruby
openssh_firewall 'default' do
  port 2222
end
```
