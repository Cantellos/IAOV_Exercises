start(0..End-1) :- endtime(End).

1{trattore(ID,ST) : start(ST)}1 :- ordine(ID,_).

:- trattore(ID1, ST), trattore(ID2, ST), ID1 != ID2.

:- trattore(ID1, ST1), trattore(ID2, ST2), precedenza(ID1, ID2), ST1+1 > ST2.

guadagno(ID):- trattore(ID,ST), ordine(ID,DL), ST+1 <= DL.

#maximize{1,ID : trattore(ID,_), guadagno(ID)}.

#show trattore/2.