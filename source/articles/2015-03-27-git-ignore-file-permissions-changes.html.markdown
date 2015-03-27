---
title: Git - Ignore File Permissions Changes
date: 2015-03-27 21:07 UTC
tags: dev
layout: post
---

It can get really annoying when "git status" reports changes in files which are not really changed, just some file permissions have been modified. In most cases, this does not need to be reflected in the version control and can be safely ignored.

Run this command in your terminal/shell inside a project to get rid of this:

```
$ git config core.fileMode false
```

It is possible to turn this feature back by running the same command with “true” parameter instead.

