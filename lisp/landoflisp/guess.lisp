(defparameter *small* 1)
(defparameter *big* 100)

(defun guess-my-number ()
  ;;ashはビットシフト。負数は右シフト
  (ash (+ *small* *big*) -1))

(defun smaller ()
  ;1-jはデクリメント
  (setf *big* (1- (guess-my-number)))
  (guess-my-number))

(defun bigger ()
  ;1+はインクリメント
  (setf *small* (1+ (guess-my-number)))
  (guess-my-number))

(defun start-over ()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess-my-number))
