:- [matrimonio].
:- lib(fd).
:- lib(listut).

sposi(LT):-
    get_data(NI,NT,C,Conflicts,Alliances),

    length(LT,NI),
    LT :: [1..NT],
    DomC :: [1..C],
     
    %conflict_constrains(Conflicts,LT).
    %capacity_constrains(1,NT,DomC,LT),

    %fun_obj(Alliances, LT, Obj),
    
    %append(LT,[Obj],List),

   % min_max(labeling(List), Obj).


fun_obj([],_,0).
fun_obj([conosce(I1,I2)|ListC], LT, Obj):-
    fun_obj(ListC, LT, Obj1),
    nth1(I1,LT,T1),
    nth1(I2,LT,T2),
    T1 #= T2 #<=> B,
    Obj #= Obj1 + B.

capacity_constrains(NT,NT,DomC,LT):- !,
    occurences(NT,LT,DomC).
capacity_constrains(N,NT,DomC,LT):-
    occurences(N,LT,DomC),
    N1 is N + 1,
    capacity_constrains(N1,NT,C,L).


conflict_constrains([],_).
conflict_constrains([conflitto(I1,I2)|ListC], LT):-
    nth1(I1,LT,T1),
    nth1(I2,LT,T2),
    T1 #\= T2,
    conflict_constrains(ListC,LT).


get_data(NI,NT,C,Conflicts,Alliances):-
    num_invitati(NI),
    num_tavoli(NT),
    capacita(C),
    findall(conflitto(X,Y), conflitto(X,Y), Conflicts),
    findall(conosce(X,Y), conosce(X,Y), Alliances).