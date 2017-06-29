---
title: My Terminal setup
date: 2017-06-29 20:48 UTC
tags: dev, how-to
layout: post
renderer_options:
  tables: true
published: true
---

A few friends have asked me about my terminal setup, so I decided to write up
a small blog post about it.

This is what my terminal looks like in action:

![](http://res.cloudinary.com/m1n0/image/upload/v1498770649/01_zzyxzs.gif)

As you can see there are several things going on there, the prompt shows the current
Python environment and git branch and its status. There is also history-based autocomplete
of commands, and recognized commands are shown in green (not found ones in red).

Another small example is a quick jump functionality for easy navigation:
![](http://res.cloudinary.com/m1n0/image/upload/v1498770688/02_ov7yq6.gif)

This is not a detailed installation and setup guide, but more like a list of things and plugins
I use to achieve what I have.

**The basic setup**:

- [iTerm 2](https://www.iterm2.com/)
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) - Installation very well
  documented on the linked page
- [Cobalt2 theme](https://github.com/wesbos/Cobalt2-iterm) - This provides the color
  scheme, prompt etc.

Some extra plugins I like to use:

- [zsh-autosuggestions (autocomplete)](https://github.com/zsh-users/zsh-autosuggestions)
- [Syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Z](https://github.com/rupa/z) - this is the history-based jumping around plugin shown in the
second gif above, adding `z` into the list of plugins in my `~/.zshrc` worked for me

My whole list of enabled zsh plugins:

```plugins=(git zsh-autosuggestions composer npm z brew osx symfony2 zsh-syntax-highlighting python pip pyenv)```

I used [this article](https://www.smashingmagazine.com/2015/07/become-command-line-power-user-oh-my-zsh-z/)
when setting all this up, it has some good details in it.

I hope this helps, if you have any questions, suggestions, or some cool stuff
you use in your terminal please let me know in the comments below!
