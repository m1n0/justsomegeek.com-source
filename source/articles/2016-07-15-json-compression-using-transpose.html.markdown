---
title: JSON compression using transpose
date: 2016-07-15 16:09 UTC
tags: dev, json, services, optimisation
layout: post
renderer_options:
  tables: true
published: true
---
I stumbled upon a [blog post](http://malctheoracle.com/post/json-compression-by-rotating-data-90-degrees) about **compressing JSON data** by rotating it 90 degrees. This caught my eye, so I decided to have a play with it.

Malc (the author of the JSON rotating blog post) shows how **transposing object arrays into flat arrays of data** can compress a JSON response significantly, even when you use gzip (please read that blog post if you are interested. It’s quite short).

I figured that while Malc’s claims on saving data were interesting enough even after gzip came into play, it would be interesting to see how this would compete **in real world**, when the data to be returned might already be formatted in undesirable structure – **would the data savings be worth extra processing required to transpose the data?**

As an exercise, I decided to write a [very simple PHP app](https://github.com/m1n0/JSONRotator) to test this out. Here is what I did:

I generated 1000 random records with three keys: name, company and country and tried rotating them so that input like this:

~~~
$input = [
["name" => "Jeffrey Scott", "company" => "Rhyloo", "country" => "Indonesia"],
["name" => "Robert Hayes", "company" => "Roodel", "country" => "Brazil"],
["name" => "Juan Wells", "company" => "Jabberstorm", "country" => "Cape Verde"],
];
~~~

Gets converted into something like this:

~~~
$output = [
    'name' => ['Jeffrey Scott', 'Robert Hayes', 'Juan Wells'],
    'company' => ['Rhyloo', 'Roodel', 'Jabberstorm'],
    'country' => ['Indonesia', 'Brazil', 'Cape Verde'],
];
~~~

For measuring the processing impact of transposing, I used **both iterative and recursive transpose implementation**, but I could not measure the difference between the two probably due to local environment (the comparisons were inconclusive, **one performed better during one run, the other on another run**).

Here is an example run output:

~~~
Running with 10 records:
--- Encoding to JSON as-is: ---
Time elapsed: 2.598762512207E-5 s
JSON size: 649 B
JSON gzipped size: 207 B


--- Encoding to JSON transposed: ---
Time elapsed: 4.5061111450195E-5 s
JSON size: 392 B
JSON gzipped size: 185 B

Previous run comparison:
Time: 1.7339449541284
Size: 0.6040061633282
Gzipped size: 0.89371980676328


Recursive transpose (keys are not preserved, comparing to no-transpose run):
--- Encoding to JSON transposed: ---
Time elapsed: 4.4822692871094E-5 s
JSON size: 365 B
JSON gzipped size: 187 B

Previous run comparison:
Time: 1.7247706422018
Size: 0.56240369799692
Gzipped size: 0.90338164251208


Running with 1000 records:
--- Encoding to JSON as-is: ---
Time elapsed: 0.00086808204650879 s
JSON size: 65056 B
JSON gzipped size: 9274 B


--- Encoding to JSON transposed: ---
Time elapsed: 0.0017111301422119 s
JSON size: 36089 B
JSON gzipped size: 7830 B

Previous run comparison:
Time: 1.9711617687449
Size: 0.55473745696016
Gzipped size: 0.84429588095752


Recursive transpose (keys are not preserved, comparing to no-transpose run):
--- Encoding to JSON transposed: ---
Time elapsed: 0.0015218257904053 s
JSON size: 36062 B
JSON gzipped size: 7801 B

Previous run comparison:
Time: 1.7530898104916
Size: 0.55432242990654
Gzipped size: 0.84116885917619
~~~

(comparisons are done as current run var / previous run var)

My observations are that while relative size **savings can be substantial**, in real world when API does not normally returns hundreds or thousands of objects this means savings in the range of Bytes, which is not significant and most probably not worth extra processing. On the other hand, I think this can be useful **when constructing the data from scratch**, when there is no extra processing involved – saving 10-15% on response size is significant even when it comes to Bytes in that case, especially for a service that is called a lot.

Furthermore, there are other things to consider with this method – loss of human readability, JSON consumers have to be aware of not-so-much-standardised format (although it is reasonably simple to adjust) etc…

My conclusion is, that since microservices are getting ever so popular, this technique is **something an API designer should give at least few seconds of thought** and assess possible benefits.
