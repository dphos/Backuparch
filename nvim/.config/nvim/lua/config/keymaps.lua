vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>wh', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<leader>wl', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>wj', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<leader>wk', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>')
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<C-w>', '<cmd>bdelete<CR>')
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>')

vim.keymap.set('n', '<leader>q', '<cmd>quit<CR>')
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>')

vim.keymap.set({ 'n', 'i' }, '<C-x><C-k>', '<cmd>bdelete<CR>')
vim.keymap.set({ 'n', 'i' }, '<C-x><C-n>', '<cmd>bnext<CR>')
vim.keymap.set({ 'n', 'i' }, '<C-x><C-p>', '<cmd>bprevious<CR>')
vim.keymap.set({ 'n', 'i' }, '<C-x><C-s>', '<cmd>write<CR>')
vim.keymap.set('n', '<leader>,', 'yyp')

vim.keymap.set('n', '<leader>e', function()
  if vim.bo.filetype == 'oil' then
    require('oil').close()
  else
    require('oil').open()
  end
end, { desc = 'Toggle Oil file explorer' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-a>', '^')
vim.keymap.set('n', '<C-e>', '$')
vim.keymap.set('i', '<C-a>', '<C-o>^')
vim.keymap.set('i', '<C-e>', '<C-o>$')
vim.keymap.set('c', '<C-a>', '<C-b>')
vim.keymap.set({ 'i' }, '<C-f>', '<Right>')
vim.keymap.set({ 'i' }, '<C-b>', '<Left>')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

vim.keymap.set('n', '<leader>xx', '<cmd>lua vim.diagnostic.setqflist()<CR>')

vim.keymap.set('n', '<leader>pp', '<cmd>set spell spelllang=es<CR>')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end)

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end)

vim.keymap.set('n', '[h', function()
  gitsigns.nav_hunk 'prev'
end)

vim.keymap.set('n', ']h', function()
  gitsigns.nav_hunk 'next'
end)

vim.keymap.set('n', '<leader>fw', '<CMD>noautocmd w<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, 'j', 'gj')
vim.keymap.set({ 'n', 'v', 'x' }, 'k', 'gk')

-- vim.keymap.set('n', '<leader>gg', '<CMD>Neogit cwd=%:p:h<CR>')
--
-- vim.keymap.set('n', '<leader>gc', '<CMD>Neogit cwd=~/Backuparch<CR>')
