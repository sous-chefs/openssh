# frozen_string_literal: true

require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation
  config.log_level = :error
  config.platform = 'ubuntu'
  config.version = '24.04'
end

def join_path(*path)
  Chef::Util::PathHelper.cleanpath(::File.join(path))
end
