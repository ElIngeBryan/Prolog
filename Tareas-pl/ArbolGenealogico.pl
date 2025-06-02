
% abuelitos
padre(donsalvador).
padre(donodilon).
% aquitermina
padre(salvador).
padre(rafael).
padre(miguel).
padre(alberto).
padre(samuel).

% abuelitas
madre(donaSara).
madre(donaRosalia).
% aquitermina
madre(yesenia).
madre(sara).
madre(marbe).
madre(uri).
madre(veronica).

% Hijos e Hijas
hijo(salvador).
hijo(rafael).
hijo(miguel).
hijo(alberto).
hijo(arturo).
hijo(samuel).
hijo(omar).
hijo(david).
hijo(hector).
hijo(bryan).
hijo(aldair).
hijo(rafita).
hijo(miguelito).
hijo(alex).
hijo(emiliano).
hijo(parros).
hijo(kevin).
hijo(dorian).
hijo(alan).
hijo(dilan).

hija(yesenia).
hija(sara).
hija(marbe).
hija(uri).
hija(veronica).
hija(amairani).

hija(milagros).
hija(regina).
hija(perla).
hija(wendy).
hija(itari).
hija(wereja).
hija(yesica).
hija(vanessa).
hija(kimberly).
hija(britany).

% Relaciones de padres
padrede(donsalvador, salvador).
padrede(donsalvador, miguel).
padrede(donsalvador, rafael).
padrede(donsalvador, alberto).
padrede(donsalvador, yesenia).
padrede(donsalvador, sara).
padrede(donsalvador, marbe).
padrede(donsalvador, uri).
padrede(donsalvador, amairani).
padrede(donodilon, arturo).
padrede(donodilon, samuel).
padrede(donodilon, omar).
padrede(donodilon, veronica).

padrede(salvador, david).
padrede(salvador, hector).
padrede(salvador, bryan).
padrede(miguel, miguelito).
padrede(miguel, regina).
padrede(rafael, aldair).
padrede(rafael, rafita).
padrede(rafael, milagros).
padrede(alberto, dorian).
padrede(alberto, alan).
padrede(alberto, dilan).
padrede(samuel, alex).
padrede(samuel, britany).

% Relaciones de madres
madrede(donaSara, salvador).
madrede(donaSara, rafael).
madrede(donaSara, miguel).
madrede(donaSara, alberto).
madrede(donaSara, yesenia).
madrede(donaSara, marbe).
madrede(donaSara, amairani).
madrede(donaSara, sara).
madrede(donaSara, uri).
madrede(donaRosalia, arturo).
madrede(donaRosalia, veronica).
madrede(donaRosalia, samuel).
madrede(donaRosalia, omar).

madrede(yesenia, yesica).
madrede(yesenia, vanessa).
madrede(yesenia, emiliano).
madrede(marbe, kimberly).
madrede(marbe, kevin).
madrede(sara, perla).
madrede(sara, wendy).
madrede(sara, parros).
madrede(uri, wereja).
madrede(uri, itari).
madrede(veronica, david).
madrede(veronica, hector).
madrede(veronica, bryan).

% Padres combinados
padres(X, Y) :- padrede(X, Y).
padres(X, Y) :- madrede(X, Y).

% Hijos combinados
hijos(X, Y) :- hijode(X, Y).

% Abuelo y abuela
abuelo(A, N) :- padrede(A, P), padres(P, N).
abuela(A, N) :- madrede(A, P), padres(P, N).

% Nieto y nieta
nieto(N, A) :- hijo(N), (abuelo(A, N); abuela(A, N)).
nieta(N, A) :- hija(N), (abuelo(A, N); abuela(A, N)).

% Hermano y hermana
hermano(X, Y) :- hijo(X), hermanode(X, Y).
hermana(X, Y) :- hija(X), hermanode(X, Y).

% Tío y tía
tio(T, S) :- hermano(T, P), padres(P, S).
tia(T, S) :- hermana(T, P), padres(P, S).

% Sobrino y sobrina
sobrino(S, T) :- hijo(S), (tio(T, S); tia(T, S)).
sobrina(S, T) :- hija(S), (tio(T, S); tia(T, S)).

% Primo y prima
primo(P, X) :- hijo(P), padres(A, P), tio_tia_de(A, X).
prima(P, X) :- hija(P), padres(A, P), tio_tia_de(A, X).

tio_tia_de(T, S) :- padres(P, S), (hermano(T, P); hermana(T, P)).
