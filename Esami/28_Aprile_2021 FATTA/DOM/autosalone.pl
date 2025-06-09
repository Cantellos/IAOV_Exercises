:- lib(fd).
:- lib(listut).
:- lib(fd_global).

%Alfa 1
%Ferrari 2
%Lambo 3
%Maserati 4

%Prezzo --> [più cara..........meno cara]
%Colore --> [Rosso,     Giallo,     Nero,   Grigio]
%Interni --> [Marroni,  Panna,      Blu,    Verde]
%               1       2           3           4
%B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15


autosalone(Prezzo,Colore,Interni):-
    length(Prezzo,4),
    length(Colore,4),
    length(Interni,4),
    [Prezzo,Colore,Interni] :: [1..4],
    B = [B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15],

    fd_global:alldifferent(Prezzo),
    fd_global:alldifferent(Colore),
    fd_global:alldifferent(Interni),

    nth1(2,Colore,X1), #=(X1,3,B1),
    nth1(2,Prezzo,X2), #=(X2,3,B2),
    nth1(1,Interni,X3), #=(X3,3,B3),

    nth1(1,Interni,X4), #=(X4,2,B4),
    nth1(4,Prezzo,X5), #=(X5,2,B5),
    nth1(1,Colore,X6), #=(X6,2,B6),

    nth1(3,Colore,X7), #=(X7,1,B7),
    nth1(1,Prezzo,X8), #=(X8,1,B8),
    nth1(2,Interni,X9), #=(X9,1,B9),

    nth1(4,Prezzo,X10), #=(X10,3,B10),
    nth1(3,Interni,X11), #=(X11,3,B11),
    nth1(1,Colore,X12), #=(X12,3,B12),

    nth1(3,Prezzo,X13), #=(X13,1,B13),
    nth1(3,Interni,X14), #=(X14,1,B14),
    nth1(4,Colore,X15), #=(X15,1,B15),

    fd_global:sumlist(B,Conta),
    C #= 15 - Conta,
    append(B,[Prezzo,Colore,Interni],Vars),
    minimize(labeling(Vars),C).


