#lang racket

(require rackunit
         "church_numerals.rkt")

;; basic math tests
(check-equal? (->nat zero) 0 "Zero")
(check-equal? (->nat (succ zero)) 1 "Successor of zero")
(check-equal? (->nat ((plus (nat-> 2)) (nat-> 3))) 5 "2+3 = 5")
(check-equal? (->nat ((mul (nat-> 4)) (nat-> 5))) 20 "4*5 = 20")
(check-equal? (->nat ((pwd (nat-> 7)) (nat-> 3))) 343 "7^3 =343")
(check-equal? (->nat ((mul ((plus (nat-> 2)) (nat-> 3))) (nat-> 4))) 20
              "(2+3)*4 = 20")

;; basic boolean tests
(check-equal? (->bool ((aand true) true)) #t "#t & #t")
(check-equal? (->bool ((aand true) false)) #f "#t & #f")
(check-equal? (->bool ((aand false) true)) #f "#f & #t")
(check-equal? (->bool ((aand false) false)) #f "#f & #f")
(check-equal? (->bool ((oor true) true)) #t "#t | #t")
(check-equal? (->bool ((oor true) false)) #t "#t | #f")
(check-equal? (->bool ((oor false) true)) #t "#f | #t")
(check-equal? (->bool ((oor false) false)) #f "#f | #f")

;; a more complex test
(check-equal? (->nat (((iif ((oor false) true)) ((plus (nat-> 2)) (nat-> 3)))
                      (succ zero)))
              5
              "if (#f | #t) 0 0.succ")

(check-equal? (->nat (ccar ((ccon (nat-> 2)) (nat-> 5)))) 2 "(car (cons 2 5))")
(check-equal? (->nat (ccar
                      (ccdr
                       ((ccon (nat-> 2))
                        ((ccon (nat-> 3)) (nat-> 1))))))
              3
              "(car (cdr (cons 2 (cons 3 1))))")
