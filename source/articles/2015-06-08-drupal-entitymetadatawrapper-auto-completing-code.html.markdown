---
title: Drupal&#58; EntityMetadataWrapper auto-completing code
date: 2015-06-08 20:42 UTC
tags: drupal, dev
layout: post
renderer_options:
  tables: true
---

Using `entity_metadata_wrapper()` from the [Entity API](https://www.drupal.org/project/entity) module has a **lot of advantages** discussed all over the internet, but it has been bugging me for quite some time that the wonderful switch from array structures to OOP has not solved one of the obvious **problems - no auto-completing code** in the editor.

A very quick glance into the `entity_metadata_wrapper()` function showed me that this can be **easily solved** (at least partially) - with `EntityDrupalWrapper`.  
The thing is, that `entity_metadata_wrapper()` returns an object based on provided arguments.  
The "old" way:

~~~ php
<?php
$node_wrapper = entity_metadata_wrapper('node', $node);
?>
~~~

Since `entity_metadata_wrapper()` can return different object types, your IDE cannot determine which one actually gets returned and therefore does not provide proper auto-completing. If `EntityDrupalWrapper` is used directly, this problem goes away and you can enjoy at least some basic auto-completing of methods.  
The `EntityDrupalWrapper` way:

~~~ php
<?php
$node_wrapper = new EntityDrupalWrapper('node', $node);
?>
~~~

**Result:**
![](http://res.cloudinary.com/m1n0/image/upload/v1433797361/EntityDrupalWrapper_code-completion_foimsc.png)

This unfortunately adds auto-complete for the basic methods only, you still need to type your field names manually.

**Important:**  
Use this only when you know what you are doing and when you are sure that `entity_metadata_wrapper()` would return `EntityDrupalWrapper` anyway - this only happens when you pass a valid entity type like `node` or `user` as the first parameter.



