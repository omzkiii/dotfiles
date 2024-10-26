return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   "BufReadPre path/to/my-vault/**.md",
  --   "BufNewFile path/to/my-vault/**.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/Documents/Notes/Notes/",
        overides = {
          notes_subdir = "notes",
        },
      },
    },

    notes_subdir = "notes",
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Excerpts",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },
    ui = {
      enable = false, -- set to false to disable all additional syntax features
    },
    -- Set to false to disable completion.
    nvim_cmp = true,

    -- Trigger completion at 2 chars.
    min_chars = 2,

    -- Where to put new notes created from completion. Valid options are
    --  * "current_dir" - put new notes in same directory as the current buffer.
    --  * "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "notes_subdir",

    -- Either 'wiki' or 'markdown'.
    preferred_link_style = "markdown",
    note_id_func = function(title)
      return title
    end,

    -- Control how wiki links are completed with these (mutually exclusive) options:
    --
    -- 1. Whether to add the note ID during completion.
    -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
    -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
    prepend_note_id = true,
    -- 2. Whether to add the note path during completion.
    -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
    -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
    prepend_note_path = false,
    -- 3. Whether to only use paths during completion.
    -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
    -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
    use_path_only = false,
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      --
      ["<CR>"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },

      ["<BS>"] = {
        action = function()
          return vim.cmd ":ObsidianBacklinks"
        end,
        opts = { buffer = true },
      },

      ["<M-CR>"] = {
        action = function()
          return vim.cmd ":ObsidianLinks"
        end,
        opts = { buffer = true },
      },

      ["<leader>os"] = {
        action = function()
          return vim.cmd ":ObsidianSearch"
        end,
        opts = { buffer = true },
      },

      ["<leader>oq"] = {
        action = function()
          return vim.cmd ":ObsidianQuickSwitch"
        end,
        opts = { buffer = true },
      },
      ["<S-CR>"] = {
        action = function()
          return vim.cmd ":ObsidianFollowLink vsplit"
        end,
        opts = { buffer = true },
      },

      ["<leader>on"] = {
        action = function()
          return vim.cmd ":ObsidianNew"
        end,
        opts = { buffer = true },
      },

      ["<leader>ot"] = {
        action = function()
          return vim.cmd ":ObsidianTemplate Tagline"
        end,
        opts = { buffer = true },
      },
      ["<leader>ou"] = {
        action = function()
          return vim.cmd ":ObsidianTags #unfinished"
        end,
        opts = { buffer = true },
      },
    },
    disable_frontmatter = true,

    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      -- if note.title then
      --   note:add_alias(note.title)
      -- end

      -- local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      local out = { tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "telescope.nvim",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
  },
}
