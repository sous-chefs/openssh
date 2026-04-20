# openssh Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/openssh.svg)](https://supermarket.chef.io/cookbooks/openssh)
[![CI State](https://github.com/sous-chefs/openssh/workflows/ci/badge.svg)](https://github.com/sous-chefs/openssh/actions?query=workflow%3Aci)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

The `openssh` cookbook now provides custom resources for package-managed Linux OpenSSH installs.

## Supported Platforms

- Amazon Linux 2023
- Debian 12 and 13
- Rocky Linux 9
- Ubuntu 22.04 and 24.04

## Chef

- Chef Infra Client `>= 15.3`

## Resources

- `openssh_client`
- `openssh_server`
- `openssh_firewall`

Detailed resource documentation lives in the [documentation](documentation) directory.

## Usage

### Client

```ruby
openssh_client 'default'
```

### Server

```ruby
openssh_server 'default' do
  port 22
  action :create
end
```

### Firewall

```ruby
openssh_firewall 'default' do
  port 22
  action :create
end
```

### Full local workflow

```ruby
openssh_client 'default'

openssh_server 'default' do
  ca_keys ['ssh-ed25519 AAAAC3Nza... example-ca']
end

openssh_firewall 'default'
```

## Notes

- The cookbook manages distro packages only. It does not install OpenSSH from source.
- Historical Windows and other legacy-platform recipe paths were removed as part of the full custom-resource migration.
- The CI, Kitchen matrix, and metadata support list are intentionally aligned with the current `ossec` cookbook workflow pattern.
