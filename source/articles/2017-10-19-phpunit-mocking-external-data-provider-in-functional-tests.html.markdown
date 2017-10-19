---
title: PHPUnit&#58; Mocking external data provider in functional tests
date: 2017-10-19 17:58 UTC
tags: dev, testing, symfony
layout: post
renderer_options:
  tables: true
published: true
---
Mocking is a common thing in the world of automated testing, nothing to write
home about. Nevertheless, I decided to document how to do it in **Symfony with
PHPUnit** for future generations, or for when I forget and am too lazy to
read the documentation (whichever comes first).

So I have an API application, it accepts REST requests and returns JSON responses,
but some of the resources act as **proxy to other external providers** - how to test those?

Here is an example controller I have:

~~~

class MyController extends AbstractController {
    protected $externalDataLoader;

    public function __construct(ExternalDataLoader $externalDataLoader)
    {
        $this->externalDataLoader = $externalDataLoader;
    }

    /**
     * @Route ("my/resource/{id}")
     */
    public function myAction(int $id): Response
    {
        $data = $this->externalDataLoader->load('external/path', $id);

        // ... data is processed and formatted here.
        $result = $data;

        return $this->createResponse($result);
    }
}
~~~

and this `ExternalDataLoader` is registered as `my_external_data_provider` in
the DI container.

So a simple action that takes an argument, makes a request to external resource
and returns processed data. Now how to test this?

When it comes to **REST APIs, I like to write functional** (end-to-end) **tests** for two reasons:

1. It's not a tragedy when some piece of code is not covered with tests
2. The actual functionality, as used from the outside, is tested

So here is a simple example on **how to mock** such an external data provider when
writing a functional test:

~~~
public function myActionTest(): void
{
    $loaderMock = $this->getServiceMockBuilder('my_external_data_provider')
        ->setMethods(['load'])
        ->getMock();

    $loaderMock->expects($this->once())
        ->method('load')
        ->with('external/path', 1)
        ->willReturn(['something', 'something else']);

    if ($this->client === null) {
        $this->client = static::createClient(static::getKernelOptions());
    }

    $this->client->getContainer()->set('my_external_data_provider', $loaderMock);

    $this->client->request('GET', '/my/resource/1');
    $responseData = json_decode($this->client->getResponse()->getContent(), true);

    $this->assertSame([
        'data' => [
            'something',
            'something else',
        ],
        'jsonapi' => [
            'version' => '1.0',
        ]
    ], $responseData);
}
~~~

And **that's it, simple mocking**.

This test checks that when request is made to
`/my/resource/1`, the `load` function of the `externalDataLoader` is
called exactly once, with arguments `external/path` and `1`,
and that it returns an array with specified elements. This is done by replacing
the `externalDataLoader` (`my_external_data_provider` service) in DI container
with a mocked object.

**Happy testing!**
