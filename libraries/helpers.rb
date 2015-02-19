
def sshd_validate_config(template, node)
  # validates sshd_config
  temp_file = Tempfile.new('sshd_config_check')

  begin
    rc = template.instance_variable_get('@run_context')
    cookbook = rc.cookbook_collection[template.cookbook || template.cookbook_name]

    template_location = cookbook.preferred_filename_on_disk_location(node, :templates, template.source)

    vars = {}
    vars.merge!(template.variables)

    render_template = Erubis::Eruby.new(::File.read(template_location)).evaluate(vars)

    temp_file.write(render_template)
    temp_file.rewind

    cmd = Mixlib::ShellOut.new("sshd -t -f #{temp_file.path}").run_command
    cmd.error!
  ensure
    temp_file.close
    temp_file.unlink
  end
end
