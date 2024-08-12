# Dotfiles


This is my attempt to track and automate my configurations for Linux.

This is intended for my personal use and thus there is no versioning and no gurantee anything will work.
It is here for my personal use and also to share for anybody who is interested for informationl use.



## Installation

I would not recommend installing this! Why would you? You will get a system tailored for my needs without knowing how
to utilize it. If you knew it you would not copy it.

But there is a `bootstrap-ansible' script, that will setup ansible and then install the role (still just work in progress).

As well as the Ansible roles, depending on my system and its needs.


## Organization

I have a folder `ansible`, where I try to keep my setup automized for my needs. This will be adapted as needed and updated as I see fit.
There is a `dots` subfolder, here I organize my configs in a way I think its comfortable.
The `bin` subdir is to track scripts I might want to use and maybe link to `~/.local/bin`.

`docs` may contain more detailed information about anything.
`nix` is a placeholder for me - so far I have not really written any Nix, I am curious about it and try to learn it.
`.private` is a placeholder, where everything inside will be ignored by git. This folder will be used for templated that are rendered or any system specific configs, 
that I do not want to end up in my repo, but could 'source' from a known location.


## Credits

Here I want to mention and thank some people or projects.
I got inspired for this section by [@NotAShelf](https://github.com/NotAShelf) as he used this in his [nyx](https://github.com/NotAShelf/nyx?tab=readme-ov-file#credits--special-thanks).
So I can start with it - this looks like a valuable place to learn about Nix. I did not dig into it yet, but the 'Readme' alone already gave me some inspirations.

For my zsh config I need to thank [The Valuable Dev](https://thevaluable.dev/) I learned a lot about zsh from his blog and got good inspiration from his [dotfiles](https://github.com/Phantas0s/.dotfiles).

For the Ansible part I got a lot inspiration by [Logan Marchione](https://github.com/loganmarchione) [here](https://github.com/loganmarchione/ansible-arch-linux).

[tjdevries](https://github.com/tjdevries) for his work on vim [his youtube](https://www.youtube.com/@teej_dv) and the [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim/) which is the base for my nvim lua setup.
[Folke Lemaitre](https://github.com/folke) for his countless contributions to the nevim ecosystem and of course I learned much from his code and copied some parts of his [LazyVim](https://github.com/LazyVim/LazyVim) to improve my setup.
[Tim Pope](https://github.com/tpope) for his contributions to the vim ecosystem and some really nice plugins I use or did use. A valuable resource to learn vimscript (which I gave up in favor of lua), but especially of how to utilize (n)vim nicely.

There are countless 'dotfiles' and blogs that got me inspired, that I cannot name anymore. But in general thanks to all the people sharing this in the public and helping others achieve nice results!

## Resources

Here also some resources that helped me learn much, alongside the 'dotfile repos' and the source code of some of the tools I use.

[the missing semester](https://missing.csail.mit.edu/) was a valuable resource for me, getting started with some of the command line stuff.
[The Valuable Dev](https://thevaluable.dev/)  as a blog was a great resource, especially getting my 'zsh' config to the next level and getting rid of 'omz'(I dont think its a bad project, but I used  (and still use) a little subset of it, and it made my startup time slow).
[Drew Neils Vimcasts](http://vimcasts.org/) Vimcasts as well as his books gave my (n)vim usage a bit boost, after getting started with 'vimtutor'.
[from bash to zsh](https://www.bash2zsh.com/) This book was a valuable resource to better understand zsh.
