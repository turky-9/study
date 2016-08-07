;;;;ノードの定義
(defparameter *node* '((living-room (you ar in th living-room.
					 a wizard is snoring loudly on the couch.))
		       (garden (you are in a beautiful garden.
				    there is a well in from of you.))
		       (atiic (you are in the attic.
				   there is a giant welding torch in the corner.))))
;;;;連想リストにはasoc
(assoc 'garden *node*)
;;;;-> (GARDEN (YOU ARE IN A BEAUTIFUL GARDEN. THERE IS A WELL IN FROM OF YOU.))

;;;;場所の説明を行う関数定義
(defun describe-location (location nodes)
  (cadr (assoc location nodes)))


;;;;通路の定義
(defparameter *edge* '((living-room (garden west door)
				    (attic upstairs ladder))
			(garden (living-room est door))
			(attic (living-room downstairs ladder))))

;;;;通路の説明を行う関数定義
(defun describe-path (edge)
`(there is a ,(caddr edge) going ,(cadr edge) from here.))
;;;;(describe-path '(garden west door))
;;;;-> (THERE IS A DOOR GOING WEST FROM HERE.)

;;;;#'はcommon lispの。関数を表わす。
;;;;common lispは関数と、変数の名前空間が異なる
;;;;mapcarはschemeのmap
;;;;common lispでは名前空間が別なのでapplyで実行する
;;;;
;;;;シンボルから関数をとりだすにはfunctionを使用する
;;;;(function car)
;;;;
;;;;appendは複数のリストを結なげて1つのリストにする
(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))


(defparameter *object* '(whiskey bucket frog chain))
(defparameter *object-location* '((whiskey living-room)
				  (bucket living-room)
				  (chain garden)
				  (frog garden)))

;;;;場所を引数にオブジェクトのリストを返す
(defun object-at (loc objs obj-locs)
  (labels ((at-loc-p (obj)
	     (eq (cadr (assoc obj obj-locs)) loc)))
    (remove-if-not #'at-loc-p objs)))

;;;;文章にして返す
(defun describe-game-objects (loc objs obj-loc)
  (labels ((describe-obj (obj)
			`(you see a ,obj on the floor.)))
	 (apply #'append (mapcar #'describe-obj (object-at loc objs obj-loc)))))

;;;;プレーヤーの位置
(defparameter *location* 'living-room)

(defun look ()
  (append (describe-location *location* *node*)
	  (describe-paths *location* *edge*)
	  (describe-game-objects *location* *object* *object-location*)))
