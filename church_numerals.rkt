#lang racket

;; define zero
(define zero
  (lambda (f)
    (lambda (x) x)))

;; successor of n => (lambda (n)  (lambda (f x) (f (n f x))))
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

;; define #t and #f
;; accorfing to the iif we will define later
;; true
(define true
  (lambda (x) (lambda (y) x)))

;; false
(define false
  (lambda (x) (lambda (y) y)))

;; if => (lambda (condition true else)
;;             (condition true else))
(define iif
  (lambda (c)
    (lambda (t)
      (lambda (e)
        ((c t) e)))))

;; not => (lambda (a) (a #f #t))
(define not
  (lambda (a)
    ((a false) true)))

;; or => (lambda (a b)
;;             (if a true b))
(define oor
  (lambda (a)
    (lambda (b)
      (((iif a) true) b))))

;; and => (lambda (a b)
;;            (if a b false))
(define aand
  (lambda (a)
    (lambda (b)
      ((a b) false))))

;; convert church encoded bool into racket bool
;; ->bool => (lambda (b) (b #t #f))
(define (->bool bool)
  ((bool #t) #f))

;; list definition
(define ccons
  (lambda (x)
    (lambda (y)
      (lambda (s) ((s x) y)))))

(define ccar
  (lambda (s)
    (s true)))

(define ccdr
  (lambda (s)
    (s false)))

(define NULL
  (lambda (x)
    true))

;; NULL? => (lambda(x)
;;             (x (lambda (x y) false)))
(define NULL?
  (lambda (x)
    (x
     (lambda(x)
       (lambda(y)
         false)))))

(provide zero
         succ
         plus
         mul
         pwd
         true
         false
         aand
         oor
         iif
         ccons
         ccar
         ccdr
         ->bool
         ->nat
         nat->)
