:-lib(fd).
 
nonnaluisa(N,C,T,Inizio_Nonna,Inizio_Cane,Inizio_Torta):-
   [N,C,T] :: [1..3],
   [Inizio_Nonna,Inizio_Cane,Inizio_Torta] :: [0..20],
 
   element(N,[5,3,2],Task_nonna),
   element(C,[4,2,3],Task_cane),
   element(T,[2,5,4],Task_torta),
   alldifferent([N,C,T]),
 
   Inizio_Nonna #= 0,
 
   Inizio_Cane #>= Inizio_Nonna + 1,
   Inizio_Cane #<= Inizio_Nonna + Task_nonna - 1,
 
   Inizio_Torta #>= Inizio_Cane,
   Inizio_Torta + Task_torta #<= Inizio_Nonna + Task_nonna,
   Inizio_Torta + Task_torta #<= Inizio_Cane + Task_cane,
 

   labeling([N,C,T,Inizio_Nonna, Inizio_Cane, Inizio_Torta]).