#lang racket

(define (load-spec file) (dynamic-require file #f))

(for-each (lambda (file)
            (define name (some-system-path->string file))
            (cond [(string=? (substring name 0 5) "test-")
                   (and (display (format "\n--Running ~a...\n\n" name))
                        (load-spec file)
                        (display (format "\n--Finished running ~a...\n\n" name)))]))
          (directory-list))

