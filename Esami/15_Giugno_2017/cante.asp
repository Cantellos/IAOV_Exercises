colori(Col):- car(_,Col).
number(N):- car(N,_).

1{seq(Pos,Col,Old) : number(Pos)}1 :- car(Old,Col).

:- seq(Pos,_,Old1), seq(Pos,_,Old2), Old1 != Old2. 

:- seq(Pos,_,Old), maxd(D), |Pos-Old| > D.

costo(Pos):- seq(Pos,Col,_), seq(Pos1,Col1,_), Pos1 = Pos + 1, Col1 != Col.

#minimize{1,Pos:costo(Pos)}.

#show seq/3.




