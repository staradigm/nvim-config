# nvim-config

[![CI](https://github.com/staradigm/nvim-config/actions/workflows/ci.yml/badge.svg)](https://github.com/staradigm/nvim-config/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Neovim](https://img.shields.io/badge/Neovim-0.10%2B-blueviolet.svg)]()

A fast, **lazy-loaded** Neovim configuration built on
[lazy.nvim](https://github.com/folke/lazy.nvim). Everything loads on demand —
startup time is a few milliseconds, and plugins only materialize when you
actually use them.

## Features

- **Lazy loading** — plugins load on `cmd`, `keys`, or `event` triggers; startup stays instant.
- **LSP out of the box** — [Mason](https://github.com/williamboman/mason.nvim) installs `lua_ls`, `pyright`, `ts_ls`, and `rust_analyzer`; nvim-cmp completes with sources for LSP, buffers, and paths.
- **Treesitter** — highlighting, indentation, incremental selection, and function/class text objects.
- **Telescope** — fuzzy find, live grep, buffers, help, document symbols.
- **Git-native workflow** — lazygit in a floating window (`<leader>gg`), gitsigns hunks (`]h`/`[h`, `<leader>hp/hs/hr/hu`).
- **Clean UI** — gruvbox, lualine statusline, bufferline tabs, nvim-tree, which-key hints, indent guides.
- **Opinionated defaults** — relative line numbers, smart search, undofile, clipboard sync, per-filetype indentation.

## Install

Requires **Neovim 0.10+** and `git`.

```bash
git clone https://github.com/staradigm/nvim-config ~/.config/nvim
nvim  # first run bootstraps lazy.nvim and installs all plugins
```

On first launch lazy.nvim installs itself, then every plugin in the spec. Run
`:Lazy` to manage updates, `:Lazy sync` to install, `:Mason` to manage LSP
servers.

## Keymaps

Leader is `<Space>`.

| Key | Action |
| --- | --- |
| `<Space>ff` / `<Space>fg` | find files / live grep |
| `<Space>fb` / `<Space>fh` | buffers / help tags |
| `<Space>e` | toggle file tree |
| `<Space>gg` | lazygit (floating) |
| `<Space>hp` / `<Space>hs` / `<Space>hr` | preview / stage / reset hunk |
| `<Space>w` / `<Space>q` | write / quit |
| `<Space>rn` / `<Space>ca` / `<Space>f` | rename / code action / format |
| `gd` / `gr` / `K` | definition / references / hover |
| `<C-space>` | incremental selection (treesitter) |
| `<A-j>` / `<A-k>` | move line/selection down/up |

## Layout

```
init.lua               bootstrap + require order
lua/
├── options.lua        editor options (before plugins)
├── keymaps.lua        default keymaps
├── autocmds.lua       formatting, filetype, yank-highlight
├── verify.lua         CI smoke test
└── plugins/           one lazy.nvim spec per concern
    ├── colorscheme.lua
    ├── treesitter.lua
    ├── lsp.lua        mason + lspconfig + nvim-cmp
    ├── telescope.lua
    ├── ui.lua         lualine, bufferline, gitsigns, which-key, nvim-tree
    └── git.lua        lazygit
```

## Customizing

Each plugin lives in its own spec file — edit, add, or delete freely.
Convention: new plugin specs go in `lua/plugins/`; global settings in
`lua/options.lua`; keymaps in `lua/keymaps.lua`.

## Development

CI installs nightly Neovim, runs `Lazy sync` to fetch every plugin, then a
headless smoke test (`lua/verify.lua`) that asserts the config loads and all
plugins are wired up:

```bash
nvim --headless "+Lazy! sync" +qa
nvim --headless -u init.lua -l lua/verify.lua
```

## License

MIT — see [LICENSE](LICENSE).