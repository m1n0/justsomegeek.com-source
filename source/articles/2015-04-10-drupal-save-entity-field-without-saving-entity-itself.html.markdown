---
title: Drupal&#58; Save Entity Field Without Saving Entity Itself
date: 2015-04-10 21:27 UTC
tags: drupal, how-to, dev
layout: post
renderer_options:
  tables: true
---

Drupal provides API for saving entities such as `node_save()` or `user_save()`. Functions like this update the whole provided entity, using up a lot of resources. There are scenarios when only one or two  fields need to be updated, e.g. a bulk operation. For such cases, `field_attach_update()` can be used.
I found inspiration on this topic on [Urban Insight blog by Ki Kim](https://www.urbaninsight.com/2011/10/24/saving-nodes-fields-without-saving-node-itself) and wanted to try it out in practice.
Example:

~~~ php
<?php
$node = node_load($nid);
$node->field_fieldname[LANGUAGE_NONE][0]['value'] = 'some value';
field_attach_update('node', $node);
entity_get_controller('node')->resetCache(array($node->nid));
?>
~~~

It is important to note that this might not trigger the same behaviour as "normal" entity save does, e.g. Rules may not trigger etc. Therefore, **use this with caution** and only when you know what you are doing. Furthermore, [Drupal documentation](https://api.drupal.org/api/drupal/modules%21field%21field.attach.inc/function/field_attach_update/7) mentions that caches for the saved entity need to be manually flushed after saving one specific field (see the last line of the code example).

## Testing  
I was curious about the **performance implications** of this, so I did a small test, running on my local machine, on almost clean Drupal. I ran these tests simply in the Devel Execute PHP Code page, with no change of the setup in between test runs. Ten rounds were done for each variant to get the average run time.

**Take 1**  
"Standard" Drupal API:  

~~~ php
<?php
$start = microtime(true);

$node = node_load(1);
$node->field_my_field[LANGUAGE_NONE][0]['value'] = 'Testing stuff 1';
node_save($node);

print(microtime(true) - $start);
?>
~~~

Average run time: **0,0534861564636s**

**Take 2**  
Using `field_attach_update()`:

~~~ php
<?php
$start = microtime(true);

$node = node_load(1);
$node->field_my_field[LANGUAGE_NONE][0]['value'] = 'Testing stuff 2';
field_attach_update('node', $node);
entity_get_controller('node')->resetCache(array($node->nid));

print(microtime(true) - $start);
?>
~~~

Average run time: **0,0348172426224s**

## Results

It seems that using `field_attach_update()` may lead to significant performance gains, in my case the average run time was **35% faster** than when using `node_save()`. This performance gain will differ significantly in different scenarios - amount of concurrent users, server setup, entity complexity (like number of fields) and other factors will have influence on this. Nevertheless, a chance for an improvement like this should always be explored.

Additionally, **concurrency** issues can be addressed with this approach. While `node_save()` updates whole bunch of records across multiple tables, `field_attach_update()` updates the required field table only, preventing **deadlocks** to happen.

Therefore, if using `field_attach_update()` suits your situation and needs, I say go for it!


---

<div id="data-wrapper" class="clearfix">
For anyone curious about the exact numbers for each run, [here is the whole "data-set"](#).
  <div id="data" style="display: none">
  <div id="take-1">  

  |     Run | Time            |
  |--------:|-----------------|
  | 1       | 0,0886168479919 |
  | 2       | 0,0466141700745 |
  | 3       | 0,0515279769897 |
  | 4       | 0,0519001483917 |
  | 5       | 0,0480201244354 |
  | 6       | 0,0492122173309 |
  | 7       | 0,0537130832672 |
  | 8       | 0,0479199886322 |
  | 9       | 0,0477869510651 |
  | 10      | 0,0495500564575 |
  | **Take 1 Average** | **0,0534861564636** |

  </div>

  <div id="take-2">  

  |     Run | Time            |
  |--------:|-----------------|
  | 1       | 0,0256879329681 |
  | 2       | 0,0329999923706 |
  | 3       | 0,0359990596771 |
  | 4       | 0,0301089286804 |
  | 5       | 0,0587899684906 |
  | 6       | 0,0330111980438 |
  | 7       | 0,0315041542053 |
  | 8       | 0,0349240303040 |
  | 9       | 0,0325751304626 |
  | 10      | 0,0325720310211 |
  | **Take 2 Average** | **0,0348172426224** |

  </div>
  </div>
</div>

