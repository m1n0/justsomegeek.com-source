---
title: How to remove extra button spacing/padding in Firefox
date: 2015-03-20 21:21 UTC
tags:
layout: post
---

I stumbled upon an issue when Mozilla Firefox added unexpected padding to my html buttons. After short research I found a simple solution:

```
button::-moz-focus-inner {
    padding: 0;
    border: 0
}
```
