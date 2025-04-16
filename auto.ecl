:- [automobili].
:- lib(fd).
:- lib(edge_finder3).

auto(End,ListC,ListA,ListN):-
	generateLists(End, ListC,ListA,ListN),
	imposeCumulativeLine(ListC,ListA,ListN),
	
	findall(ID,rich(ID,_,_,_,_),ListID),
	unione(ListC,ListA,ListN,TaskList),
	imposeCumulativeRich(ListID,TaskList),
	
	extractStartTime(ListC,S1),
	extractStartTime(ListA,S2),
	extractStartTime(ListN,S3),
	unione(S1,S2,S3,Variables),
	
	min_max(labeling(Variables),End).



imposeCumulativeRich([],_).
imposeCumulativeRich([ID|ListID],TaskList):-
	selectRich(ID,TaskList,ListRich),
	generateListCumulative(ListRich,StartList,DurList,ResList),
	cumulative(StartList,DurList,ResList,1),
	imposeCumulativeRich(ListID,TaskList).

selectRich(_,[],[]).
selectRich(ID,[rich(ID,_,TaskTime,Start)|T],[rich(ID,_,TaskTime,Start)|R]):-
	!,selectRich(ID,T,R).
selectRich(ID,[_|T],R):-
	selectRich(ID,T,R).


unione(L1,L2,L3,LU):-
	append(L1,L2,T1),
	append(T1,L3,LU).


imposeCumulativeLine(ListC,ListA,ListN):-
	imposeCumulative(ListC),
	imposeCumulative(ListA),
	imposeCumulative(ListN).

imposeCumulative(ListTask):-
	generateListCumulative(ListTask,StartList,DurList,ResList),
	cumulative(StartList,DurList,ResList,1).

generateListCumulative([],[],[],[]).
generateListCumulative([rich(_,_,TaskTime,Start)|T],[Start|Ss],[TaskTime|Ts],[1|Rs]):-
	generateListCumulative(T,Ss,Ts,Rs).

makeRichVariables([],_,_,[]).
makeRichVariables([rich(ID,Deadline,C,A,N)|T],End,TaskTime,[rich(ID,Deadline,TaskTime,Start)|Var]):-
	Start #>= 0,
	Start + TaskTime #<= Deadline,
	Start + TaskTime #<= End,
	makeRichVariables(T,End,TaskTime,Var).

generateLists(End, ListC,ListA,ListN):-
	findall(rich(ID,Deadline,C,A,N),(rich(ID,Deadline,C,A,N),C=1),DataC),
	findall(rich(ID,Deadline,C,A,N),(rich(ID,Deadline,C,A,N),A=1),DataA),
	findall(rich(ID,Deadline,C,A,N),(rich(ID,Deadline,C,A,N),N=1),DataN),
	makeRichVariables(DataC, End, 20, ListC),
	makeRichVariables(DataA, End, 80, ListA),
	makeRichVariables(DataN, End, 50, ListN).
	
extractStartTime([],[]).
extractStartTime([rich(_,_,_,Start)|T],[Start|Ss]):-
	extractStartTime(T,Ss).
