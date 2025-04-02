% 1. Definir los guardianes
guardian(apolo).
guardian(hecate).
guardian(ares).
guardian(hermes).

% 2. Definir los templos
templo(fuego).
templo(agua).
templo(tierra).
templo(aire).

% 3. Restricciones del problema

% Apolo no cuida el templo de fuego ni el de tierra
no_cuida(apolo, fuego).
no_cuida(apolo, tierra).

% Hecate no cuida el templo de aire
no_cuida(hecate, aire).

% Ares no cuida el templo de agua ni de aire
no_cuida(ares, agua).
no_cuida(ares, aire).

% Hermes cuida el templo de fuego o de agua
cuida_o(hermes, fuego).
cuida_o(hermes, agua).

% 4. Regla para asignar templos a guardianes

% La regla cuida/2 establece que templo cuida cada guardian
% El guardian debe ser un hecho valido, y el templo tambien debe existir.
% El guardian no debe estar prohibido de ese templo (con la regla no_cuida/2).
% Ademas, si es Hermes, se tiene en cuenta la restricción especial que dice que debe cuidar fuego o agua.
cuida(Guardian, Templo) :-
    guardian(Guardian),             % El guardian debe existir
    templo(Templo),                 % El templo debe existir
    not(no_cuida(Guardian, Templo)), % El guardian no debe estar prohibido de ese templo
    (Guardian \= hermes; cuida_o(Guardian, Templo)).  % Si es Hermes, debe cumplir su restricción especial (fuego o agua)


