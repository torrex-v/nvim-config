:messages and press g< and you can do it every where even after pressing q to quit
:restart restarts neovim
:map shows your current mappings
:map <leader> shows your current mappings for leader
:uniq deletes duplicate lines
:w ++p saves the file with parent directory
:wall ++p saves all files with parent directory
:packadd <name> installs a plugin
in visual mode press an and in to expand selection forward and backward
In your Neovim setup, you have several ways to search keybindings:

• Telescope Keymaps (Interactive Fuzzy Search):
Run the command:
:Telescope keymaps
This opens a fuzzy-finder listing every registered mapping across modes along with its description.(Optional shortcut): You
can bind this in telescope.lua:
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find keymaps" })

• Which-Key:
You already have which-key.nvim installed. In normal mode, press any prefix key (such as <Space> or z) and pause for a moment
to see an interactive popup of available completions.
• Vim Built-in Command:
To inspect or query mappings for a specific key:
:verbose nmap z
:verbose nmap <leader>

──────

### 2. How to Fold and Unfold Code

Neovim uses the standard z commands for folding:

| Keybinding | Action                                                   |
| ---------- | -------------------------------------------------------- |
| za         | Toggle fold under cursor (open if closed, close if open) |
| zo         | Open fold under cursor                                   |
| zc         | Close fold under cursor                                  |
| zR         | Open all folds in the current file                       |
| zM         | Close all folds in the current file                      |
| zr / zm    | Open / close folds incrementally by one level            |
| zj / zk    | Jump to the next / previous fold                         |
| ──────     |

### 3. Why Code is Folded by Default & How to Fix It

Why it's happening:
In treesitter.lua:38-39, an autocmd enables Treesitter fold expressions:

    vim.wo[0][0].foldmethod = "expr"
    vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

Because foldlevelstart defaults to 0, Neovim automatically collapses folds whenever you open a file.

Fix (keep everything unfolded when opening files):
Add the following options to set.lua:

    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99

This keeps all folds expanded by default when you open files, while still allowing you to fold/unfold on demand with za or
zM.
