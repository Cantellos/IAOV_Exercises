:-lib(fd).
:-lib(listut).
:-lib(fd_global).

% Prezzo lista ordinata con primo elemento auto più cara e ultimo auto meno cara

% Prezzo            [+ Cara, .. , .. , - Cara]
% Colore esterni    [Rosso, Giallo, Nero, Grigio]
% Colore interni    [Marroni, Panna, Blu, Verdi]

% Auto              [Alfa, Ferrari, Lamborghini, Maserati]
%                      1      2           3          4

auto(Prezzo, Interni, Esterno):-
    length(Prezzo, 4),
    length(Interni, 4),
    length(Esterno, 4),

    [Prezzo, Interni, Esterno] :: [1..4],

    fd:alldifferent(Prezzo),
    fd:alldifferent(Interni),
    fd:alldifferent(Esterno),

    % Telefonata 1
    nth1(2, Esterno, X11), X11 #= 3 #<=> B11,
    nth1(2, Prezzo, X12), X12 #= 3 #<=> B12,
    nth1(1, Interni, X13), X13 #= 3 #<=> B13,

    % Telefonata 2
    nth1(1, Esterno, X21), X21 #= 2 #<=> B21,
    nth1(4, Prezzo, X22), X22 #= 2 #<=> B22,
    nth1(1, Interni, X23), X23 #= 2 #<=> B23,

    % Telefonata 3
    nth1(3, Esterno, X31), X31 #= 1 #<=> B31,
    nth1(1, Prezzo, X32), X32 #= 1 #<=> B32,
    nth1(2, Interni, X33), X33 #= 1 #<=> B33,

    % Telefonata 4
    nth1(1, Esterno, X41), X41 #= 3 #<=> B41,
    nth1(4, Prezzo, X42), X42 #= 3 #<=> B42,
    nth1(3, Interni, X43), X43 #= 3 #<=> B43,

    % Telefonata 5
    nth1(4, Esterno, X51), X51 #= 1 #<=> B51,
    nth1(3, Prezzo, X52), X52 #= 1 #<=> B52,
    nth1(3, Interni, X53), X53 #= 1 #<=> B53,

    B = [B11, B12, B13, B21, B22, B23, B31, B32, B33, B41, B42, B43, B51, B52, B53],

    fd_global:sumlist(B, Conta),
    C #= 15 - Conta,
    minimize(labeling(B), C).