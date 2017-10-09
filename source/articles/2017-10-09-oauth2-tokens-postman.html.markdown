---
title: OAuth2 Tokens in Postman
date: 2017-10-09 21:06 UTC
tags: dev, symfony, oauth
layout: post
renderer_options:
  tables: true
published: true
---
I like to use [Postman](getpostman.com) when developing REST APIs. It allows me
to save, group and share different requests, prepare different payloads to test different
scenarios and it helps with manual (some people use it even for automatic) testing.
Furthermore, securing APIs with OAuth2 is very common - it's secure and practical.
But when it comes to combining the two, it can be a bit tricky to get things
running smoothly.

I don't like to change my development environment for the sake of convenience,
so I do not disable OAuth locally. This means that I have to pass a valid OAuth token
with each request. This can get **very annoying** though, you have to request a token
and then paste it into each request etc., so I started looking into
**automatic OAuth token request functionality** in
Postman. I had issues to get it working locally (and could not get it working), but it does not even completely solve the annoying part of making sure you have the correct token in a request.

I **grew tired of copy-pasting** tokens and **automated** the whole thing. Once I spent few minutes and looked into it I was banging my head against the wall asking myself why I hadn't done this
earlier.

Here is my setup:<br />
I set up a **simple test script** in Postman which is automatically run after each
Request Token request, which sets the **retrieved token into a postman environment variable**.

~~~javascript
var jsonData = JSON.parse(responseBody);
postman.setEnvironmentVariable("accessToken", jsonData.access_token);
~~~

Next, I just use this variable in every saved request header like this:

~~~
Authorization: Bearer {{accessToken}}
~~~

And that's it - no need for anything else, just request a token **once** and use it
until it expires with all the requests you have!
