---
title: Why Behavioural Testing&#63;
date: 2015-04-04 09:02 UTC
tags: dev, testing
layout: post
---

There seems to be a lot of buzz around Behavioural testing in recent years. Here is a couple of thoughts from my side why could this be happening:

1. **Grey-box testing**  
    Behavioural tests **combine** the two traditional **Black-box and White-box** approaches to testing into a hybrid Grey-box approach.

    >*White-box testing* is a method of testing software that tests internal structures or workings of an application, as opposed to its functionality.
    <sup>[[1]] (#references)</sup>

    This often aims for **"code coverage"** - covering the inner workings of software by checking the code, e.g. Unit testing.

    >*Black-box testing* - to use this method, view the program as a black box. Your goal is to be completely unconcerned about the internal behaviour and structure of the program. Instead, concentrate on finding circumstances in which the program does not behave according to its specifications.<sup>[[2]] (#references)</sup>

    The aim here is more towards the functionality, therefore **"test coverage"** is pursued, covering use cases/user stories...

    I find the power of Behavioural testing in combining these two - the test scenarios usually test on the system level -
    clicking links, filling in forms etc., ignoring what is happening in the background. On the other hand, it is easily
    possible to check specific logic of software by extending tests with custom step definitions, making single scenario
    doing both White- and Black-box testing at once, potentially saving some time spent on writing test cases.

2. **Test case format**  
    Behavioural test scenarios are much easier to write than e.g. a unit test, making it much easier for technically less experienced
    people to write and maintain tests. While stating that, it must not be forgotten that the custom step definitions are
    written in "real" code.  
    Example:

    ````
    Feature: ls
    In order to see the directory structure
    As a UNIX user
    I need to be able to list the current directory's contents

    Scenario:
      Given I am in a directory "test"
      And I have a file named "foo"
      And I have a file named "bar"
      When I run "ls"
      Then I should get:
        """
        bar
        foo
        """
      ````

3. **Testing on multiple levels**  
    Traditionally, there are 3 basic levels of testing: <sup>[[3]] (#references)</sup>
    * Unit testing - Unit testing verifies the functioning in isolation of software elements that are separately testable
    * Integration testing - Integration testing is the process of verifying the interactions among software components
    * System testing - System testing is concerned with testing the behaviour of an entire system

    This does not mean that one test scenario should be testing on all of these at once - it just means that Behavioural test
    scenarios are capable of both testing the code on the unit level and testing GUI with JS interactions on a web front-end. This makes
    it much easier to do required testing as one tool can be used for several targets of tests, saving training and other resources.

I believe that these aspects are part of the key reasons why Behavioural testing is so popular and they help with the
shift of mind-set of testing to be concerned about "code quality" and other technicalities to be more concerned about "software quality" and the
overall output of development.

While all this is nice and dandy, I still believe all kinds of test types are necessary to comprehensively test software,
I simply do not believe in "here's a new testing approach that will solve all our problems", so **we always have to assess
the specific project needs and constraints to make good decisions.**

---
<a name="references"></a>
References:  
*<small>[1] Williams, Laurie. "White-Box Testing", available online at: [http://www.chaudhary.org/WhiteBox.pdf](http://www.chaudhary.org/WhiteBox.pdf)</small>*  
*<small>[2] Myers, G., Badgett, T. & Sandler, C., 2012. "The Art of Software Testing". 3rd ed. New Jersey: John Wiley & Sons, Inc.</small>*  
*<small>[3] IEEE, 2014. SWEBOK. 3rd ed. Piscataway.</small>*

