#lang scheme
(require srfi/48)

;Hemant Mahato 03/01/22
;----------------------------------------------------------------------------------
;SOME CODE FROM WEEK 1 THAT IS NEEDED TO RUN SUBTOTAL AND LOOKUP FUNCTION
;Designing struct - creates structure to store items

(define-struct groceryItem(id description price))

;----------------------------------------------------------------------------------
 
;Variable - creating a list and storing items in the list by applying struct pattern;

(define grocery-master-list '( (make-groceryItem 1 "Peanuts" 0.99) (make-groceryItem 2 "Crackers" 0.69)
                               (make-groceryItem 3 "Chips" 2.19)(make-groceryItem 4 "Beer" 10.99)
                               (make-groceryItem 5 "Vegetables" 3.49)(make-groceryItem 6 "Soda" 2.19)
                               (make-groceryItem 7 "Candy" 1.39)))

;----------------------------------------------------------------------------------
;Lookup function takes an id and a list as parameters and and gets the
;item on the list by using the id provided to search the list

(define lookup
  (lambda (id grocery-master-list)
    (if (= id (car(cdr(car grocery-master-list)))) (car grocery-master-list)
        (lookup id (cdr grocery-master-list))
         )))

;TestCode for Lookup function
"Looking Up Item 6 -->" (lookup 6 grocery-master-list)

;----------------------------------------------------------------------------------
;getprice function -- takes an id parameter and and gets the
;price of an item on the list by using the id provided to search the list

(define getprice
  (lambda (id)
    (car(cdr(cdr(cdr(lookup id grocery-master-list)))))))

;TestCode for getprice function
"Price of item with ID 3 -->" (getprice 3)

;----------------------------------------------------------------------------------
;subtotal function and total function uses same idList in this program
;So, i am defining the idLists for both function together.
;This will define the idlist required to run both functions

(define idLists '(2 4 6 7 1 3 5))

;----------------------------------------------------------------------------------
;subtotal function - takes list of id's parameter and and gets the
;price of items listed on the id list and gives the subtotal amount (without tax)
;for all the prices that belong to the items whose id's have been listed

(define subtotal
  (lambda (idLists)
    (if(null? idLists) 0
    (+ (getprice (car idLists))
     (subtotal (cdr idLists))))))

;TestCode for subtotal function
"Subtotal of item with ID (2, 4, 6, 7, 1, 3, 5) -->" (subtotal idLists)

;----------------------------------------------------------------------------------

;STARTING WEEK 2 ASSIGNMENT

;----------------------------------------------------------------------------------
;----------------------------------------------------------------------------------

;Gettinminglist function - takes desired length of list as a parameter and creates a
;list of  7 random whole number values

(define gettiminglist
  (lambda (length)
  (if (= length 0) empty
    ( cons (+ 1 (random 7)) (gettiminglist  (sub1 length))))))

;No Test Code

;----------------------------------------------------------------------------------
;Length Function - gets the length of the list

(define lengths
  (lambda(list)
  (if (null? list)
      '()
      (cons (length (car list))
            (lengths (cdr list))))))

;TestCode for length function
(length(gettiminglist 20000))

;----------------------------------------------------------------------------------
;Runtime function - is a helper function that calls gettiminglist function as parameter
;and passes returned list to subtotal function

(define (runtime)
  (time(subtotal (gettiminglist 20000))))

;No Test Code

;----------------------------------------------------------------------------------
;Calling runtime function 5 times to calculate different runtimes

(runtime)
(runtime)
(runtime)
(runtime)
(runtime)


"THIS IS THE END OF THE PROGRAM"
;----------------------------------------------------------------------------------
;THIS IS THE END OF THE PROGRAM





  