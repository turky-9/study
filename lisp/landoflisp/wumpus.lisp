(load "dot.lisp")

(defparameter *congestion-city-nodes* nil)
(defparameter *congestion-city-edges* nil)
(defparameter *visited-nodes* nil)
(defparameter *node-num* 30)
(defparameter *edge-num* 45)
(defparameter *worm-num* 3)
(defparameter *cop-odds* 15)

;;;;引数より小さい自然数を返す
(defun random-node ()
  (1+ (random *node-num*)))

(defun edge-pair (a b)
  (unless (eql a b)
    (list (cons a b) (cons b a))))


;;;;ランダムにノードを接続する
(defun make-edge-list()
  (apply #'append (loop repeat *edge-num*
                        collect (edge-pair (random-node) (random-node)))))

;;;;(loop repeat 10 collect 1)
;;;;  -> (1 1 1 1 1 1 1 1 1 1)
;;;;(loop for n from 1 to 10 collect n)
;;;;  -> (1 2 3 4 5 6 7 8 9 10)
;;;;(loop for n from 1 to 10 collect (1+ n))
;;;;  -> (2 3 4 5 6 7 8 9 10 11)


;;;;edge-listに含まれるnodeを探し、listで返す
(defun direct-edges (node edge-list)
  (remove-if-not (lambda (x)
                   (eql (car x) node))
                 edge-list))

;;;;nodeからたどれる到達可能な全てのnodeを返す
(defun get-connected (node edge-list)
  (let ((visited nil))
    (labels ((traverse (node)
               (unless (member node visited)
                 (push node visited)
                 (mapc (lambda (edge)
                         (traverse (cdr edge)))
                       (direct-edges node edge-list)))))
      (traverse node))
    visited))

;;;;島を見つける
(defun find-islands (nodes edge-list)
  (let ((islands nil))
    (labels ((find-island (nodes)
               (let* ((connected (get-connected (car nodes) edge-list))
                      (unconnected (set-difference nodes connected)))
                 (push connected islands)
                 (when unconnected
                   (find-island unconnected)))))
      (find-island nodes))
    islands))

;;;;島を接続する;
(defun connect-with-bridges (islands)
  (when (cdr islands)
    (appen (edge-pair (caar islands) (caadr islands))
           (connect-with-bridges (cdr islands))))

(defun connect-all-islands (nodes edge-list)
  (append (connect-with-bridges (find-islands nodes edge-list)) edge-list))
