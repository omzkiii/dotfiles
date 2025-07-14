return {
  cmd = { "harper-ls", "--stdio" },
  filetypes = { "html", "markdown", "txt" },
  settings = {
    ["harper-ls"] = {
      codeActions = {
        forceStable = true,
      },
      linters = {
        spell_check = true,
        spelled_numbers = false,
        an_a = true,
        sentence_capitalization = false,
        unclosed_quotes = true,
        wrong_quotes = false,
        long_sentences = false,
        repeated_words = true,
        spaces = true,
        matcher = true,
        correct_number_suffix = true,
        number_suffix_capitalization = true,
        multiple_sequential_pronouns = true,
        linking_verbs = false,
        avoid_curses = false,
        terminating_conjunctions = true,
      },
      userDictPath = "~/.config/nvim/spell/en.utf-8.add.spl",
      fileDictPath = "~/.config/nvim/spell/en.utf-8.add",
    },
  },
}
