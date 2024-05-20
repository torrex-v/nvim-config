set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

colorscheme desert

let mapleader=" "
nnoremap <leader>pv :Vex<CR>
"no recursive execution
nnoremap <leader><CR> :so ~/AppData/Local/nvim/initTest.vim<CR>
nnoremap  <F5><CR>lua require'dap'.continue()<CR>
nnoremap  <F10><CR>lua require'dap'.step_over()<CR>
nnoremap  <F11><CR>lua require'dap'.step_into()<CR>
nnoremap  <F12><CR>lua require'dap'.step_out()<CR>
nnoremap  <Leader>b<CR>lua require'dap'.toggle_breakpoint()<CR>
nnoremap  <Leader>B<CR>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap  <Leader>lp<CR>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap  <Leader>dr<CR>lua require'dap'.repl.open()<CR>
nnoremap  <Leader>dl<CR>lua require'dap'.run_last()<CR>


imap xx yy
imap y zz
imap z aa
aaaaaaaa
