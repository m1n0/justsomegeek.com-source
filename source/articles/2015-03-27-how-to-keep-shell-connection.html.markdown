---
title: How to Keep Shell Connection
date: 2015-03-27 21:14 UTC
tags: dev
layout: post
---

It happens too often that I get disconnected from a shell connection after a while of inactivity with message `Write failed: Broken pipe`.
To prevent this, simply put:

```
Host *
    ServerAliveInterval 30
```

in your `~/.ssh/config` (OS X) or `/etc/ssh/ssh_config` (Linux) file.

This will make sure that null packet will be sent every 30 seconds (you can edit the interval) to the server to keep the connection alive.
