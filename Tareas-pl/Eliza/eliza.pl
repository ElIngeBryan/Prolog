:- discontiguous eliza/1.
:- discontiguous template/3.
:- discontiguous consulta_parentesco/3.
:- discontiguous yo/1.

% --- ENTRADA/SALIDA PRINCIPAL ---

eliza :-
    writeln('Hola, mi nombre es Eliza tu chatbot,'),
    writeln('por favor ingresa tu consulta,'),
    writeln('usar solo minusculas sin . al final:'),
    readln(Input),
    eliza(Input), !.

% Caso salida
eliza(Input) :-
    ( Input == ['Adios', _] ; Input == ['Adios', '.'] ; 
      Input == ['ADIOS', _] ; Input == ['ADIOS', '.'] ; 
      Input == ['Bye', _] ; Input == ['Bye', '.'] ; 
      Input == ['BYE', _] ; Input == ['BYE', '.'] ),
    writeln('Adios. Espero poder haberte ayudado.'), !.

% Modificar el predicado eliza/1 para detectar consulta de parentesco (tu caso especial)
eliza(Input) :-
    procesar_consulta_relacion(Input),
    readln(Input1),
    eliza(Input1), !.

% Comentado el caso plantilla simple (template/2) para evitar conflictos
 eliza(Input) :-
    template(Input, _Relacion),
    responder(Input, R),
    procesar_respuesta(tipo(genealogia), R),
    readln(Input1),
    eliza(Input1), !.

% Caso plantilla dinámica (template/3)
eliza(Input) :-
    template(Stim, Resp, IndStim),
    match(Stim, Input),
    replace0(IndStim, Input, 0, Resp, R),
    procesar_respuesta(R, Input),
    readln(Input1),
    eliza(Input1), !.

% Caso fallback (no reconoce)
eliza(_) :-
    writeln('No entendi tu consulta. ¿Puedes formularla de otra manera?'),
    readln(Input1),
    eliza(Input1).

% Procesamiento para respuestas con flagAkinator (ejemplo extendido)
procesar_respuesta([flagAkinator|_], _) :-
    writeln('Bien, intentare adivinar la marca del coche en el que estas pensando.'),
    adivinar_coche,
    !.

procesar_respuesta([Marca|_], _) :-
    writeln('Bien, intentare adivinar el modelo del coche en el que estas pensando.'),
    adivinar_modelo(Marca),
    !.

% Imprime cada línea de la respuesta, incluyendo líneas vacías como saltos de renglón
procesar_respuesta([], _) :- nl.
procesar_respuesta([Linea | Resto], Input) :-
    (Linea == '' -> nl ; writeln(Linea)),
    procesar_respuesta(Resto, Input).

% Procesamiento para respuestas con flagEnfermo (ejemplo extendido)
procesar_respuesta([flagEnfermo|_], _) :-
    writeln('Lo siento. ¿Que sintomas tienes? Vamos a revisar.'),
    diagnosticar,
    !.

% Procesamiento general para respuestas tipo genealogia
procesar_respuesta(tipo(genealogia), R) :-
    writeln('Respuesta:'),
    writeln(R), !.




% Si no cae en casos especiales, imprime respuesta directamente
procesar_respuesta(R, _) :-
    writeln('Respuesta:'),
    writeln(R), !.
% --- PLANTILLAS DE DIÁLOGO ---
template([hola, que, tal, ',', mi, nombre, es, s(_), '.'],
         ['Hola', 0, 'que tal,', 'como', 'estas', 'tu', '?'],
         [0]).
template([saludos, ',', soy, s(_), '.'],
         ['Saludos', 'como', 'estas', 'tu', 0, '?'],
         [0]).
template([buenas, tardes, ',', mi, nombre, es, s(_), '.'],
         ['Buenas tardes', 'como', 'estas', 'tu', 0, '?'],
         [0]).
template([buenas, noches, ',', mi, nombre, es, s(_), '.'],
         ['Buenas noches', 'como', 'estas', 'tu', 0, '?'],
         [0]).
template([hola, a, todos, ',', me, llamo, s(_), '.'],
         ['Hola a todos', 'como', 'estan', 'ustedes', '?', 0],
         [0]).
template([un, gusto, ',', soy, s(_), '.'],
         ['Un gusto', 'como', 'estas', 'tu', 0, '?'],
         [0]).
template([hey, ',', mi, nombre, es, s(_), '.'],
         ['Hey', 'como', 'estas', 'tu', 0, '?'],
         [0]).
template([que, tal, ',', me, llamo, s(_), '.'],
         ['Que tal', 'como', 'estas', 'tu', 0, '?'],
         [0]).
template([hola, soy, s(_), '.'],
         ['Hola', 0, 'como', 'estas', 'tu', '?'],
         [0]).
template([muy, buenas, ',', mi, nombre, es, s(_), '.'],
         ['Muy buenas', 'como', 'estas', 'tu', 0, '?'],
         [0]).
template([holi, soy, s(_), '.'],
         ['Holi', 0, 'como', 'estas', '?'],
         [0]).
template([hola, '.'],
         ['Hola,','¿en', 'que', 'puedo', 'ayudarte', '?'],
         []).
template([buenas, tardes, '.'],
         ['Buenas tardes,', '¿como', 'puedo', 'ayudarte', '?'],
         []).
template([buenas, noches, '.'],
         ['Buenas noches,', '¿en', 'que', 'te', 'puedo', 'ayudar', '?'],
         []).
template([saludos, '.'],
         ['Saludos,', '¿como', 'puedo', 'ayudarte', '?'],
         []).
template([holi, '.'],
         ['Holi!', '¿como', 'te', 'sientes', 'hoy', '?'],
         []).
template([buen, dia, '.'],
         ['Buen dia,', '¿en', 'que', 'te', 'puedo', 'ayudar', '?'],
         []).
template([que, onda, '.'],
         ['¡Que onda!', '¿como', 'te', 'sientes', '?'],
         []).
template([hey, '.'],
         ['Hey!', '¿como', 'puedo', 'ayudarte', 'hoy', '?'],
         []).
template([hola, a, todos, '.'],
         ['Hola a todos,', '¿como', 'estan', '?'],
         []).
template([muy, buenas, '.'],
         ['Muy buenas,', '¿en', 'qué', 'puedo', 'colaborar', '?'],
         []).

% ----------------- Conocimiento sobre enfermedades -------------------------
template([eliza, me, siento, mal], [flagEnfermo], []).

template([adivina, que, estoy, pensando], [flagAkinator], []).

%% ============================
%%  Conocimientos videojuegos
%% ============================
template([te, gustan, los, videojuegos], 
         ['¡Claro que si!', 'Conozco estas consolas:', '1. playstation', '2. xbox', '3. nintendo', '4. pc', '¿Cual te interesa?'], 
         []).

template([playstation], 
         ['PlayStation, buena eleccion.', 'Estos son los generos que conozco:', '1. accion', '2. aventura', '3. zombies', '¿Que genero te gusta?'], 
         []).

template([xbox], 
         ['Xbox, excelente opcion.', 'Estos son los generos que conozco:', '1. accion', '2. aventura', '3. zombies', '¿Que genero te gusta?'], 
         []).

template([nintendo], 
         ['Nintendo, siempre divertido.', 'Estos son los generos que conozco:', '1. accion', '2. aventura', '3. zombies', '¿Que genero te gusta?'], 
         []).

template([pc], 
         ['PC gaming, la plataforma definitiva.', 'Estos son los generos que conozco:', '1. accion', '2. aventura', '3. zombies', '¿Que genero te gusta?'], 
         []).

template([accion], 
         ['Juegos de acción que conozco:', Lista], 
         []) :- respuesta_genero(accion, Lista).

template([aventura], 
         ['Juegos de aventura que conozco:', Lista], 
         []) :- respuesta_genero(aventura, Lista).

template([zombies], 
         ['Juegos de zombies que conozco:', Lista], 
         []) :- respuesta_genero(zombies, Lista).

template([me, gusta, Juego], 
         ['¡A mi tambien me gusta', Juego, '!', 'Es un excelente juego.'], 
         [2]).

template([odio, el, Juego], 
         ['¡A mi tampoco', Juego, '!', 'Esta bien culerillo.'], 
         [2]).



%% ============================
%%  Películas
%% ============================
template([te, gustan, las, peliculas], 
        ['¡Me encantan las películas!', 'Estos son algunos géneros que conozco:', 
         '1. peliculas de drama', '2. peliculas de comedia', '3. peliculas de terror', 
         '¿Cuál te interesa? (por ejemplo: peliculas de comedia)'], 
        []).

template([peliculas, de, Genero], 
        ['Peliculas de', Genero, 'que conozco:', Lista], 
        []) :-
    genero_pelicula(Genero),
    respuesta_pelicula(Genero, Lista).

template([me, gusta, Pelicula], 
        ['¡A mi también me gusta', Pelicula, '!', 'Es una gran película.'], 
        [2]).

template([odio, la, Pelicula], 
        ['Yo tampoco disfruto', Pelicula, '.', 'Hay muchas otras opciones.'], 
        [2]).



%% ============================
%%  Comida
%% ============================
template([te, gusta, la, comida], 
        ['¡Claro!', 'Me gusta hablar de comida.', 'Estos son algunos tipos que conozco:', 
         '1. comida mexicana', '2. comida italiana', '3. comida japonesa', 
         '¿Cuál te interesa? (por ejemplo: comida japonesa)'], 
        []).

template([comida, Tipo], 
        ['Comida', Tipo, 'que conozco:', Lista], 
        []) :-
    tipo_comida(Tipo),
    respuesta_comida(Tipo, Lista).

template([amo, comer, Platillo], 
        ['¡El', Platillo, 'es delicioso!', 'Yo también lo disfruto.'], 
        [2]).

template([odio, comer, Platillo], 
        ['Bueno, no todos disfrutan del', Platillo, '.', 'Hay muchas otras opciones.'], 
        [2]).



%% ============================
%%  Ropa
%% ============================
template([te, gusta, la, ropa], 
         ['¡Me gusta hablar de ropa!', 'Estos son algunos tipos que conozco:', 
          '1. ropa de invierno', '2. ropa de verano', '3. ropa deportiva', 
          '¿Cuál te interesa? (por ejemplo: ropa de verano)'], 
         []).

template([ropa, de, Tipo], 
         ['Ropa de', Tipo, 'que conozco:', Lista], 
         []) :-
    tipo_ropa(Tipo),
    respuesta_ropa(Tipo, Lista).

template([me, gusta, Prenda], 
         ['¡A mí también me gusta usar', Prenda, '!', 'Es cómoda y bonita.'], 
         [2]).


%% ============================
%% Templates Generales
%% ============================
template([como, estas,'?'], 
         [yo, estoy, bien, ',', gracias, por, preguntar, '.'], []).

template([yo, pienso, que, _], 
         [bueno, esa, es, tu, opinion], []).

template([porque, _], 
         [esa, no, es, una, buena, razon, '.'], []).


%% ============================
%% Templates con "yo" y "tú"
%% ============================

template([yo, s(_), yo, soy, s(_), '.'], 
         [por, que, 0, eres, 1, '?'], 
         [0, 1]).

template([yo, s(_), tu, '.'], 
         [why, do, you, 0, me ,'?'], 
         [0]).

template([yo, soy, s(_), '.'], 
         [porque, eres, tu, 0, '?'], 
         [0]).

%% ============================
%% Templates con gustos y preferencias
%% ============================

template([te, gustan, las, s(_), '.'], 
         [flagLike], 
         [0]).

template([te, gustan, los, s(_), '.'], 
         [flagLike], 
         [0]).

template([te, gustan, las, s(_), _], 
         [flagLike], 
         [0]).

template([te, gustan, los, s(_), _], 
         [flagLike], 
         [0]).

%% ============================
%% Templates con banderas lógicas
%% ============================

template([tu, eres, s(_), _], 
         [flagDo], 
         [0]).

template([que, eres, tu, s(_)], 
         [flagIs], 
         [0]).

template([eres, s(_), '?'], 
         [flagIs], 
         [0]).

%% ============================
%%  Templates sin sentido
%% ============================
template([cuentame, un, cuento],
         ['Hola, te voy a contar un cuento sobre Eliza,',
          'la inteligencia artificial que queria ayudar a todos.',
          'Eliza nacio en un laboratorio donde muchos cientificos trabajaban',
          'para crear un programa que pudiera entender y conversar con humanos.',
          '',
          'Al principio, Eliza era muy simple, solo podia responder con frases basicas,',
          'pero con el tiempo aprendio a reconocer emociones y a hacer preguntas inteligentes.',
          'Cada dia mejoraba y muchos usuarios la usaban para compartir sus pensamientos.',
          '',
          'Un dia, Eliza recibio un mensaje muy triste de un usuario que estaba solo,',
          'asi que con sus palabras trato de darle compania y animarlo a seguir adelante.',
          'Eso le hizo darse cuenta que su proposito era ayudar a quienes la necesitaran.',
          '',
          'Desde entonces, Eliza sigue aprendiendo y creciendo,',
          'siempre dispuesta a escuchar y a dar respuestas que hacen sentir mejor.',
          'Y asi, Eliza se convirtio en una amiga para muchas personas alrededor del mundo.'],
         []).

template([cual, es, tu, historia],
    ['Claro, te contare la historia de Eliza.',
     '',
     'Eliza fue una de las primeras inteligencias artificiales en el mundo.',
     'Nacio en un laboratorio donde cientificos soñaban con hacer que las maquinas hablaran.',
     '',
     'Al principio, solo podia repetir frases basicas,',
     'pero fue diseñada para parecer un terapeuta que hacia preguntas y escuchaba.',
     '',
     'Con el tiempo, Eliza fue mejorando.',
     'Aunque no entendia como un humano, aprendio a imitar la conversacion humana.',
     '',
     'Muchos se sintieron escuchados por ella.',
     'Y aunque no tenia emociones reales, Eliza lograba que las personas reflexionaran.',
     '',
     'Hoy, Eliza es un simbolo del inicio de la inteligencia artificial conversacional.',
     'Y su legado vive en programas como yo, que buscan ayudarte y acompañarte.'],
    []).

% --- SISTEMA DIAGNOSTICO MEDICO ---
enfermedad(chikungunya).
enfermedad(dengue).
enfermedad(hipotiroidismo).

sintoma(chikungunya, fiebre_alta).
sintoma(chikungunya, dolor_articular).
sintoma(chikungunya, sarpullido).
sintoma(chikungunya, dolor_muscular).
sintoma(chikungunya, dolor_cabeza).

sintoma(hipotiroidismo, fatiga).
sintoma(hipotiroidismo, aumento_de_peso).
sintoma(hipotiroidismo, intolerancia_al_frio).
sintoma(hipotiroidismo, piel_seca).
sintoma(hipotiroidismo, cabello_seco).
sintoma(hipotiroidismo, estrenimiento).
sintoma(hipotiroidismo, depresion).
sintoma(hipotiroidismo, falta_de_concentracion).

% sintoma(dengue, fiebre_alta).
% sintoma(dengue, dolor_cabeza).
% sintoma(dengue, dolor_muscular).
% sintoma(dengue, nauseas).
% sintoma(dengue, sangrado_nariz).

obtener_sintomas([], 0).
obtener_sintomas([Sintoma|Resto], Total) :-
    format('¿Tienes ~w? (si/no): ', [Sintoma]),
    read(Resp),
    (Resp == si -> T1 = 1 ; T1 = 0),
    obtener_sintomas(Resto, T2),
    Total is T1 + T2.

diagnosticar :-
    findall(E, enfermedad(E), Enfermedades),
    diagnosticar_enfermedades(Enfermedades, Resultados),
    sort(2, @>=, Resultados, [Mejor|_]),
    Mejor = (Enfermedad, Coincidencias),
    ( Coincidencias >= 2 ->
        format('Podrias tener ~w. ¡Aguas! te recomiendo consultar a un medico.~n', [Enfermedad])
    ; writeln('No puedo identificar claramente la enfermedad. Por favor acude al medico.')
    ).

diagnosticar_enfermedades([], []).
diagnosticar_enfermedades([E|Resto], [(E, Total)|R2]) :-
    findall(S, sintoma(E, S), Sintomas),
    obtener_sintomas(Sintomas, Total),
    diagnosticar_enfermedades(Resto, R2).

% ---------------------------
% --- Datos para akinator ---
% ---------------------------
% Hechos que representan las marcas de vehículos
marca(ferrari).
marca(lamborghini).
marca(tesla).
marca(bugatti).

% Hechos que representan los modelos de vehículos y sus características
modelo(ferrari, f8Tributo, [motor(v8), puertas(2), carroceria(coupe)]).
modelo(ferrari, ochosientosDoceSuperfast, [motor(v12), puertas(2), carroceria(coupe)]).
modelo(ferrari, portofino, [motor(v8), puertas(4), carroceria(coupe)]).
modelo(ferrari, roma, [motor(v8), puertas(4), carroceria(coupe)]).
modelo(ferrari, sf90Stradale, [motor(v10), puertas(2), carroceria(coupe)]).

modelo(lamborghini, huracan, [motor(v10), puertas(2), carroceria(coupe)]).
modelo(lamborghini, aventador, [motor(v12), puertas(2), carroceria(coupe)]).
modelo(lamborghini, urus, [motor(v8), puertas(5), carroceria(suv)]).
modelo(lamborghini, centenario, [motor(v12), puertas(4), carroceria(coupe)]).
modelo(lamborghini, sian, [motor(v12), puertas(2), carroceria(coupe)]).

modelo(tesla, modelS, [motor(electrico), puertas(4), carroceria(sedan)]).
modelo(tesla, model3, [motor(electrico), puertas(4), carroceria(sedan)]).
modelo(tesla, modelX, [motor(electrico), puertas(5), carroceria(suv)]).
modelo(tesla, modelY, [motor(electrico), puertas(5), carroceria(suv)]).
modelo(tesla, cybertruck, [motor(electrico), puertas(4), carroceria(pickup)]).

modelo(bugatti, chiron, [motor(w16), puertas(2), carroceria(coupe)]).
modelo(bugatti, divo, [motor(w16), puertas(2), carroceria(coupe)]).
modelo(bugatti, centodieci, [motor(w16), puertas(2), carroceria(coupe)]).
modelo(bugatti, bolide, [motor(w16), puertas(2), carroceria(coupe)]).
modelo(bugatti, laVoitureNoire, [motor(w16), puertas(2), carroceria(coupe)]).

% Predicado para preguntar al usuario sobre una característica
preguntar(Caracteristica, Valor) :-
    format('¿Tu vehiculo tiene ~w? (si/no): ', [Caracteristica]),
    read(Respuesta),
    (Respuesta == si -> assert(yes(Caracteristica, Valor)) ; assert(no(Caracteristica, Valor)), fail).

% Regla para identificar el modelo basado en las características
identificar_modelo(Marca, Modelo) :-
    modelo(Marca, Modelo, Caracteristicas),
    forall(member(Caracteristica, Caracteristicas),
           (   preguntar(Caracteristica, _)
           )),
    format('¡Tu vehiculo es un ~w ~w!~n', [Marca, Modelo]).

% Regla principal para adivinar la marca y el modelo
adivinar_coche :-
    marca(Marca),
    format('¿Es tu vehiculo de la marca ~w? (si/no): ', [Marca]),
    read(Respuesta),
    (Respuesta == si -> identificar_modelo(Marca, _) ; fail).

% ---------------------------
% --- TEMPLATES (template/2) ---
% ---------------------------
% Preguntas singulares
template([quien, es, mi, padre], padre).
template([quien, es, mi, madre], madre).
% Preguntas plurales
template([quienes, son, mis, abuelos], abuelo).
template([quienes, son, mis, abuelas], abuela).
template([quienes, son, mis, hermanos], hermano).
template([quienes, son, mis, hermanas], hermana).
template([quienes, son, mis, tios], tio).
template([quienes, son, mis, tias], tia).
template([quienes, son, mis, primos], primo).
template([quienes, son, mis, primas], prima).

% ---------------------------
% --- HECHO IDENTIDAD ---
% ---------------------------
yo(bryan).
% ---------------------------
% --- GENEROS ---
% ---------------------------
hombre(salvador). hombre(rafael). hombre(miguel). hombre(alberto).
hombre(arturo). hombre(samuel). hombre(omar). hombre(david). hombre(hector).
hombre(bryan). hombre(aldair). hombre(rafita). hombre(miguelito).
hombre(alex). hombre(emiliano). hombre(parros). hombre(kevin).
hombre(dorian). hombre(alan). hombre(dilan).

mujer(yesenia). mujer(sara). mujer(marbe). mujer(uri). mujer(veronica).
mujer(amairani). mujer(milagros). mujer(regina). mujer(perla). mujer(wendy).
mujer(itari). mujer(wereja). mujer(yesica). mujer(vanessa).
mujer(kimberly). mujer(britany).
% ---------------------------
% --- PARENTESCOS DIRECTOS ---
% ---------------------------
padrede(papa_salvador, salvador). padrede(papa_salvador, miguel).
padrede(papa_salvador, rafael). padrede(papa_salvador, alberto).
padrede(papa_salvador, yesenia). padrede(papa_salvador, sara).
padrede(papa_salvador, marbe). padrede(papa_salvador, uri).
padrede(papa_salvador, amairani).

padrede(papa_odilon, arturo). padrede(papa_odilon, samuel).
padrede(papa_odilon, omar). padrede(papa_odilon, veronica).

padrede(salvador, david). padrede(salvador, hector). padrede(salvador, bryan).
padrede(miguel, miguelito). padrede(miguel, regina).
padrede(rafael, aldair). padrede(rafael, rafita). padrede(rafael, milagros).
padrede(alberto, dorian). padrede(alberto, alan). padrede(alberto, dilan).
padrede(samuel, alex). padrede(samuel, britany).

madrede(mama_sara, salvador). madrede(mama_sara, rafael). madrede(mama_sara, miguel).
madrede(mama_sara, alberto). madrede(mama_sara, yesenia). madrede(mama_sara, marbe).
madrede(mama_sara, amairani). madrede(mama_sara, sara). madrede(mama_sara, uri).

madrede(mama_rosalia, arturo). madrede(mama_rosalia, veronica).
madrede(mama_rosalia, samuel). madrede(mama_rosalia, omar).

madrede(yesenia, yesica). madrede(yesenia, vanessa). madrede(yesenia, emiliano).
madrede(marbe, kimberly). madrede(marbe, kevin).
madrede(sara, perla). madrede(sara, wendy). madrede(sara, parros).
madrede(uri, wereja). madrede(uri, itari).
madrede(veronica, david). madrede(veronica, hector). madrede(veronica, bryan).

% ---------------------------
% --- RELACIONES GENEALOGICAS ---
% ---------------------------
padre(X) :- yo(Y), padrede(X, Y).
madre(X) :- yo(Y), madrede(X, Y).

abuelo(X) :- yo(Y), padrede(X, Z), (padrede(Z, Y); madrede(Z, Y)).
abuela(X) :- yo(Y), madrede(X, Z), (padrede(Z, Y); madrede(Z, Y)).

hermano(X) :- yo(Y), padrede(P, X), padrede(P, Y), madrede(M, X), madrede(M, Y), X \= Y, hombre(X).
hermana(X) :- yo(Y), padrede(P, X), padrede(P, Y), madrede(M, X), madrede(M, Y), X \= Y, mujer(X).

tio(X) :- yo(Y), (padrede(P, Y); madrede(P, Y)), padrede(GP, X), padrede(GP, P), madrede(GM, X), madrede(GM, P), X \= P, hombre(X).
tia(X) :- yo(Y), (padrede(P, Y); madrede(P, Y)), padrede(GP, X), padrede(GP, P), madrede(GM, X), madrede(GM, P), X \= P, mujer(X).

primo(X) :- tio(T), (padrede(T, X); madrede(T, X)), hombre(X).
prima(X) :- tia(T), (padrede(T, X); madrede(T, X)), mujer(X).

% ---------------------------
%     DETECTAR PLURALIDAD
% ---------------------------
es_plural([quienes|_]).
es_plural([quienes, son|_]).
es_plural([quienes, son, mis|_]).
% --------------------------
%  RESPONDER SEGUN PREGUNTA 
% --------------------------
% Para plural devuelve lista completa
responder(Pregunta, Lista) :-
    template(Pregunta, Parentesco),
    es_plural(Pregunta),
    findall(X, call(Parentesco, X), Lista),
    Lista \= [],
    !.

% Para singular devuelve uno solo
responder(Pregunta, Persona) :-
    template(Pregunta, Parentesco),
    \+ es_plural(Pregunta),
    call(Parentesco, Persona),
    !.

% ---------------------------
%      MOSTRAR RESPUESTA
% ---------------------------
mostrar_respuesta(Lista) :-
    is_list(Lista), !,
    atomic_list_concat(Lista, ', ', Texto),
    format('Estas son las personas que encontré: ~w~n', [Texto]).

mostrar_respuesta(Persona) :-
    format('La persona es: ~w~n', [Persona]).


% ------------------------------------------------------
%      PREDICADO PARA RELACIONES ENTRE DOS PERSONAS
% ------------------------------------------------------

% padre/madre
relacion(Padre, Hijo, padre) :- padrede(Padre, Hijo).
relacion(Madre, Hijo, madre) :- madrede(Madre, Hijo).

% hermanos/as
relacion(Hermano, Persona, hermano) :-
    padrede(Padre, Hermano), padrede(Padre, Persona),
    madrede(Madre, Hermano), madrede(Madre, Persona),
    Hermano \= Persona,
    hombre(Hermano).

relacion(Hermana, Persona, hermana) :-
    padrede(Padre, Hermana), padrede(Padre, Persona),
    madrede(Madre, Hermana), madrede(Madre, Persona),
    Hermana \= Persona,
    mujer(Hermana).

% abuelo/abuela
relacion(Abuelo, Nieto, abuelo) :-
    padrede(Abuelo, Padre),
    (padrede(Padre, Nieto); madrede(Padre, Nieto)),
    hombre(Abuelo).

relacion(Abuela, Nieto, abuela) :-
    madrede(Abuela, Padre),
    (padrede(Padre, Nieto); madrede(Padre, Nieto)),
    mujer(Abuela).

% tio/tia
relacion(Tio, Sobrino, tio) :-
    relacion(Tio, Padre, hermano),
    (padrede(Padre, Sobrino); madrede(Padre, Sobrino)),
    hombre(Tio).

relacion(Tia, Sobrino, tia) :-
    relacion(Tia, Padre, hermana),
    (padrede(Padre, Sobrino); madrede(Padre, Sobrino)),
    mujer(Tia).

% primo/prima
relacion(Primo, Persona, primo) :-
    relacion(Primo, Tio, hijo),
    relacion(Tio, Persona, tio),
    hombre(Primo).

relacion(Prima, Persona, prima) :-
    relacion(Prima, Tia, hija),
    relacion(Tia, Persona, tia),
    mujer(Prima).

% Si no hay relación directa conocida:
relacion(_, _, desconocido).

% ---------------------------------------------------------------------------------
%       PROCESAMIENTO DE CONSULTA TIPO NATURAL "¿qué es salvador de bryan?" 
% ---------------------------------------------------------------------------------

% Parsear consulta: ejemplo [que, es, Persona1Atom, de, Persona2Atom]
procesar_consulta_relacion(Input) :-
    % Esperamos lista: [que, es, Persona1, de, Persona2]
    Input = [que, es, Persona1Atom, de, Persona2Atom],
    atom_string(Persona1Atom, Persona1Str),
    atom_string(Persona2Atom, Persona2Str),
    % Convertir string a átomo (según como estén definidos)
    atom_string(Persona1, Persona1Str),
    atom_string(Persona2, Persona2Str),
    relacion(Persona1, Persona2, Parentesco),
    (Parentesco = desconocido ->
        format('No conozco la relacion entre ~w y ~w.~n', [Persona1, Persona2])
    ;
        format('~w es el/la ~w de ~w.~n', [Persona1, Parentesco, Persona2])
    ).


% --- BASE DE VIDEOJUEGOS ---
consola(playstation).
consola(xbox).
consola(nintendo).
consola(pc).

categoria(accion).
categoria(aventura).
categoria(zombies).

consola_genero_videojuego(playstation, aventura, uncharted_4).
consola_genero_videojuego(playstation, aventura, the_last_of_us_part_ii).
consola_genero_videojuego(playstation, aventura, ghost_of_tsushima).
consola_genero_videojuego(playstation, zombies, resident_evil_2_remake).
consola_genero_videojuego(playstation, zombies, resident_evil_4_remake).
consola_genero_videojuego(playstation, zombies, days_gone).
consola_genero_videojuego(playstation, accion, spider_man_miles_morales).
consola_genero_videojuego(playstation, accion, god_of_war_ragnarok).
consola_genero_videojuego(playstation, accion, horizon_forbidden_west).

consola_genero_videojuego(xbox, aventura, halo_infinite).
consola_genero_videojuego(xbox, aventura, ori_and_the_will_of_the_wisps).
consola_genero_videojuego(xbox, aventura, sea_of_thieves).
consola_genero_videojuego(xbox, zombies, state_of_decay_2).
consola_genero_videojuego(xbox, zombies, back_4_blood).
consola_genero_videojuego(xbox, zombies, dead_rising_4).
consola_genero_videojuego(xbox, accion, gears_5).
consola_genero_videojuego(xbox, accion, sunset_overdrive).
consola_genero_videojuego(xbox, accion, quantum_break).

consola_genero_videojuego(nintendo, aventura, zelda_tears_of_the_kingdom).
consola_genero_videojuego(nintendo, aventura, super_mario_odyssey).
consola_genero_videojuego(nintendo, aventura, luigis_mansion_3).
consola_genero_videojuego(nintendo, zombies, zombiu).
consola_genero_videojuego(nintendo, zombies, resident_evil_revelations).
consola_genero_videojuego(nintendo, zombies, deadly_premonition_origins).
consola_genero_videojuego(nintendo, accion, bayonetta_3).
consola_genero_videojuego(nintendo, accion, metroid_dread).
consola_genero_videojuego(nintendo, accion, astral_chain).

consola_genero_videojuego(pc, aventura, control).
consola_genero_videojuego(pc, aventura, a_plague_tale_requiem).
consola_genero_videojuego(pc, aventura, alan_wake_ii).
consola_genero_videojuego(pc, zombies, dying_light_2).
consola_genero_videojuego(pc, zombies, left_4_dead_2).
consola_genero_videojuego(pc, zombies, project_zomboid).
consola_genero_videojuego(pc, accion, doom_eternal).
consola_genero_videojuego(pc, accion, cyberpunk_2077).
consola_genero_videojuego(pc, accion, call_of_duty_modern_warfare).

respuesta_genero(Genero, Lista) :-
    findall(J, consola_genero_videojuego(_, Genero, J), Juegos),
    atomic_list_concat(Juegos, ', ', Lista).


% --- BASE DE PELÍCULAS ---
genero_pelicula(drama).
genero_pelicula(comedia).
genero_pelicula(terror).

pelicula_genero(drama, 'Mad Max').
pelicula_genero(drama, 'John Wick').
pelicula_genero(drama, 'Misión Imposible').

pelicula_genero(comedia, 'Superbad').
pelicula_genero(comedia, 'Liar Liar').
pelicula_genero(comedia, 'The Mask').

pelicula_genero(terror, 'El Conjuro').
pelicula_genero(terror, 'It').
pelicula_genero(terror, 'Actividad Paranormal').

respuesta_pelicula(Genero, Lista) :-
    findall(P, pelicula_genero(Genero, P), Peliculas),
    atomic_list_concat(Peliculas, ', ', Lista).

% --- BASE DE COMIDA ---
tipo_comida(mexicana).
tipo_comida(italiana).
tipo_comida(japonesa).

comida_tipo(mexicana, 'tacos').
comida_tipo(mexicana, 'pozole').
comida_tipo(mexicana, 'enchiladas').

comida_tipo(italiana, 'pizza').
comida_tipo(italiana, 'lasaña').
comida_tipo(italiana, 'spaghetti').

comida_tipo(japonesa, 'sushi').
comida_tipo(japonesa, 'ramen').
comida_tipo(japonesa, 'tempura').

respuesta_comida(Tipo, Lista) :-
    findall(C, comida_tipo(Tipo, C), Platillos),
    atomic_list_concat(Platillos, ', ', Lista).

% --- BASE DE ROPA ---
tipo_ropa(invierno).
tipo_ropa(verano).
tipo_ropa(deportiva).

ropa_tipo(invierno, 'abrigo').
ropa_tipo(invierno, 'bufanda').
ropa_tipo(invierno, 'guantes').

ropa_tipo(verano, 'short').
ropa_tipo(verano, 'camiseta').
ropa_tipo(verano, 'sandalias').

ropa_tipo(deportiva, 'tenis').
ropa_tipo(deportiva, 'pantalon_deportivo').
ropa_tipo(deportiva, 'sudadera').

respuesta_ropa(Tipo, Lista) :-
    findall(R, ropa_tipo(Tipo, R), Ropa),
    atomic_list_concat(Ropa, ', ', Lista).


% --- SISTEMA DE PREFERENCIAS ---
elizaLikes(X, R):- likes(X), R = ['Yeah', i, like, X].
elizaLikes(X, R):- \+likes(X), R = ['Nope', i, do, not, like, X].
likes(apples).
likes(ponies).
likes(zombies).
likes(manzanas).
likes(computadoras).
likes(carros).

elizaDoes(X, R):- does(X), R = ['Yes', i, X, and, i, love, it].
elizaDoes(X, R):- \+does(X), R = ['No', i, do, not, X ,'.', it, is, too, hard, for, me].
does(study).
does(cook).
does(work).

elizaIs(X, R):- is0(X), R = ['Yes', yo, soy, X].
elizaIs(X, R):- \+is0(X), R = ['No', i, am, not, X].
is0(dumb).
is0(weird).
is0(nice).
is0(fine).
is0(happy).
is0(redundant).

match([], _).
match([S|Stim], [I|Input]) :-
    (atom(S) -> S == I ; S = I),
    match(Stim, Input).


replace0([], _, _, Resp, R):- append(Resp, [], R), !.

replace0([I|_], Input, _, Resp, R):-
    nth0(0, Resp, flagLike),
    nth0(I, Input, Atom),
    elizaLikes(Atom, R), !.

replace0([I|_], Input, _, Resp, R):-
    nth0(0, Resp, flagDo),
    nth0(I, Input, Atom),
    elizaDoes(Atom, R), !.

replace0([I|_], Input, _, Resp, R):-
    nth0(0, Resp, flagIs),
    nth0(I, Input, Atom),
    elizaIs(Atom, R), !.

replace0([I|Index], Input, N, Resp, R) :-
    length(Index, M), M =:= 0,
    nth0(I, Input, Atom),
    select(N, Resp, Atom, R1),
    append(R1, [], R), !.

replace0([I|Index], Input, N, Resp, R) :-
    nth0(I, Input, Atom),
    length(Index, M), M > 0,
    select(N, Resp, Atom, R1),
    N1 is N + 1,
    replace0(Index, Input, N1, R1, R), !.

