---
title: Drupal&#58; debugging to a file
date: 2016-05-03 18:19 UTC
tags: drupal, dev, debugging
layout: post
renderer_options:
  tables: true
published: true
---

Drupal and debugging often means using [Devel](https://www.drupal.org/project/devel), which ships with some
very useful functions like [`dpm()`](https://api.drupal.org/api/devel/devel.module/function/dpm/8.x-1.x), [`kpr()`](https://api.drupal.org/api/devel/devel.module/function/kpr/8.x-1.x), [`dpq()`](https://api.drupal.org/api/devel/devel.module/function/dpq/8.x-1.x) and more for outputting debug stuff,
but these sometimes fail to display things on your site due to some reasons (e.g. called too
late, an issue with a template, AJAX...).

Devel ships with a bit more magic that can help though, you can simply use [`dd()`](http://www.drupalcontrib.org/api/drupal/contributions%21devel%21devel.module/function/dd/7)
which "logs a variable to a drupal_debug.txt in the site's temp directory", so you can simply
do

`dd(‘something’);`

in your code, and then `tail -f /tmp/drupal_debug.txt` for live feed
of your debug goodies (or just open the file in an editor like a normal person).

*<small>Note: This is more-or-less a last resort help for me, I prefer using breakpoints
in my IDE which is way better and does not require knowing any of this. But I though
`dd()` was cool as well :-).</small>*
