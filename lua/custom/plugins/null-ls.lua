local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
return {
  'nvimtools/none-ls.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvimtools/none-ls-extras.nvim' },
  config = function()
    require('null-ls').setup {
      sources = {
        require('null-ls').builtins.formatting.black,
        -- require('null-ls').builtins.formatting.prettierd.with {
        --   condition = function(utils)
        --     return utils.root_has_file { '.prettierrc.js' }
        --   end,
        -- },
        -- require 'none-ls.code_actions.eslint_d',
        -- require 'none-ls.diagnostics.eslint_d',
      },
      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_clear_autocmds {
            group = augroup,
            buffer = bufnr,
          }
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { bufnr = bufnr }
            end,
          })
        end
      end,
    }
  end,
  opts = {},
}
