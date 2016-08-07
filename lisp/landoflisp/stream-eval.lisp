;;;;print
(print "hello lisp")

(progn (print "aaa")
       (print "bbb")
       (print "ccc"))

(progn (prin1 "aaa")
       (prin1 "bbb")
       (prin1 "ccc"))


;;;;read
;;;;名前はダブルクォートでくくってね
(defun say-hello ()
  (print "please type your name:")
  (let ((name (read)))
    (print "Nice to meet you, ")
    (print name)))
(say-hello)


;;;;色々なprint
(print 1)
(print 'a)
(print "print")
(print '#\a)

(princ 1)
(princ 'a)
(princ "print")
(princ '#\a)


;;;;read-line
;;;;enterが押されるまで1行読み込む
(print "test of read-line")
(let ((aaa (read-line)))
  (print aaa))

;;;;関数の動的実行
(let ((f '(+ 1 2)))
  (eval f))


;;;;commmon listの条件判断
;(if <条件部> <then節> <else節>)
;(when test Ｓ式１ Ｓ式２ Ｓ式３ ..... )
;(unless test Ｓ式１ Ｓ式２ Ｓ式３ ..... )
;(cond ( 条件部Ａ Ｓ式A1 Ｓ式A2 ... )
;      ( 条件部Ｂ Ｓ式B1 Ｓ式B2 ... )
;               ・・・・・
;      ( 条件部Ｍ Ｓ式M1 Ｓ式M2 ... )
;      ( t        Ｓ式T1 Ｓ式T2 ... )) 

;;;;replを実装しますよ
;;;;でもこれは終わらない
;(defun my-repl ()
;  (loop (print (eval (read)))))
(defun my-repl()
  (let ((cmd (my-read)))
    (unless (eq (car cmd) 'quit)
      (my-print (my-eval cmd))
      (my-repl))))

;;;;read-from-stringはreadと同じ様に読み込むが、標準入力からでなく文字列から読み込む
;;;;(concatenate 'string "(" "あああ" ")")
;;;;->"(あああ)"
(defun my-read ()
  (let ((cmd (read-from-string
              (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
             (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))


;;;;my-evalで許可するワード
(defparameter *allow-cmd* '(look walk pickup inventory))

;;;;許可されたワードの場合のみevalする
(defun my-eval (sexp)
  (if (member (car sexp *allow-cmd*))
      (eval sexp)
      '(i do not know that command.)))

;;;;printはまぁ標準で良いんじゃね
;;;;でも標準関数の練習をしよう
;;;;(prin1-to-string '(a b c))
;;;;->"(A B C)"
;;;;(prin1-to-string '(a b c "abc"))
;;;;->"(A B C \"abc\")"


;;;;(coerce "aabbcc" 'list)
;;;;->(#\a #\a #\b #\b #\c #\c)

;;;;(coerce '(#\a #\b) 'string)
;;;;->"ab"
