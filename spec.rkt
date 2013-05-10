#lang racket

;; This is a test system which
;; should be sufficient to replace
;; check-expect and give better
;; errors than using just eq?

;; Written by Jesse Rogers
;; djrquazz@gmail.com

;; The only help I recieved was from
;; the racket documentation:
;; http://docs.racket-lang.org/

(provide spec should be-within-of be-true be-false spec-summary)

;; spec: String String -> Nothing
;;   PRE: message is an empty string if test passed else
;;        contains error message
;;   POST: writes to out result, no result
;; (spec "any message" (test returning string)) will print a
;; pretty string with result, purpose, and message
;;
;; see ./spec-test.rkt for examples
;;
;; --------------------------------------------
;;
;; should: Procedure, Any, Any#optional -> String
;;   PRE: Procedure exists and takes as many arguments
;;        of the same type in order as supplied, max 2
;;   POST: A string with a message if there was an error
;;         or empty if no error
;; (should op val val) determines if (fn val val) is true or false
;;
;; --------------------------------------------
;;
;; be-within-of: Num Num -> Lambda
;;   PRE: number that you want to compare with a given tolerance
;;   POST: a lambda which takes 1 argument and returns boolean
;;         of whether the argument it's passed is within your
;;         range of given number by the tolerance criteria you
;;         specified
;; (be-within-of 1.42 0.01) returns a lambda which will check if
;; the number passed to the lambda is within 0.01 of 1.42
;;
;; --------------------------------------------
;;
;; be-true: -> Lambda
;;   PRE: nothing
;;   POST: a lambda which takes a boolean and and determines
;;         if its true
;; (be-true) returns a lambda to test trueness
;;
;; --------------------------------------------
;;
;; be-false: -> Lambda
;;   PRE: nothing
;;   POST: a lambda which takes a boolean and and determines
;;         if its false
;; (be-false) returns a lambda to test falseness
;;
;; --------------------------------------------
;;
;; spec-summary: -> Nothing
;;   PRE: nothing
;;   POST: outputs the summary of your tests
;; (spec-summary) writes x passes, y failures

(define num-passes 0)
(define num-failures 0)

;; see interface above
(define (spec purpose message)
        (define passed? (= (string-length message) 0))
        (if passed?
          (set! num-passes (+ num-passes 1))
          (set! num-failures (+ num-failures 1)))
        (display (if passed?
                   (format "  PASSED: ~a\n" purpose)
                   (format "* FAILED: ~a\n    => ~a\n\n" purpose message))))

;; see interface above
(define (should operator value1 . extra-values)
        (if (null? extra-values)
            (should-one-param operator value1)
            (should-two-params operator value1 (car extra-values)))) ;; only 2 max atm

(struct annotated-lambda (proc note)
        #:property prop:procedure (struct-field-index proc))

;; see interface above
(define (be-within-of num error)
        (annotated-lambda
          (lambda (x) (< (abs (- num x)) error))
          (format "be-within-of ~a by ~a but given" num error)))

;; see interface above
(define be-true (annotated-lambda (lambda (b) b) "it,"))

;; see interface above
(define be-false (annotated-lambda (lambda (b) (not b)) "it,"))

;; see interface above
(define (spec-summary)
        (display (format "\n> Summary: ~a passes, ~a failures\n" num-passes num-failures))
        (set! num-passes 0)
        (set! num-failures 0))


(define (to-string val)
        (cond [(null? val) "null"]
              [(procedure? val)
               (cond [(annotated-lambda? val)
                      (annotated-lambda-note val)]
                     [else (object-name val)])]
              [else (format "~a" val)]))

(define (should-two-params operator value1 value2)
        (if (operator value1 value2) "" (format "~a should ~a ~a"
                                                (to-string value1)
                                                (to-string operator)
                                                (to-string value2))))

(define (should-one-param operator value)
        (if (operator value) "" (format "expected ~a ~a to be true"
                                        (to-string operator)
                                        (to-string value))))

