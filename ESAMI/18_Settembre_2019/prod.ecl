:-[production].
:-lib(fd).
:-lib(fd_global).
:-lib(cumulative).

prod(Orders):-
    ordini(Prod),
    precedenze(Prec),
    maxend(End),
    add_start(Prod, Orders, End),
    add_prec(Orders, Orders, Prec),
    generate_cumulative(Orders,StartList,DurList,ResList),
    cumulative(StartList,DurList,ResList,1),
    fun_obb(Orders, FunObbList),
    sumlist(FunObbList,FunObb),
    minimize(labeling(Orders),FunObb).


ordini(Prod):-
    findall(ordine(Id,Deadline), ordine(Id,Deadline), Prod).

precedenze(Prec):-
    findall(precedenza(Id,Deadline), precedenza(Id,Deadline), Prec).

maxend(End):-
    endtime(End).

add_start([],[],_).
add_start([ordine(Id,Deadline)|T1],[ordine(Id,Deadline,Start)|T2],End):-
    Start #>= 0,
    Start + 1 #<= End,
    add_start(T1,T2,End).

generate_cumulative([],[],[],[]).
generate_cumulative([ordine(Id,Deadline,Start)|To],[Start|Ts],[1|Td],[1|Tr]):-
    generate_cumulative(To,Ts,Td,Tr).

add_prec([],[],[]).
add_prec([ordine(Id1,_,Start1)|T1],[ordine(Id2,_,Start2)|T2],[precedenza(Id3,Id4)|Tp]):-
    !, add_prec(T1,T2,Tp).
add_prec([ordine(Id1,_,Start1)|T1],[ordine(Id2,_,Start2)|T2],[precedenza(Id1,Id2)|Tp]):-
    Start1 #< Start2,
    add_prec(T1,T2,Tp).

fun_obb([],[]).
fun_obb([ordine(Id,Deadline,Start)|To],[V|Tv]):-
    #<=(Start+1,Deadline,V),
    Start + 1 #<= Deadline #<=> V,
    fun_obb(To,Tv).



