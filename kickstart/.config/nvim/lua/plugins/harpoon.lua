return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  -- lazy = true,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local harpoon = require "harpoon"

    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon add" })
    vim.keymap.set("n", "<M-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    vim.keymap.set("n", "<leader>1", function()
      harpoon:list():replace_at(1)
    end, { desc = "Harpoon in 1" })
    vim.keymap.set("n", "<leader>2", function()
      harpoon:list():replace_at(2)
    end, { desc = "Harpoon in 2" })
    vim.keymap.set("n", "<leader>3", function()
      harpoon:list():replace_at(3)
    end, { desc = "Harpoon in 3" })
    vim.keymap.set("n", "<leader>4", function()
      harpoon:list():replace_at(4)
    end, { desc = "Harpoon in 4" })
    vim.keymap.set("n", "<leader>5", function()
      harpoon:list():replace_at(4)
    end, { desc = "Harpoon in 5" })

    vim.keymap.set("n", "<M-1>", function()
      harpoon:list():select(1)
    end, { desc = "Harpoon to 1" })
    vim.keymap.set("n", "<M-2>", function()
      harpoon:list():select(2)
    end, { desc = "Harpoon to 2" })
    vim.keymap.set("n", "<M-3>", function()
      harpoon:list():select(3)
    end, { desc = "Harpoon to 3" })
    vim.keymap.set("n", "<M-4>", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon to 4" })
    vim.keymap.set("n", "<M-5>", function()
      harpoon:list():select(4)
    end, { desc = "Harpoon to 5" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<M-->", function()
      harpoon:list():prev()
    end, { desc = "Harpoon prev" })
    vim.keymap.set("n", "<M-=>", function()
      harpoon:list():next()
    end, { desc = "Harpoon next" })
    vim.keymap.set("n", "<M-x>", function()
      harpoon:list():clear()
    end, { desc = "Harpoon clear" })

    -- local conf = require("telescope.config").values
    -- local action_state = require "telescope.actions.state"
    -- local actions = require "telescope.actions"
    --
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for idx, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, { idx = idx, value = item.value })
    --   end
    --
    --   require("telescope.pickers")
    --     .new({}, {
    --       prompt_title = "Harpoon",
    --       finder = require("telescope.finders").new_table {
    --         results = file_paths,
    --         entry_maker = function(entry)
    --           return {
    --             value = entry.value,
    --             display = string.format("%d: %s", entry.idx, entry.value),
    --             ordinal = string.format("%d %s", entry.idx, entry.value),
    --             idx = entry.idx,
    --           }
    --         end,
    --       },
    --       initial_mode = "normal",
    --       attach_mappings = function(prompt_bufnr, map)
    --         local delete_harpoon = function()
    --           local current_picker = action_state.get_current_picker(prompt_bufnr)
    --           current_picker:delete_selection(function(selection)
    --             harpoon:list():remove(selection)
    --           end)
    --         end
    --
    --         actions.select_default:replace(function()
    --           local selection = action_state.get_selected_entry()
    --           actions.close(prompt_bufnr)
    --           vim.cmd("edit " .. selection.value)
    --         end)
    --
    --         map("n", "<M-d>", delete_harpoon)
    --         return true
    --       end,
    --       previewer = conf.file_previewer {},
    --       sorter = conf.generic_sorter {},
    --     })
    --     :find()
    -- end
    --
    -- vim.keymap.set("n", "<M-S-e>", function()
    --   toggle_telescope(harpoon:list())
    -- end, { desc = "Open harpoon window" })
  end,
}
