:-[task].
:-lib(fd).
:-lib(cumulative).
:-lib(fd_global).


stampa(TaskList):-
    generate_variables(TaskList),
    generate_list_cumulative(TaskList,ListS,ListD,ListR),
    cumulative(ListS,ListD,ListR,1),
    distance_list(TaskList,TaskList,LssD),
    flatten(LssD,DistanceList),
    minlist(DistanceList,Min),
    C #= -Min,
    minimize(labeling(ListS),C).


distance_list([],_,[]).
distance_list([task(ID,EST,LCT,D,Start)|Ls],TaskList,[Ld|Lds]):-
    distance(task(ID,EST,LCT,D,Start),TaskList,Ld),
    distance_list(Ls,TaskList,Lds).

distance(_,[],[]).
distance(task(ID,_,_,D,Start),[task(ID,_,_,_,Start)|Ts],Ld):-
    !,distance(task(ID,_,_,D,Start),Ts,Ld).
distance(task(IDi,_,_,Di,Starti),[task(IDj,_,_,_,Startj)|Ts],[D|Ld]):-
    A #= Starti + Di - Startj,
    D #= abs(A),
    distance(task(IDi,_,_,Di,Starti),Ts,Ld).

generate_variables(TaskList):-
    findall(task(ID,EST,LCT,D),task(ID,EST,LCT,D),Data),
    make_task_variables(Data,TaskList).

make_task_variables([],[]):-!.
make_task_variables([task(ID,EST,LCT,D)|Ds],[task(ID,EST,LCT,D,Start)|Ls]):-
    Start #>= EST,
    Start + D #<= LCT,
    make_task_variables(Ds,Ls).

generate_list_cumulative([],[],[],[]):-!.
generate_list_cumulative([task(ID,EST,LCT,D,Start)|Ls],[Start|Ss],[D|Ds],[1|Rs]):-
    generate_list_cumulative(Ls,Ss,Ds,Rs).

