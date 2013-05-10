## A Simple Test Framework for Racket/Scheme

One of the goals was to not use anything which is high level according to the University.
I am not sure if I succeeded... up to them to decide.

Its pretty much a rough draft at this point but I think it works well enough to use
and since I wrote it myself I hope the university will let me use it on my assignments.

### Usage

The best way to use this is probably to create a `spec/` dir within your application
and create your tests. Test files should start with `test-` and end with the `.rkt`
extension. For example `test-foo.rkt` would be a good name for a test file, especially
if it is testing `foo.rkt`.

Within the test file you should require `spec.rkt` and the file you want to test. It
might look something like this:

    #lang racket ;; test-foo.rkt

    (require "../foo.rkt")
    (require "/path/to/spec.rkt")

Then you can specify your tests:

    (spec "bar should be a number"
          (should number? bar))

    (spec "bar should equal 1"
          (should = 1 bar))

There are a few functions to help your test like be-within-of for decimal numbers
and be-true or be-false for booleans. Also, at the end of your file you can put

    (spec-summary)

Which will print out the number of passes and failures since the time you ran the tests
or the last summary you output.

When your `test-foo.rkt` file is done you can run it by using

    $ racket test-foo.rkt # racket must be in your PATH

To run all tests in `spec/`

    $ cd spec/
    $ racket /path/to/run-spec.rkt

### Examples

See `example` for usage and reference
To run the example, do something like this:

    # cd src dir; files example1.rkt, example2.rkt, example3.rkt
    $ cd example

    # has t files test-example1.rkt, test-example2.rkt, test-example3.rkt
    $ cd spec

    # run the tests
    $ racket ../../run-spec.rkt

