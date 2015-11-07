#lang racket

(define zero
  (lambda (f)
    (lambda (x) x)))

(define succ
  (lambda (n)
    (lambda (f)
      (lambda (x)
        (f ((n f) x))))))

;; define some small numbers
;; maybe useful later
;; especially for test
(define one (succ zero))
(define two (succ one))
(define three (succ two))
(define four (succ three))
(define five (succ four))

;; plus => (lambda (m n f x) (lambda (n f (n f x))))
(define plus
  (lambda (m)
    (lambda (n)
      (lambda (f)
        (lambda (x)
         ((m f) ((n f) x)))))))

;; multiply => (lambda (m n f) (m (n f)))
(define mul
  (lambda (m)
    (lambda (n)
      (lambda (f)
        (m (n f))))))

;; power => (lambda (m n) (n m))
(define pwd
  (lambda (m)
    (lambda (n)
    (n m))))

;; for test
;; ->nat will convert a church encoded number into natural number
(define (->nat churchnum)
  ((churchnum add1) 0))

;; nat-> will convert a nature number into church encoded number
(define (nat-> int)
  (if (= int 0)
      zero
      (succ (nat-> (- int 1)))))
