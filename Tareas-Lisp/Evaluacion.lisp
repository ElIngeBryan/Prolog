(defun primerElemento (lista)
  (if lista
      (car lista)
      nil)
)

(defun segundoElemento (lista)
  (if lista
      (cadr lista)
      nil)
) 

(defun ultimoElemento (lista)
  (car (last lista))
  )

(defun contarElementos (lista)
  (length lista)
)

(defun sumaElementos (lista)
  (reduce #'+ lista))

(defun buscarElemento (elemento lista)
  (if (member elemento lista)
      t 
      nil
  )
)

(defun invertirLista (lista)
  (if (reverse lista))
)

(defun buscarElemento&Eliminar (elemento lista)
  (if (remove elemento lista)
      t

      nil
  )
)

(defun buscarEnesimoElemento (elemento lista)
  (nth (- elemento 1) lista)
)

(defun concatenarListas (lista1 lista2)
  (if (append lista1 lista2)
  nil
  )
)





