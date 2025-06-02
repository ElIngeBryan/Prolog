% --- BASE DE CONOCIMIENTO FAMILIAR COMPLETA ---

yo(bryan).

% Hombres
hombre(salvador).
hombre(rafael).
hombre(miguel).
hombre(alberto).
hombre(arturo).
hombre(samuel).
hombre(omar).
hombre(david).
hombre(hector).
hombre(bryan).
hombre(aldair).
hombre(rafita).
hombre(miguelito).
hombre(alex).
hombre(emiliano).
hombre(parros).
hombre(kevin).
hombre(dorian).
hombre(alan).
hombre(dilan).

% Mujeres
mujer(yesenia).
mujer(sara).
mujer(marbe).
mujer(uri).
mujer(veronica).
mujer(amairani).
mujer(milagros).
mujer(regina).
mujer(perla).
mujer(wendy).
mujer(itari).
mujer(wereja).
mujer(yesica).
mujer(vanessa).
mujer(kimberly).
mujer(britany).

% Padres (padrede)
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

% Madres (madrede)
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

% --- Definiciones de relaciones derivadas ---

% Padre y madre (abstractos)
padre(X,Y) :- padrede(X,Y).
madre(X,Y) :- madrede(X,Y).

% Mismos padres (hermanos completos)
mismos_padres(X,Y) :-
    padre(P,X), padre(P,Y),
    madre(M,X), madre(M,Y),
    X \= Y.

% Hermanos completos
hermano(X,Y) :-
    hombre(X),
    mismos_padres(X,Y).

hermana(X,Y) :-
    mujer(X),
    mismos_padres(X,Y).

% Medio hermanos (comparten padre o madre, pero no ambos)
medio_hermano(X,Y) :-
    hombre(X),
    X \= Y,
    (
        (padre(P,X), padre(P,Y), \+ mismos_padres(X,Y));
        (madre(M,X), madre(M,Y), \+ mismos_padres(X,Y))
    ).

medio_hermana(X,Y) :-
    mujer(X),
    X \= Y,
    (
        (padre(P,X), padre(P,Y), \+ mismos_padres(X,Y));
        (madre(M,X), madre(M,Y), \+ mismos_padres(X,Y))
    ).

% Un hombre es abuelo si es padre de alguien que es padre o madre de otro.
abuelo(X, Y) :-
    hombre(X),
    padrede(X, Z),
    (padrede(Z, Y); madrede(Z, Y)).

% Una mujer es abuela si es madre de alguien que es padre o madre de otro.
abuela(X, Y) :-
    mujer(X),
    madrede(X, Z),
    (padrede(Z, Y); madrede(Z, Y)).


% Tío o tía: hermano o hermana de alguno de los padres
tio_o_tia(X,Y) :-
    (hermano(X,Z); hermana(X,Z)),
    (padre(Z,Y); madre(Z,Y)).

% Tío y tía según género
tio(X,Y) :-
    hombre(X),
    tio_o_tia(X,Y).

tia(X,Y) :-
    mujer(X),
    tio_o_tia(X,Y).


% primo(X,Y): X es primo de Y si X es hombre, y el padre o madre de X es hermano o hermana del padre o madre de Y
primo(X,Y) :-
    hombre(X),
    padre(PX, X),
    (hermano(PX, PY); hermana(PX, PY)),
    (padre(PY, Y); madre(PY, Y)).

primo(X,Y) :-
    hombre(X),
    madre(MX, X),
    (hermano(MX, PY); hermana(MX, PY)),
    (padre(PY, Y); madre(PY, Y)).

% prima(X,Y): lo mismo pero X es mujer
prima(X,Y) :-
    mujer(X),
    padre(PX, X),
    (hermano(PX, PY); hermana(PX, PY)),
    (padre(PY, Y); madre(PY, Y)).

prima(X,Y) :-
    mujer(X),
    madre(MX, X),
    (hermano(MX, PY); hermana(MX, PY)),
    (padre(PY, Y); madre(PY, Y)).

% ¿Qué es alguien de alguien? (pariente en sentido general)
es_que_es(X,Y, abuelo) :- abuelo(X,Y).
es_que_es(X,Y, abuela) :- abuela(X,Y).
es_que_es(X,Y, tio) :- tio(X,Y).
es_que_es(X,Y, tia) :- tia(X,Y).
es_que_es(X,Y, padre) :- padre(X,Y).
es_que_es(X,Y, madre) :- madre(X,Y).
es_que_es(X,Y, hermano) :- hermano(X,Y).
es_que_es(X,Y, hermana) :- hermana(X,Y).
es_que_es(X,Y, medio_hermano) :- medio_hermano(X,Y).
es_que_es(X,Y, medio_hermana) :- medio_hermana(X,Y).
es_que_es(X,Y, primo) :- primo(X,Y).
es_que_es(X,Y, prima) :- prima(X,Y).


% --- Tokenizador para analizar texto libre ---
tokenizar(Texto, Palabras) :-
    split_string(Texto, " ,?.¿¡!\"", " ", Lista),
    maplist(string_lower, Lista, Palabras).

% --- Análisis de preguntas ---
analizar(P) :-
    yo(Y),
    
    
    (
    member("papa", P), member("tengo", P)  ->
        findall(H, padre(H, Y), Padres),
        format("Tu papa es: ~w~n", [Padres])
    ; member("mama", P), member("tengo", P)  ->
        findall(H, madre(H, Y), Madres),
        format("Tu mama es: ~w~n", [Madres])
    ; member("hermanos", P), member("tengo", P) ->
        findall(H, hermano(H,Y), L), format("Tus hermanos son: ~w~n", [L])
    ; member("hermanas", P), member("tengo", P) ->
        findall(H, hermana(H,Y), L), format("Tus hermanas son: ~w~n", [L])
    ; member("primos", P), member("tengo", P) ->
        findall(H, primo(H,Y), L), format("Tus primos son: ~w~n", [L])
    ; member("primas", P), member("tengo", P) ->
        findall(H, prima(H,Y), L), format("Tus primas son: ~w~n", [L])
    ; ( member("abuelos", P), member("tengo", P) ) ->
        findall(H, abuelo(H, Y), Abuelos),
        format("Tus abuelos son: ~w~n", [Abuelos])
    ;
    ( member("abuelas", P), member("tengo", P) ) ->
        findall(H, abuela(H, Y), Abuelas),
        format("Tus abuelas son: ~w~n", [Abuelas])
    ;
    ( member("tios", P), member("tengo", P) ) ->
        findall(H, tio(H, Y), Tios),
        format("Tus tíos son: ~w~n", [Tios])
    ;
    ( member("tias", P), member("tengo", P) ) ->
        findall(H, tia(H, Y), Tias),
        format("Tus tías son: ~w~n", [Tias])
    ; member("que", P), member("es", P), member(X, P), member("de", P), member(Yatom, P) ->
        % Extraer nombres, convertir string a atom para buscar relación
        atom_string(Yatom_atom, Yatom),
        ( es_que_es(X,Yatom_atom,R), format("~w es tu ~w.~n", [X,R]) ->
            true
        ; format("No se que relacion tiene ~w con ~w.~n", [X,Yatom_atom])
        )
    ; member("bye", P); member("adios", P) ->
        write("Adios! Hasta luego."), nl, !, fail
    ; write("Lo siento, no entendí tu pregunta. Intenta con otra frase."), nl
    ).

% --- Eliza recibe texto y responde ---
eliza(Texto) :-
    tokenizar(Texto, Palabras),
    analizar(Palabras).

% --- Chat permanente ---
chat :- 
    write("Escribe algo (ej. ¿Tengo hermanos?, ¿Quien es mi primo?, ¿Que es Aldair de Bryan? o 'bye' para salir):"), nl,
    read_line_to_string(user_input, Input),
    ( Input = "" -> chat
    ; eliza(Input) -> chat
    ; write("¡Hasta luego!"), nl
    ).

% Para correr, cargar el archivo y ejecutar:
% ?- chat.
