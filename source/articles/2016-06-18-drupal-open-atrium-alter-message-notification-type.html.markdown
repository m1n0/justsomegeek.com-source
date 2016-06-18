---
title: Drupal&#58; Open Atrium alter Message Notification type
date: 2016-06-18 12:07 UTC
tags: drupal, dev, open atrium
layout: post
renderer_options:
  tables: true
published: true
---

Recently I needed to send Created message instead of Updated when editors
publish node in Open Atrium.
This is how you can simply alter message type, which is subsequently passed
into `oa_messages_create` function and correctly picks up the correct Message
type and all it's arguments:

~~~ php
function my_module_oa_messages_type_alter(&$message_type, &$context) {
  if (isset($context['entity'])) {
    // Change notification type to "created" when publishing content.
    if (isset($entity->original)) {
      if ($entity->original->status == 0 && $entity->status == 1) {
        $message_type = 'oa_create';
        // Set the context uid as oa_create uses entity autor uid
        // instead of current user uid
        $context['uid'] = $entity->uid;
      }
    }
  }
}
~~~
