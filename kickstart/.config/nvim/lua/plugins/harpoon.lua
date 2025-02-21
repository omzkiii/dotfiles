return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  -- lazy = true,
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function()
    local harpoon = require "harpoon"
    vim.api.nvim_create_autocmd({ "BufLeave", "ExitPre" }, {
      pattern = "*",
      callback = function()
        local filename = vim.fn.expand "%:p:."
        local harpoon_marks = harpoon:list().items
        for _, mark in ipairs(harpoon_marks) do
          if mark.value == filename then
            mark.context.row = vim.fn.line "."
            mark.context.col = vim.fn.col "."
            return
          end
        end
      end,
    })

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
      harpoon:list():replace_at(5)
    end, { desc = "Harpoon in 5" })
    vim.keymap.set("n", "<leader>6", function()
      harpoon:list():replace_at(6)
    end, { desc = "Harpoon in 6" })
    vim.keymap.set("n", "<leader>7", function()
      harpoon:list():replace_at(7)
    end, { desc = "Harpoon in 7" })
    vim.keymap.set("n", "<leader>8", function()
      harpoon:list():replace_at(8)
    end, { desc = "Harpoon in 8" })
    vim.keymap.set("n", "<leader>9", function()
      harpoon:list():replace_at(9)
    end, { desc = "Harpoon in 9" })
    vim.keymap.set("n", "<leader>0", function()
      harpoon:list():replace_at(10)
    end, { desc = "Harpoon in 10" })

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
      harpoon:list():select(5)
    end, { desc = "Harpoon to 5" })
    vim.keymap.set("n", "<M-6>", function()
      harpoon:list():select(6)
    end, { desc = "Harpoon to 6" })
    vim.keymap.set("n", "<M-7>", function()
      harpoon:list():select(7)
    end, { desc = "Harpoon to 7" })
    vim.keymap.set("n", "<M-8>", function()
      harpoon:list():select(8)
    end, { desc = "Harpoon to 8" })
    vim.keymap.set("n", "<M-9>", function()
      harpoon:list():select(9)
    end, { desc = "Harpoon to 9" })
    vim.keymap.set("n", "<M-0>", function()
      harpoon:list():select(10)
    end, { desc = "Harpoon to 10" })

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
