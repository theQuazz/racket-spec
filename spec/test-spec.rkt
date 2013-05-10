#lang racket

(require "../spec.rkt")

(spec "1 equals 1"
      (should eq? 1 1))

(spec "1 equals 0 ~ intentional fail"
      (should eq? 1 "0"))

(spec "symbol=? operator works"
      (should symbol=? 'pear 'pear))

(spec "lambda works"
      (should (lambda (x y) (= x y)) 1 1))

(spec "decimal numbers should be comparable with be-within-of"
      (should (be-within-of 1.42 0.01) (sqrt 2)))

(spec "be-within-of should fail ~ intentional fail"
      (should (be-within-of 1.42 0.001) (sqrt 2)))

(spec "\"apple\" equals \"apple\""
      (should eq? "apple" "apple"))

(spec "\"apple\" equals \"orange\" ~ intentional fail"
      (should eq? "apple" "orange"))

(spec "'sym should be a symbol"
      (should symbol? 'sym))

(spec "1 shouldn't be a symbol ~ intentional fail"
      (should symbol? 1))

(spec "'sym shouldn't be a string ~ intentional fail"
      (should string? 'sym))

(spec "true should just be its own test"
      (should be-true #t))

(spec "same with false"
      (should be-false #f))

(spec "failing trueness test ~ intentional fail"
      (should be-true #f))

(spec "failing falseness test ~ intentional fail"
      (should be-false #t))


(spec-summary)

