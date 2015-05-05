---
title: How-to&#58; Remove Extra Button Spacing/Padding in Firefox
date: 2015-03-20 21:21 UTC
tags: dev, front-end, how-to
layout: post
---

It usually is Internet Explorer that makes the life of a web developer hard, but this time I stumbled upon an issue
when Mozilla Firefox added unexpected padding to my html buttons. After short research I found a simple solution to fix
this odd behaviour:

~~~
button::-moz-focus-inner {
    padding: 0;
    border: 0
}
~~~
