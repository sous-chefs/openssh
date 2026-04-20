# Limitations

## Package Availability

### APT (Debian/Ubuntu)

- Ubuntu 22.04 and 24.04 ship `openssh-client` and `openssh-server` in the official repositories.
- Debian 12 and 13 ship `openssh-client` and `openssh-server` in the official repositories.
- Ubuntu and Debian package pages show broad multi-architecture availability, but this cookbook only verifies the Linux matrix used in CI.

### DNF/YUM (RHEL family)

- Amazon Linux 2023 ships `openssh`, `openssh-clients`, and `openssh-server` for `aarch64` and `x86_64`.
- Rocky Linux 9 ships `openssh-clients` and `openssh-server` in BaseOS. Repository listings confirm `x86_64`, and Rocky publishes the same package set for `aarch64`.
- The migrated cookbook standardizes on Rocky Linux 9 for RHEL-family coverage in CI to match the `ossec` cookbook matrix.

### Zypper (SUSE)

- openSUSE Leap 15.6 reaches end of life on 2026-04-30.
- The openSUSE package page currently shows no official package for Leap 16.0.
- Because of that lifecycle gap, this migration drops openSUSE from the supported platform list.

## Architecture Limitations

- CI validates only the GitHub-hosted Linux matrix used by Sous-Chefs Dokken jobs.
- Amazon Linux 2023 package metadata explicitly lists `aarch64` and `x86_64`.
- Ubuntu, Debian, and Rocky publish additional architectures, but this cookbook does not claim architecture-specific verification outside CI.

## Source/Compiled Installation

- Upstream OpenSSH Portable publishes source tarballs for Unix-like systems, but this cookbook manages distro packages only.
- Upstream notes that source builds from the Git tree require `autoreconf` from the `autoconf` package before `configure` can run.
- No source-install path is implemented in this cookbook, so platform-specific compiler and development-package management are out of scope for this migration.

## Known Issues

- Historical cookbook support for Windows, AIX, FreeBSD, SmartOS, and other legacy platforms depended on recipe/attribute patterns and, in the Windows case, an external MSI install in CI. Those paths are not retained in the Linux-only custom-resource migration.
- The support set is intentionally narrower than upstream OpenSSH Portable. The cookbook now aligns to the current Sous-Chefs Dokken matrix used by `ossec`: Amazon Linux 2023, Debian 12/13, Rocky Linux 9, and Ubuntu 22.04/24.04.
