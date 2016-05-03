---
title: How to&#58; OS X ad-hoc batch resize images
date: 2016-05-03 19:12 UTC
tags: how-to, os x, images, resizing, photography
layout: post
renderer_options:
  tables: true
published: true
---

I am by no means a photographer who generates thousands of pictures per year
and has apps and workflows around all that, but a need to batch resize
big pictures occurs occasionally in my existence. Since I am a good friend with console,
I tend to use a simple command or a script instead of downloading more and
more apps and clogging my system. This is what I have been using lately:

`sips -Z 2560 *.jpg`

This simply resizes all jpg files in current directory to maximum width and
height of 2560px, while keeping the image aspect ratio (the `-Z` part takes care of that).

Happy resizing!
