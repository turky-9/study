;;;;dotファイルを作成する


;;;;prin1-to-string
;;;;  文字列を返す
;;;;complement
;;;;  引数の述語の反対の述語を返す
;;;;substitute
;;;;  置換
(defun dot-name (exp)
  (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string exp)))



(defparameter *max-label-length* 30)
;;;;write-to-string
;;;;  :pretty nilは改行とかタブを出力しない
(defun dot-label (exp)
  (if exp
      (let ((s (write-to-string exp :pretty nil)))
        (if (> (length s) *max-label-length*)
            (concatenate 'string (subseq s 0 (- *max-label-length* 3)) "...")
            s))
      ""))




(defparameter *my-node* '((living (you are in the living))
                          (garden (you are in garden. It is beautiful))
                          (aaa (aaa bbb ccc ddd eeeee fffff))))

;;;;dot言語中のnodeの宣言を出力する
;;;;mapc
;;;;  mapcarと違い結果のリストを返さない
(defun node->dot (nodes)
  (mapc (lambda (node)
          (fresh-line)
          (princ (dot-name (car node)))
          (princ "[label=\"")
          (princ (dot-label node))
          (princ "\"];"))
        nodes))


(defparameter *my-edge* '((living (garden door)
                                  (aaa hoge))
                          (garden (living door))
                          (aaa (living ladder))))

;;;;dot言語中のedgeを出力する
;;;;有向グラフ
(defun edges->dot (edges)
  (mapc (lambda (node)
          (mapc (lambda (edge)
                  (fresh-line)
                  (princ (dot-name (car node)))
                  (princ "->")
                  (princ (dot-name (car edge)))
                  (princ "[label=\"")
                  (princ (dot-label (cdr edge)))
                  (princ "\"];"))
                (cdr node)))
        edges))

;;;;dot言語中のedgeを出力する
;;;;無向グラフ
(defun uedges->dot (edges)
  (maplist (lambda (lst)
             (mapc (lambda (edge)
                   (unless (assoc (car edge) (cdr lst))
                     (fresh-line)
                     (princ (dot-name (caar lst)))
                     (princ "--")
                     (princ (dot-name (car edge)))
                     (princ "[label=\"")
                     (princ (dot-label (cdr edge)))
                     (princ "\"];")))
                   (cdar lst)))
           edges))


;;;;dot言語で有向グラフを出力する
(defun graph->dot (nodes edges)
  (princ "digraph{")
  (node->dot nodes)
  (edges->dot edges)
  (princ "}"))

;;;;dot言語で無向グラフを出力する
(defun ugraph->dot (nodes edges)
  (princ "graph{")
  (node->dot nodes)
  (uedges->dot edges)
  (princ "}"))


;;;;引数のthunkを実行し、shellからdotを実行する
(defun dot->png (fname thunk)
  (with-open-file (*standard-output*
                   fname
                   :direction :output
                   :if-exists :supersede)
    (funcall thunk))
    (ext:shell (concatenate 'string "dot -Tpng -O " fname)))

;;;;thunkに処理を結めて関数に渡たす
;;;;のりみたいな関数
(defun graph->png (fname nodes edges)
  (dot->png fname
            (lambda ()
              (graph->dot nodes edges))))
;;;;のりみたいな関数(無向グラフ)
(defun ugraph->png (fname nodes edges)
  (dot->png fname
            (lambda ()
              (ugraph->dot nodes edges))))


