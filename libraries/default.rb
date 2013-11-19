def openssh_server_options
  options = node['openssh']['server'].sort.reject {|key,value| key == 'port'}
  unless node['openssh']['server']['port'].nil?
    port = node['openssh']['server'].select{|key| key == 'port' }.to_a
    options.unshift(*port)
  end
  return options
end