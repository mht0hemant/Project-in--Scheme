#lang scheme
(require srfi/48)

;Hemant Mahato 03/01/22
;----------------------------------------------------------------------------------

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
;getdesc function - takes an id parameter and and gets the
;description of an item on the list by using the id provided to search the list

(define getdesc
  (lambda (id)
     (car(cdr(cdr(lookup id grocery-master-list))))))

;TestCode for getdesc function
"Description of item with ID 1 -->" (getdesc 1)

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

(define idLists '(2 4 6 7))

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
"Subtotal of item with ID (2, 4, 6, 7) -->" (subtotal idLists)

;----------------------------------------------------------------------------------

"Subtotal of item with ID (2, 4, 6, 7) -->"(display(format "~0,2F" (subtotal idLists)))

;total function - takes list of id's parameter and and gets the
;price of items listed on the id list and gives the total amount (subtotal + 11% TAX)
;for all the prices that belong to the items whose id's have been listed

(define total
  (lambda (idLists)
    (let ((a (subtotal idLists)) (b (/ 11 100))) (format "~0,2F" (+ a (* a b))))
    ))
    
;TestCode for total function
"Total with 11% tax + Subtotal of item with ID (2, 4, 6, 7) -->"(total idLists)

;----------------------------------------------------------------------------------
;hepler function - helps getlist function to take in parameters and is called by
;getlist function

(define helper
  (lambda (grocery-master-list list)  
  (if (null? grocery-master-list) list
      (cons (cdr (car grocery-master-list)) (helper (cdr grocery-master-list) list)))))

;getlist function - takes no parameters and displays a list from master list where
;each inner list is the id, description and price of each object

(define getlist
 (helper grocery-master-list list))

;TestCode for calling getlist function
"Object list from master list -->"
getlist

"THIS IS THE END OF THE PROGRAM"
;----------------------------------------------------------------------------------
;THIS IS THE END OF THE PROGRAM