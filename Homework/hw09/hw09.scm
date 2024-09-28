(define (cddr s) (cdr (cdr s)))

(define (cadr s) (car (cdr s)))

(define (caddr s) (car (cdr (cdr s))))


(define (ascending? asc-lst) 
    (or (null? asc-lst) ; The list is empty (base case),
      (null? (cdr asc-lst)) ; There's only one element in the list,
      (and (<= (car asc-lst) (cadr asc-lst)) ; The first two elements are in non-descending order,
           (ascending? (cdr asc-lst))))) ; and the rest of the list is in non-descending order.

(define (my-filter pred s) 
    (cond ((null? s) '()) ; If the list is empty, return an empty list.
        ((pred (car s)) (cons (car s) (my-filter pred (cdr s)))) ; If the first element satisfies pred, include it in the result.
        (else (my-filter pred (cdr s))))) ; Otherwise, exclude it and continue with the rest of the list.

(define (interleave lst1 lst2) 
    (cond ((null? lst1) lst2) ; If lst1 is empty, return lst2.
        ((null? lst2) lst1) ; If lst2 is empty, return lst1.
        (else (cons (car lst1) ; Take the first element of lst1,
                    (cons (car lst2) ; then take the first element of lst2,
                          (interleave (cdr lst1) (cdr lst2))))))) ; and recurse with the rest of the lists.

; Checks if an element is in a given list.
(define (element-in-list? elem lst)
  (cond ((null? lst) #f) ; If the list is empty, return false.
        ((equal? elem (car lst)) #t) ; If the element is the head of the list, return true.
        (else (element-in-list? elem (cdr lst))))) ; Otherwise, check the rest of the list.

; Removes repeated elements from a list, keeping the first occurrence.
(define (no-repeats lst)
  ; Helper function to filter the list.
  (define (unique-elements lst seen)
    (cond ((null? lst) '()) ; If the list is empty, return an empty list.
          ((element-in-list? (car lst) seen) 
           (unique-elements (cdr lst) seen)) ; If the element is already seen, skip it.
          (else 
           (cons (car lst) ; Otherwise, include this element
                 (unique-elements (cdr lst) (cons (car lst) seen)))))) ; and add it to the seen list.
  ; Start the unique-elements function with the original list and an empty seen list.
  (unique-elements lst '()))