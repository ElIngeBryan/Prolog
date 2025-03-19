hombre(donsalvador).
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().
hombre().


mujer().


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



hijode(X,Y):-madrede(X,Y).
hijode(X,Y):-padrede(X,Y).

hermanode(X, Y) :- padrede(W, X), padrede(W,Y), X \= Y.

