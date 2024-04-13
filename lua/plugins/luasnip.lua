return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip").config.set_config({
      enable_autosnippets = true,
      store_selection_keys = "`",
    })
    require("luasnip.loaders.from_lua").lazy_load({ paths = { "~/.config/nvim/snippets" } })
  end,
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    {
      "nvim-cmp",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
      },
      opts = function(_, opts)
        opts.snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        }
        table.insert(opts.sources, { name = "luasnip" })
      end,
    },
  },
  opts = {
    history = true,
    delete_check_events = "TextChanged",
  },
}
