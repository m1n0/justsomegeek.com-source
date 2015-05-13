---
title: Drupal&#58; Slow Manage Features page
date: 2015-05-13 18:15 UTC
tags: drupal, features, performance, how-to, dev
layout: post
renderer_options:
  tables: true
---

Many sites and distributions built on Drupal make use of [Features](https://www.drupal.org/project/features). It often happens that having a big number of features on a site makes the Manage Features administration page unbearably slow. I experienced this on one of my recent projects built on [Open Atrium](http://openatrium.com), so I decided to fix this.

**The Solution**  
I created a simple module, [Features Package Settings](https://www.drupal.org/project/features_package_settings) which allows you to **reorder all features packages** so that they appear in desired order - **this changes the order in which the features State is being checked**, so your custom features can get checked first.  
Furthermore, it allows to **disable state checking** for packages which you are not so much interested in being checked (be cautios with this, you should check all your features periodically).

There is another tweak you can use to make the Manage Features page considerably snappier - [use my patch to Features](https://www.drupal.org/node/2466975) which allows for **intelligent caching of the Manage Features list**, making it render much faster.

If you like this, or have any ideas how to improve these efforts, please contribute to the issue queue with a supporting comment so that everyone can get this without patching. I also started an [issue on integrating the Features Package Settings into Features](https://www.drupal.org/node/2471961) so that such behaviour is shipped directly with the Features module.

###tl;dr:
Slow Manage Features page? Use this:

- [https://www.drupal.org/project/features_package_settings](https://www.drupal.org/project/features_package_settings)
- [https://www.drupal.org/node/2466975](https://www.drupal.org/node/2466975)

Like it? Show support in the issue queue:

- [https://www.drupal.org/node/2466975](https://www.drupal.org/node/2466975)
- [https://www.drupal.org/node/2471961](https://www.drupal.org/node/2471961)
