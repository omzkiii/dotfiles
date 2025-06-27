return {
  cmd = { "docker-compose-langserver", "start", "--stdio" },
  filetypes = { "yaml.docker-compose", "yml.docker-compose", "yaml", "yml" },
  single_file_support = true,
}
