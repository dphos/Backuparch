return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  ft = 'markdown',
  dependecies = {},

  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/private/Obsidian/obsidian',
      },
    },
    note_id_func = function(title)
      local name = ''
      if title ~= nil then
        name = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      end
      if #name == 0 then
        local suffix = ''
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        name = tostring(os.time()) .. '-' .. suffix
      end
      return name
    end,
    legacy_commands = false,

    ui = { enable = false },
    -- see below for full list of options 👇
  },
}
