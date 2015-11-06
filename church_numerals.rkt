#lang racket

(define id (lambda (x) x))

(define succ
  (lambda (n)
    (lambda (f)
      (lambda (x)
        (f ((n f) x))))))

(define zero
  (lambda (f)
    (lambda (x) x)))
(define one (succ zero))
(define two (succ one))
(define three (succ two))
(define four (succ three))
(define five (succ four))

(define plus
  (lambda (m)
    (lambda (n)
      ((m succ) n))))

(define mul
  (lambda (m)
    (lambda (n)
      ((m (plus n)) zero))))

(define pwd
  (lambda (m)
    (lambda (n)
    (n m))))

(define (->nat churchnum)
  ((churchnum add1) 0))

(define (nat-> int)
  (if (= int 0)
      zero
      (succ (nat-> (- int 1)))))
