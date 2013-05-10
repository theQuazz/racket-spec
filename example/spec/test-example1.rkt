#lang racket

(require "../example1.rkt")
(require "../../spec.rkt")

;; this is the tests for example1.rkt

(spec "Jesse should be a lucky name"
      (should be-true (lucky-name? "Jesse")))

(spec "Edward shoudln't be a lucky name"
      (should be-false (lucky-name? "Edward")))

(spec "foo should be true"
      (should be-true foo))

(spec "inc 10 should equal 11"
      (should = 11 (inc 10)))

(spec-summary)

