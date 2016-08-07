;;;;色々テスト
;;;;defparameterは値を上書く
;;;;defvarは値を上書かない
(defparameter *aaa* 10)
(defvar *bbb* 10)

;;;;ローカル変数
(let ((a 2)
      (b 3))
  (+ a b))

;;;;ローカル関数
(flet ((f (n) (+ n 20))) (f 5))

;;;;同じスコープで定義された関数を使用したい場合は以下を使用する
(labels ((a (n) (+ n 5)) (b (n) (+ (a n) 6))) (b 10))

;;;ドットセルを返す
(cons 'aaa 'bbb)
;;;-> (AAA . BBB)


;;;;リストの先端に追加する事も可能
(cons 'aaa '('bbb 'ccc))
;;;;-> (AAA BBB CCC)

;;;;リストの2番目
(cadr '(1 2 3))
;;;;-> 2

;;;;まとめてリストにする
(list 'a 'b 'c)
;;;;-> (A B C)

;;;;空のリストは偽となる(schemeと違う)
;;;;偽以外は真
(if '() 'aaa 'bbb)
;;;;->BBB
(if nil 'aaa 'bbb)
;;;;->BBB

;;;;だから再帰と相性良い
(defun my-length (list)
  (if list
    (1+ (my-length (cdr list)))
    0))
 (my-length '(I am a hero))
;;;;-> 4

;;;;CLISPにおいて、いか4つは同じ
nil
'nil
'()
()

;;;;CとかJavaのブロックに相当するもの
;;;;(1つしか書けない所に複数書ける)
(progn (+ 1 2) (* 3 4))
;;;;-> 12


;;;;whenとかunlessは暗黙のprogn
(when 1 (print "this is a ") (prin1 "pen"))
;;;;-> "this is a " "pen"
;;;;-> "pen"

;;;;condも同様
(cond (1 (print "this is a ") (prin1 "pen")))
;;;;-> "this is a " "pen"
;;;;-> "pen"


;;;;switch-caseみたいなのもあるけど、パス

;;;;含まれているかどうか調らべる
;;;;でも真以上の情報を返す
(member 1 '(2 3 1 4 5))
;;;;-> (1 4 5)

;;;;find-if
(find-if #'oddp '(1 2 3))
;;;;-> 1
(find-if #'null '(1 2 ()));;この例は注意
;;;;-> NIL

;;;;コンラッドのルール
;;;;1.シンボル同士はeqで比較すべし
;;;;2.シンボツ同士でなければequalを使かえ
