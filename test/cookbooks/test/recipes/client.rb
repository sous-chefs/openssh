# frozen_string_literal: true

apt_update 'update' if platform_family?('debian')

openssh_client 'default'
