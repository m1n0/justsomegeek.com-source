---
title: Git&#58; Cleaning up merged branches
date: 2017-05-19 06:07 UTC
tags: dev, git, how-to
layout: post
renderer_options:
  tables: true
published: true
---

Using some kind of git branching strategy (e.g. [GitFLow](http://nvie.com/posts/a-successful-git-branching-model), [GitHub Flow](https://guides.github.com/introduction/flow) or other) normally produces quite a lot of branches. When these do not get merged on you machine, you end up with a lot of stranded branches locally, which can be annoying both when using console or some GUI.

Here is a simple way of cleaning these branches in bulk, just add this into your git config by running `git config -e --global`.

~~~
[alias]
    cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 git branch -d"
~~~

Getting rid of stranded branches is then just a matter of running `git cleanup` in your repository.

There are different flavors of doing this, the one above checks if branch was merged into `master` or `develop`, you can adjust it for your needs. Check this [Stack Overflow thread](http://stackoverflow.com/questions/6127328/how-can-i-delete-all-git-branches-which-have-been-merged) for more info and discussion.
