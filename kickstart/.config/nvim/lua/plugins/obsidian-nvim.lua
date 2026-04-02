return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "Notes",
        path = "~/Documents/Notes/Notes/",
        overides = {
          notes_subdir = "notes",
        },
      },
    },

    notes_subdir = "Notes",
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Excerpts",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "Templates/Daily",
    },

    -- Alternatively - and for backwards compatibility - you can set 'dir' to a single path instead of
    -- 'workspaces'. For example:
    -- dir = "~/vaults/work",

    -- Optional, if you keep notes in a specific subdirectory of your vault.

    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.\*".
    log_level = vim.log.levels.INFO,

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = true,
      -- Enables completion using blink.cmp
      blink = false,
      -- Trigger completion at 2 chars.
      min_chars = 2,
      -- Set to false to disable new note creation in the picker
      create_new = true,
    },
    templates = {
      enabled = true,
      folder = "Templates",
      date_format = "YYYY-MM-DD",
      time_format = "HH:mm",
      substitutions = {
        date = function(_, suffix)
          local format = suffix or Obsidian.opts.templates.date_format
          return require("obsidian.util").format_date(os.time(), format)
        end,
        time = function(_, suffix)
          local format = suffix or Obsidian.opts.templates.time_format
          return require("obsidian.util").format_date(os.time(), format)
        end,
        title = function(ctx)
          return ctx.partial_note and ctx.partial_note:display_name()
        end,
        id = function(ctx)
          return ctx.partial_note and ctx.partial_note.id
        end,
        path = function(ctx)
          return ctx.partial_note and tostring(ctx.partial_note.path)
        end,
      },
      customizations = {},
    },

    -- Where to put new notes. Valid options are
    -- _ "current_dir" - put new notes in same directory as the current buffer.
    -- _ "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "notes_subdir",

    -- Optional, customize how note IDs are generated given an optional title.
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
      -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
      -- local suffix = ""
      -- if title ~= nil then
      --   -- If title is given, transform it into valid file name.
      --   suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      -- else
      --   -- If title is nil, just add 4 random uppercase letters to the suffix.
      --   for _ = 1, 4 do
      --     suffix = suffix .. string.char(math.random(65, 90))
      --   end
      -- end
      -- return tostring(os.time()) .. "-" .. suffix
      return tostring(os.time())
    end,

    -- Optional, customize how note file names are generated given the ID, target directory, and title.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix ".md"
    end,

    -- Either 'wiki' or 'markdown'.
    link = { style = "wiki" },

    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.

    -- Optional, alternatively you can customize the frontmatter data.
    frontmatter = {
      enable = false,
      func = function(note)
        -- Add the title of the note as an alias.
        -- if note.title then
        --   note:add_alias(note.title)
        -- end
        local out = {}

        -- local out = { date = note.id, aliases = note.aliases, tags = note.tags }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        -- if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        --   for k, v in pairs(note.metadata) do
        --     out[k] = v
        --   end
        -- end

        return out
      end,
    },

    -- Sets how you follow URLs
    -- follow_url_func = function(url)
    --   -- vim.ui.open(url)
    --   vim.ui.open(url, { cmd = { "firefox" } })
    -- end,
    --
    -- -- Sets how you follow images
    -- follow_img_func = function(img)
    --   -- vim.ui.open(img)
    --   vim.ui.open(img, { cmd = { "feh" } })
    -- end,

    open = {
      use_advanced_uri = false,
      func = vim.ui.open,
    },

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
      name = "snacks.pick",
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

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
    -- that `:Obsidian quick_switch` will show the notes sorted by latest modified time

    -- Set the maximum number of lines to read from notes on disk when performing certain searches.
    search = {
      max_lines = 1000,

      sort_by = "modified",
      sort_reversed = true,
    },

    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - only open in a vertical split if a vsplit does not exist.
    -- 3. "hsplit" - only open in a horizontal split if a hsplit does not exist.
    -- 4. "vsplit_force" - always open a new vertical split if the file is not in the adjacent vsplit.
    -- 5. "hsplit_force" - always open a new horizontal split if the file is not in the adjacent hsplit.
    open_notes_in = "current",

    -- Optional, define your own callbacks to further customize behavior.
    callbacks = {
      -- Runs at the end of `require("obsidian").setup()`.
      post_setup = function(client) end,

      -- Runs anytime you enter the buffer for a note.
      enter_note = function(client, note)
        -- vim.keymap.set("n", "<CR>", function()
        --   return require("obsidian").util.gf_passthrough()
        -- end, {
        --   noremap = false,
        --   expr = true,
        --   buffer = note.bufnr,
        -- })

        vim.keymap.set("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", {
          desc = "Toggle Checkbox",
        })

        vim.keymap.set("n", "<BS>", "<cmd>Obsidian backlinks<cr>", {
          desc = "Backlinks",
        })

        vim.keymap.set("n", "<M-CR>", "<cmd>Obsidian links<cr>", {
          desc = "Links within Notes",
        })

        vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<cr>", {
          desc = "Search Notes",
        })

        vim.keymap.set("n", "<leader>oq", "<cmd>Obsidian quick_switch<cr>", {
          desc = "Open Quick Switch",
        })

        vim.keymap.set("n", "<S-CR>", "<cmd>Obsidian follow_link vsplit<cr>", {
          desc = "Follow Link Vsplit",
        })

        vim.keymap.set("n", "<leader>on", "<cmd>Obsidian unique_note<cr>", {
          desc = "New Note",
        })

        vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian template<cr>", {
          desc = "Apply Tagline",
        })

        vim.keymap.set("n", "<leader>od", "<cmd>Obsidian dailies<cr>", {
          desc = "Open Daily",
        })

        vim.keymap.set("n", "<leader>ou", function()
          require("telescope.builtin").grep_string {
            prompt_title = "Unfinished Notes",
            search = "#unfinished",
            only_sort_text = true,
            path_display = function(_, path)
              return vim.fn.fnamemodify(path, ":t")
            end,
          }
        end, {
          desc = "Unfinished Notes",
        })

        vim.keymap.set("n", "<leader>oT", function()
          require("telescope.builtin").grep_string {
            prompt_title = "Todo Notes",
            search = "#todo",
            only_sort_text = true,
            path_display = function(_, path)
              return vim.fn.fnamemodify(path, ":t")
            end,
          }
        end, {
          desc = "Task Notes",
        })
      end,

      -- Runs anytime you leave the buffer for a note.
      leave_note = function(client, note) end,

      -- Runs right before writing the buffer for a note.
      pre_write_note = function(client, note) end,

      -- Runs anytime the workspace is set/changed.
      post_set_workspace = function(client, workspace) end,
    },

    -- Optional, configure additional syntax highlighting / extmarks.
    -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
    ui = {
      enable = false, -- set to false to disable all additional syntax features
      ignore_conceal_warn = true, -- set to true to disable conceallevel specific warning
      update_debounce = 200, -- update delay after a text change (in milliseconds)
      max_file_length = 5000, -- disable UI features for files with more than this many lines
      -- Use bullet marks for non-checkbox lists.
      -- bullets = { char = " • ", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      -- Replace the above with this if you don't have a patched font:
      -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
      reference_text = { hl_group = "ObsidianRefText" },
      highlight_text = { hl_group = "ObsidianHighlightText" },
      tags = { hl_group = "ObsidianTag" },
      block_ids = { hl_group = "ObsidianBlockID" },
      -- hl_groups = {
      --   -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
      --   ObsidianTodo = { bold = true, fg = "#f78c6c" },
      --   ObsidianDone = { bold = true, fg = "#89ddff" },
      --   ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
      --   ObsidianTilde = { bold = true, fg = "#ff5370" },
      --   ObsidianImportant = { bold = true, fg = "#d73128" },
      --   ObsidianBullet = { bold = true, fg = "#89ddff" },
      --   ObsidianRefText = { underline = true, fg = "#c792ea" },
      --   ObsidianExtLinkIcon = { fg = "#c792ea" },
      --   ObsidianTag = { italic = true, fg = "#89ddff" },
      --   ObsidianBlockID = { italic = true, fg = "#89ddff" },
      --   ObsidianHighlightText = { bg = "#75662e" },
      -- },
    },

    attachments = {
      folder = "assets/imgs",
      img_name_func = function()
        return string.format("Pasted image %s", os.date "%Y%m%d%H%M%S")
      end,
      confirm_img_paste = true,
    },

    footer = {
      enabled = true,
      -- format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
      format = "{{backlinks}} backlinks",
      hl_group = "Comment",
      separator = "" .. string.rep("―", 15),
    },
    ---
    ---Order of checkbox state chars, e.g. { " ", "x" }
    checkbox = {
      enabled = false,
      order = { " ", "~", "!", ">", "x" },
    },
  },
}
