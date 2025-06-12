:-[risposte].
:-lib(fd).
:-lib(fd_global).
:-lib(listut).

cante(Ass,Weap):-

    length(Ass,6),
    Ass :: [0..4],
    length(Weap,6),
    Weap :: [0..4],

    findall((Richiedente,Rispondente,Assassino,Arma),risposta(Richiedente,Rispondente,Assassino,Arma), Risposte),

    impose_vincoli(Risposte, Ass, Weap),
    occurrences(0, Ass, 1),
    occurrences(0, Weap, 1),
    append(Ass,Weap,List),
    %occurrences(1,List,N1),
    % ...
    %N1 #>= 2 #/\ N1 #<= 3,
    % ...
    %sarebbe più corretto appendere la lista di tutti i vincoli reificati prima di fare il labeling
    labeling(List).


impose_vincoli([],_,_).
impose_vincoli([Risp|ListRisp], Ass, Weap):-
    deduzione(Risp, Ass, Weap),
    impose_vincoli(ListRisp, Ass, Weap).

deduzione((Domanda,0,A,W), ListAss, ListWeap):- !,
    nth1(A, ListAss, Ass),
    nth1(W, ListWeap, Weap),
    Ass #= Domanda #<=> B1,
    Ass #= 0 #<=> B2,
    B1 + B2 #= 1,
    Weap #= Domanda #<=> B3,
    Weap #= 0 #<=> B4,
    B3 + B4 #= 1.
deduzione((_,Risposta,A,W), ListAss, ListWeap):-
    nth1(A, ListAss, Ass),
    nth1(W, ListWeap, Weap),
    Ass #= Risposta #<=> B1,
    Weap #= Risposta #<=> B2,
    B1 + B2 #>= 1.





