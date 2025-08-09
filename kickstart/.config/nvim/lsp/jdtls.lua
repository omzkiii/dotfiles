return {
  cmd = {
    "jdtls",
  },
  filetypes = { "java" },
  root_markers = {},
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "jdk-24",
            -- path = "/usr/lib/jvm/default",
            default = true,
          },
        },
      },
    },
  },
}
