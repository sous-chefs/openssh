# openssh Cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/openssh.svg)](https://supermarket.chef.io/cookbooks/openssh)
[![CI State](https://github.com/sous-chefs/openssh/workflows/ci/badge.svg)](https://github.com/sous-chefs/openssh/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Installs and configures OpenSSH client and daemon.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

- Debian/Ubuntu
- RHEL/CentOS/Scientific/Oracle
- Fedora
- FreeBSD
- Suse Enterprise Linux
- openSUSE / openSUSE leap
- AIX 7.1
- Windows

### Chef

- Chef 12.1+

### Cookbooks

- iptables

## Recipes

### default

Installs openssh packages, manages the sshd config file, configure trusted ca keys, configure revoked keys, and starts/enables the sshd service.

### iptables

Creates an iptables firewall rule to allow inbound SSH connections.

## Usage

Apply the default recipe to the node's run_list to ensure that the openssh packages are installed, sshd is configured, and the service is started and enabled

## Attributes List

The attributes list is dynamically generated, and lines up with the default openssh configs.

This means anything located in [sshd_config](http://www.openbsd.org/cgi-bin/man.cgi?query=sshd_config&sektion=5) or [ssh_config](http://www.openbsd.org/cgi-bin/man.cgi?query=sshd_config&sektion=5) can be used in your node attributes.

- If the option can be entered more then once, use an _Array_, otherwise, use a _String_. If the option is host-specific use a `Hash` (please see below for more details).
- Each attribute is stored as ruby case, and converted to camel case for the config file on the fly.
- The current default attributes match the stock `ssh_config` and `sshd_config` provided by openssh.
- The namespace for `sshd_config` is `node['openssh']['server']`.
- Likewise, the namespace for `ssh_config` is `node['openssh']['client']`.
- An attribute can be an `Array`, a `Hash` or a `String`.
- If it is an `Array`, each item in the array will get it's own line in the config file.
- `Hash` attributes are meant to used with `ssh_config` namespace to create host-specific configurations. The keys of the `Hash` will be used as the `Host` entries and their associated entries as the configuration values.
- All the values in openssh are commented out in the `attributes/default.rb` file for a base starting point.
- There is one special attribute name, which is `match`. This is not included in the default template like the others. `node['openssh']['server']['match']` must be a Hash, where the key is the match pattern criteria and the value should be a Hash of normal keywords and values. The same transformations listed above apply to these keywords. To get improved sorting of match items, you can prefix the key with a number.  See examples below.

## Dynamic ListenAddress

Pass in a `Hash` of interface names, and IP address type(s) to bind sshd to. This will expand to a list of IP addresses which override the default `node['openssh']['server']['listen_address']` value.

## Examples and Common usage

These can be mixed and matched in roles and attributes.  Please note, it is possible to get sshd into a state that it will not run.  If this is the case, you will need to login via an alternate method and debug sshd like normal.

### No Password logins

This requires use of identity files to connect

```json
"openssh": {
  "server": {
    "password_authentication": "no"
  }
}
```

### Change sshd Port

```json
"openssh": {
  "server": {
    "port": "14188"
  }
}
```

### Match

```json
"openssh": {
  "server": {
    "match": {
      "Address 192.168.1.0/24": {
        "password_authentication": "yes"
      },
      "Group admins": {
        "permit_tunnel": "yes",
        "max_sessions": "20"
      }
    }
  }
}
```

### Match with sorting

```json
"openssh": {
  "server": {
    "match": {
      "0 User foobar": {
        "force_command": "internal-sftp -d /home/%u -l VERBOSE"
      },
      "Group admins": {
        "force_command": "internal-sftp -d /home/admins -l VERBOSE"
      }
    }
  }
}
```

### Enable X Forwarding

```json
"openssh": {
  "server": {
    "x11_forwarding": "yes"
  }
}
```

### Bind to a specific set of address (this example actually binds to all)

Not to be used with `node['openssh']['listen_interfaces']`.

```json
"openssh": {
  "server": {
    "address_family": "any",
      "listen_address": [ "192.168.0.1", "::" ]
    }
  }
}
```

### Bind to the addresses tied to a set of interfaces

```json
"openssh": {
  "listen_interfaces": {
    "eth0": "inet",
    "eth1": "inet6"
  }
}
```

### Configure Trusted User CA Keys

```json
"openssh": {
  "ca_keys": [
    "ssh-rsa key... ca_id_1",
    "ssh-rsa key... ca_id_2"
  ]
}
```

### Configure Revoked Keys

```json
"openssh": {
  "server": {
    "revoked_keys": [
      "ssh-rsa key... user_key_1",
      "ssh-rsa key... user_key_2"
    ]
  }
}
```

### Host-specific configurations with hashes

You can use a `Hash` with `node['openssh']['client']` to configure different values for different hosts.

```json
"client": {
  "*": {
    "g_s_s_a_p_i_authentication": "yes",
    "send_env": "LANG LC_*",
    "hash_known_hosts": "yes"
  },
  "localhost": {
    "user_known_hosts_file": "/dev/null",
    "strict_host_key_checking": "no"
  },
  "127.0.0.1": {
    "user_known_hosts_file": "/dev/null",
    "strict_host_key_checking": "no"
  },
  "other*": {
    "user_known_hosts_file": "/dev/null",
    "strict_host_key_checking": "no"
  }
}
```

The keys are used as values with the `Host` entries. So, the configuration fragment shown above generates:

```text
Host *
SendEnv LANG LC_*
HashKnownHosts yes
GSSAPIAuthentication yes
Host localhost
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
Host 127.0.0.1
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
Host other*
StrictHostKeyChecking no
UserKnownHostsFile /dev/null
```

### SSH Subsystems

Configure multiple SSH subsystems (e.g. sftp, netconf):

```json
"openssh": {
  "server": {
    "subsystem": {
      "sftp": "/usr/lib/openssh/sftp-server",
      "appX": "/usr/sbin/appX"
    }
  }
}
```

Former declaration of single subsystem:

```json
"openssh": {
  "server": {
    "subsystem": "sftp /usr/lib/openssh/sftp-server"
  }
}
```

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
