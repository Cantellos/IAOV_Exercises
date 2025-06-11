%  0 --> asilo   1 --> padre   2 --> madre   3 --> baby-sitter

days(1..30).
values(0..3).

1{giorno(D,X) : values(X)}:- days(D).

:- impegno(V,D), giorno(D,V).

:- {giorno(_,1)} > 4.
:- {giorno(_,2)} > 6.

:- giorno(Sa, 0), giorno(Ea, 0), Sa != Ea, |Ea-Sa| > 6.

presenza_asilo():- giorno(D,0).

costoB(C) :- N= #count{D:giorno(D,3)}, C = 50*N.

costo_tot(C):- costoB(C), not presenza_asilo.
costo_tot(Ct):- costoB(C), presenza_asilo, Ct = 100 + C.

#minimize{C:costo_tot(C)}.

#show giorno/2.
#show costo_tot/1.
#show costoBs/1.