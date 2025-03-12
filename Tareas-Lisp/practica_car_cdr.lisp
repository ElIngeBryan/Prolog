Eduardo Alcaraz


Table of Contents
─────────────────

1. Problemas con car y cdr





1 Problemas con car y cdr
═════════════════════════

  Lista: (a b c d e) → Extraer d 
	;(cadddr)

  Lista: ((1 2) (3 4) (5 6)) → Extraer 5
	;(caaddr)

  Lista: ((a b) (c d) (e f)) → Extraer e
	;(caaddr)

  Lista: ((x y) ((p q) (r s)) (z w)) → Extraer z
    ;(caaddr)

  Lista: ((1 (2 3)) (4 (5 6))) → Extraer 6
	;(cadr (cadr (cadr '((1 (2 3)) (4 (5 6))))))

  Lista: (((a b) c) d e) → Extraer c
    ;()

  Lista: (((1 2) 3) ((4 5) 6)) → Extraer 6

  Lista: ((p (q (r s))) t u) → Extraer (r s)

  Lista: (((a) b) (c (d e)) f) → Extraer d

  Lista: ((1 (2 (3 4))) (5 6)) → Extraer 3

  Lista: (((x) (y)) ((z) (w))) → Extraer (w)

  Lista: ((a (b (c d))) (e f)) → Extraer c

  Lista: ((1 (2 (3 (4 5)))) (6 7)) → Extraer 4

  Lista: (((a b) c) ((d e) f) ((g h) i)) → Extraer g

  Lista: (((x y) (z w)) ((p q) (r s))) → Extraer r

  Lista: ((1 (2 (3 (4 (5 6))))) (7 8)) → Extraer 5

  Lista: ((a (b (c (d e)))) (f g)) → Extraer d

  Lista: (((1 2) (3 4)) ((5 6) (7 8))) → Extraer 7

  Lista: ((x (y (z (w v))))) → Extraer w

  Lista: (((a b c) (d e f)) ((g h i) (j k l))) → Extraer j