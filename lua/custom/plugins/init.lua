-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Iterate over all Lua files in the plugins directory and load them.
-- `vim.fs.dir()` iteration order is unspecified and must not be relied upon.
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end

local gh = function(gh_path) return 'https://github.com/' .. gh_path end

-- Plugins:
-----------

-- Aerial (symbol map)
vim.pack.add { { src = gh 'stevearc/aerial.nvim' } }
require('aerial').setup()
vim.keymap.set('n', '<Leader>a', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial' })

-- Plugins In Testing:
----------------------

vim.pack.add { { src = gh 'stevearc/conform.nvim' } }
require('conform').setup {
  -- Map filetypes to formatters installed via Mason
  formatters_by_ft = {
    -- Lua
    lua = { 'stylua' },

    -- Web / JavaScript / TypeScript
    -- (Uses Biome if present in project; falls back to Prettierd if not)
    javascript = { 'biome', 'prettierd', stop_after_first = true },
    javascriptreact = { 'biome', 'prettierd', stop_after_first = true },
    typescript = { 'biome', 'prettierd', stop_after_first = true },
    typescriptreact = { 'biome', 'prettierd', stop_after_first = true },
    json = { 'biome', 'prettierd', stop_after_first = true },
    jsonc = { 'biome', 'prettierd', stop_after_first = true },

    -- Styles & Markup
    css = { 'prettierd' },
    scss = { 'prettierd' },
    html = { 'prettierd' },
    astro = { 'prettierd' },
    mdx = { 'prettierd' },
    markdown = { 'prettierd' },

    -- Shell
    sh = { 'shfmt' },
    bash = { 'shfmt' },

    -- Config Files
    yaml = { 'prettierd' },
    toml = { 'taplo' },
  },

  -- Format-on-Save configuration
  format_on_save = {
    timeout_ms = 500, -- Stop waiting if formatting takes longer than 0.5s
    lsp_format = 'fallback', -- Use active LSP (e.g., ts_ls, html, lua_ls) if no formatter is found
  },
}

-- Treesitter: --

-- Context
vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter-context' } }
require('treesitter-context').setup {
  enable = true,
}

-- Auto Tag
vim.pack.add { { src = gh 'windwp/nvim-ts-autotag' } }
require('nvim-ts-autotag').setup()

-- Scrollbar
-- TODO: install optional deps for highlights, etc.
vim.pack.add { { src = gh 'petertriho/nvim-scrollbar' } }
require('scrollbar').setup {
  show = true,
  show_in_active_only = true,
  set_highlights = true,
}

-- Visual: --

-- Markdown
vim.pack.add { { src = gh 'MeanderingProgrammer/render-markdown.nvim' } }
require('render-markdown').setup()

-- Cursor
vim.pack.add { { src = gh 'sphamba/smear-cursor.nvim' } }
require('smear_cursor').setup {
  smear_between_buffers = true,
  smear_between_neighbor_lines = true,
  smear_replace_mode = true,
  smear_terminal_mode = true,
  legacy_computing_symbols_support = true,
  vertical_bar_cursor_insert_mode = true,
  never_draw_over_target = true,
  hide_target_hack = true,
}
