:- [impegni].
:- lib(fd).
:- lib(fd_global).
:- lib(listut).

asilo(L, Asilo):-
    
    findall((X,Y), impegno(X,Y), Impegni),

    length(L, 30),
    L::[0..3],

    Asilo = [StartAsilo, EndAsilo],
    Asilo::[1..30],

    StartAsilo #< EndAsilo,
    EndAsilo - StartAsilo #<= 6,

    impose_impegni(L, Impegni),

    impose_asilo(1, L, StartAsilo, EndAsilo),
    
    occurrences(1, L, P),
    occurrences(2, L, M),
    P #<= 4, 
    M #<= 6,

    objective(L, Costo),
    append(L, Asilo, Vars),

    min_max(labeling(Vars), Costo).


costo_asilo([], 0).
costo_asilo([0|_], 100):- !.
costo_asilo([_|T], Cost):-
    costo_asilo(T, Cost).

objective(L, Cost):-
    costo_asilo(L, CostA),
    occurrences(3, L, CostB),
    Cost #= CostA + CostB*50.


impose_asilo(_,[],_,_).
impose_asilo(Day, [H|T], Start, End):-
    (Day #< Start #\/ Day #> End) #<=> B,
    H #\= 0 #<=> B,
    Next is Day + 1,
    impose_asilo(Next, T, Start, End).


impose_impegni(_,[]).
impose_impegni(L, [(Gen,Day)|ListI]):-
    nth1(Day, L, X),
    X #\= Gen,
    impose_impegni(L, ListI).