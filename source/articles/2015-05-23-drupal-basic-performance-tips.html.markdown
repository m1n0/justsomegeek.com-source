---
title: Drupal&#58; Basic Performance Tips
date: 2015-05-23 15:01 UTC
tags: drupal, performance, dev
layout: post
renderer_options:
  tables: true
---

Performance and Drupal is a wide topic to cover, but there are some general things you can look at when having performance issues with your site. I will try to cover the most basic aspects to think about which I used on different project.
This article does not provide a lot of technical steps or tutorials, you can find all of that all over the internet.

## 1. Who are the users?
I think this is the first aspect to think about, because the answer to this question is necessary for all further decisions.

You HAVE to know what kind of users are coming to your site, especially whether you are dealing with **authenticated or anonymous** users. The usual answer is "a combination of both", but you need to have approximate ratio between these two, and you need to know which group is having performance issues. It could be that you only have 10% of authenticated users but they create 90%+ of load on your servers due to some complicated dashboard.

## 2. What do they want?
Use some analytics tool to see **how users behave on your site**, again, most of your performance issues might come from a single page doing some crazy SQL query. Think about this carefully, because your findings here will specify your strategy and actions. Do you have a lot of content pages and people visit them randomly? Can you specify some expected user behaviour and navigation across pages?

Identifying the user behaviour patterns and problems associated with them is the key here. An e-commerce site would have a simple model here - people visit the site, browse products and possibly buy them. A complex community site with blogs, forums, user messaging and other features is not that easy to guess - it happened to me far too often that customer identified the most important feature of a site and persuaded the whole team to focus on it - while google analytics showed that barely any user ever used it.

From the business point of view, it is sometimes very justifiable to remove some feature just because you find out it is not important to users but it makes it impossible for you to simply cache one of your most visited pages. This could for example be a block with some user-specific content.

## 3. What do I do with that?
Simple - use answers to those two questions and decide how to proceed.  
Two basic scenarios to think about:

- All problems coming from **anonymous traffic** - caching is the king - in this case you don't need to worry so much about optimisation - just make sure your web server actually server something as little as possible.
- **Authenticated users** - use optimisation and (partial) caching to achieve faster page loads. This can vary from code optimisation, through SQL optimisation to caching a specific block in a sidebar.

Your situation might be specific, but at this point you need to know what issues you need to solve, and what approach you will take to solve them.

## The Drupal stuff
Ok, how do I do all that in Drupal?

### The server
This should be obvious, but check [Drupal requirements](https://www.drupal.org/requirements) and [Drupal PHP requirements](https://www.drupal.org/requirements/php). These are the minimal requirements, so you can play around a bit to see if you get any performance gains. I usually set PHP memory_limit to at least 128MB as serious Drupal project with dozens of modules might need as much or even more in some situations. Google around for some tricks how to optimize DB and PHP performance, sometimes this can help a lot (especially when your server comes with very modest defaults).

### Caching

**Varnish**
The most basic thing to do to get some wild caching is set up **[Varnish](https://www.varnish-cache.org)**. There is a [module](https://drupal.org/project/varnish) to integrate with it and this one step might be the only thing to do is numerous cases, where most of the traffic and load comes from anonymous users.

**Boost**
In some cases, Varnish is not an option - you might be running on some shared web hosting or there is some other reason why you cannot install it. In that case, [Boost](https://www.drupal.org/project/boost) is an adequate alternative - it's a module that saves the generated HTML as files and serves them on next requests. The principle is very similar to what Varnish does, but Boost is potentially slower as it saves these files as regular files in a specified folder.

**Memcache**
Memcache is useful for caching stuff like PHP objects into memory. It requires Memcached extension to be installed on the server, so some configuration is required. The best part about memcache is that it has simple basic integration with Drupal and it works for authenticated users also as specific pieces of data are saved, not whole pages.

**Entity Cache**
Entity cache is a drupal module providing caching for Drupal entities. No configuration is required, and it works well with memcache.

### DB
In general, optimizing DB can be a lot of complicated work, but
no-sql, mongodb

### Drupal Config

**Turn off unnecessary stuff**  
Turn off modules like views ui, context ui, devel - basically anything that is not used. Turning off a module means that its files are not included and scanned for each page load - saving time executing PHP.

It is also possible to turn off watchdog database logging and use syslog instead - some modules create a lot of watchdog messages (e.g. Commerce) and therefore creating unnecessary load on db.

Turn off automatic updates - this one is a bit controversial, but if you keep an eye on security updates yourself anyway, you can swtich off this check - especially if you have a lot of things happening during cron jobs (like search indexing).

**Blocks**  
Drupal provides block caching mechanism which can be helpful for authenticated users. You can cache per user or role and this way save load of generating blocks with static/less frequently updated content.

**Views**  
There is quite a lot you can do with views. Views also provide caching, similar to blocks so you can start there. Furthermore, I believe that one of the most overlooked aspect of views is simple query optimization - people often forget that it is actually building SQL queries due to the nice user interface.  
Make your views as simple as possible, do not keep unused fields, filters and especially relationships. Use Distinct only when necessary and take a look at the order of your filters. Order of filters is crucial - turn on query run time debug and experiment with it, but the general rule of thumb is to think about your data - put filters which filter out most results as first, and the ones that only filter small percentage of results as last.  
Example:
You want to display nodes with some specific taxonomy term authored by some speific user. If you know that most users on your site only have 2-3 nodes, put the user filter first, as it will disregard most of the data, then the taxonomoy term as second.


Authcache

PHP - profiling, devel execution time, slow queries.
