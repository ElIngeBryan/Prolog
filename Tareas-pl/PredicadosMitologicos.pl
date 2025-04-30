/*
1. Aplanar una lista de listas anidadas
Utiliza el predicado flatten para transformar una estructura anidada en una lista plana.

Problema: Dada una lista como [1, [2, [3, 4], 5], [6]], genera [1, 2, 3, 4, 5, 6].

Predicado: `flatten/2`.

*/

?- flatten([1, [2, [3, 4], 5], [6]], R).
% R = [1, 2, 3, 4, 5, 6].


/*
2. Encontrar todas las permutaciones de una lista
Utiliza *permutacion*` para generar todas las permutaciones posibles de una lista.

Problema: Dada la lista [a, b, c], genera las permutaciones:

[a, b, c]
[a, c, b]
[b, a, c]
[b, c, a]
[c, a, b]
[c, b, a]
Predicado: `permutacion/2`.
*/

permutation([a, b, c], P).