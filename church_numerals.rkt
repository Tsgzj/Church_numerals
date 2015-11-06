#lang racket

(define id (lambda (x) x))

(define succ (lambda (n) (lambda (f x) (f (n f x)))))

(define zero (lambda (f x) x))
(define one (succ zero))
(define two (succ one))
(define three (succ two))
(define four (succ three))
(define five (succ four))

(define plus
  (lambda (m n)
      (lambda(f x) (m f (n f x)))))

(define mul
  (lambda (m n)
      (lambda (f) (m (n f)))))

(define pwd
  (lambda (m n)
    (n m)))

(define (->nat churchnum)
  (churchnum add1 0))

(define (nat-> int)
  (if (= int 0)
      (lambda (f x) x)
      (succ (nat-> (- int 1)))))
