(defun c:setservdistances ()
	(setq filename (getstring "\n Enter File Name : "))
	(setq counter (getint "Initial Counter Number: "))
	(setq file (open (strcat (getvar "dwgprefix") (strcat filename ".txt")) "w"))
	(while (setq p1 (getpoint "\nSelect First Point: "))
    		(setq p2 (getpoint p1 "\nSelect Second Point: "))
  		(setq x1 (car p1))
                (setq y1 (cadr p1))
		(setq x2 (car p2))
                (setq y2 (cadr p2))
		(setq distance (sqrt (+ (expt (- x1 x2) 2 ) (expt (- y1 y2) 2 ) )) )
    		(command "_.line" p1 p2 "")
                (write-line (strcat (itoa counter) "," (rtos distance 2 2) ) file)
		(setq counter (+ counter 1))
  	)
  	(close file)
)

(defun c:getservdistances ()
	(setq filename (getstring "\n Enter File name : "))
	(setq counter (getint "Initial Counter Number: "))
	(setq file (open (strcat (getvar "dwgprefix") (strcat filename ".txt")) "w"))
  (while
	(setq entidad (car (entsel "\n Select a line: ")))
	(princ entidad)
	(setq pi (cdr (assoc 10 (entget entidad))))
        (setq pf (cdr (assoc 11 (entget entidad))))
	(setq xi (car pi))
	(setq yi (cadr pi))
	(setq xf (car pf))
        (setq yf (cadr pf))
        (setq distance (sqrt (+ (expt (- xi xf) 2 ) (expt (- yi yf) 2 ) )) )
        (princ (strcat "\nLine " (itoa counter) " : " (rtos distance 2 2) " units"))
	(write-line (strcat (itoa counter) "," (rtos distance 2 2) ) file)
	(setq counter (+ counter 1))
	(if (= entidad nil)
		(exit)
		)    
  )
	(close file)
)
