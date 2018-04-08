Vim Checkbox
============

Description
-----------

Simple plugin that toggles text checkboxes in Vim. Works great if you're using
a markdown file for notes and todo lists.

Originally written by Jonas Kramer, forked and modified to add alternate
checkbox styles, easy user config, and quick checkbox add/remove.

Installation
------------

The simplest install is to just copy the script into your plugin folder, e.g.
`~/.vim/plugin/`.

However I recommend using a system like Vundle or Vim-Plug, and installing that
way. e.g. for Vim-Plug, add this to your vimrc:

```vimscript
Plug 'MikeDacre/vim-checkbox'
```

And then run `:PlugInstall` in vim.


Usage
-----

Type `<leader>tt` to toggle the (first) checkbox on the current line. A checkbox
is either `[ ]` (unchecked) or `[x]` (checked). For example,

    * [ ] Do some work.

becomes

	* [x] Do some work.

and vice versa.

Configuration
-------------

To check the checked character from x, set `g:checkbox_checked_char`

    `let g:checkbox_checked_char = 'X'`

To use the underline style unchecked box, set `g:checkbox_unchecked_underline`
to 1.

To customize the commands:

    `let g:checkbox_toggle_command = '<leader>tt'`
    `let g:checkbox_insert_remove_command = '<leader>cb'`
