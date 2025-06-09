:- [production].
:- lib(fd).
:- lib(cumulative).
:- lib(fd_global).

schedule(OrderList):-
    read_data(OrderList,PrecList),
    generate_list_cumulative(OrderList,ListS,ListD,ListR),
    cumulative(ListS,ListD,ListR,1),
    impose_precedence(PrecList,OrderList),
    guadagno(OrderList,ListG),
    sumlist(ListG,Guadagno),
    C #= -Guadagno,
    append(ListS,[C],Vars),
    min_max(labeling(Vars),C).



guadagno([],[]).
guadagno([ordine(_,Deadline,Start)|Ls],[G|ListG]):-
    End #= Start + 1,
    #<=(End,Deadline,G),
    guadagno(Ls,ListG).



impose_precedence([],_).
impose_precedence([precedenza(ID1,ID2)|ListP],OrderList):-
    get_order(ID1,OrderList,Start1),
    get_order(ID2,OrderList,Start2),
    Start2 #>= Start1 + 1,
    impose_precedence(ListP,OrderList).

get_order(ID,[ordine(ID,_,Start)|_],Start):-!.
get_order(ID,[_|Ls],Start):-
    get_order(ID,Ls,Start).




generate_list_cumulative([],[],[],[]).
generate_list_cumulative([ordine(_,_,Start)|Ls],[Start|ListS],[1|ListD],[1|ListR]):-
    generate_list_cumulative(Ls,ListS,ListD,ListR).

read_data(OrderList,PrecList):-
    findall(ordine(ID,Deadline),ordine(ID,Deadline),Data),
    endtime(MaxEndTime),
    make_order_variables(Data,MaxEndTime,OrderList),
    findall(precedenza(ID1,ID2),precedenza(ID1,ID2),PrecList).

make_order_variables([],_,[]).
make_order_variables([ordine(ID,Deadline)|Ds],MaxEndTime,[ordine(ID,Deadline,Start)|Ls]):-
    Start #>= 0,
    Start + 1 #<= MaxEndTime,
    make_order_variables(Ds,MaxEndTime,Ls).