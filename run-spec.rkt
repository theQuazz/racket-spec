#lang racket

(define (output-to-console file)
        (define name (some-system-path->string file))
        (display (format "\n--Running ~a...\n\n" name))
        (dynamic-require file #f)
        (display (format "\n--Finished running ~a...\n\n" name)))

(define (is-a-test-file file)
        (define name (some-system-path->string file))
        (and (file-exists? file)
             (bytes=? (filename-extension file) #"rkt")
             (>= (string-length name) 5)
             (string=? (substring name 0 5) "test-")))

(for-each (lambda (file)
            (if (is-a-test-file file) (output-to-console file) '()))
          (directory-list))

