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

(provide spec should be-within-of)

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


;; see interface above
(define (spec purpose message)
        (display (string-append (if (= (string-length message) 0)
                                    "  PASSED: "
                                    "* FAILED: ")
                                purpose
                                (if (> (string-length message) 0)
                                    (format "\n    => ~a\n" message)
                                    "")
                                "\n")))

;; see interface above
(define (should operator value1 . extra-values)
        (if (null? extra-values)
            (should-one-param operator value1)
            (should-two-params operator value1 (car extra-values)))) ;; only 2 max atm

;; see interface above
(define (be-within-of num error)
        (lambda (x) (< (abs (- num x)) error)))



(define (type-of val)
        (cond [(number? val) 'number]
              [(string? val) 'string]))

(define (pretty-print-procedure p)
        (define ps (format "~a" p))
        (substring ps 12 (- (string-length ps) 1)))

(define (to-string val)
        (define type (type-of val))
        (cond [(not (symbol? type))
               (cond [(null? val) ""]
                     [(procedure? val) (pretty-print-procedure val)]
                     [else (format "~a" val)])]
              [(symbol=? type 'string) val]
              [(symbol=? type 'number) (number->string val)]))

(define (should-two-params operator value1 value2)
        (if (operator value1 value2) "" (format "~a should ~a ~a"
                                                (to-string value1)
                                                (to-string operator)
                                                (to-string value2))))

(define (should-one-param operator value)
        (if (operator value) "" (format "~a ~a should be true"
                                        (to-string operator)
                                        (to-string value))))

