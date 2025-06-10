weap(1..6).
ass(1..6).
player(0..4).

1{ass_card(X,P):player(P)}1 :- ass(X).
1{weap_card(X,P):player(P)}1 :- weap(X).

:- ass_card(X,P1), ass_card(X,P2), P1 != P2.

contA(Ca):- Ca = #count{X:ass_card(X,0)}.
contW(Cw):- Cw = #count{X:weap_card(X,0)}.

:- contA(X), X != 1.
:- contW(X), X != 1.

:- risposta(D,0,A,_), not ass_card(A,0), not ass_card(A,D).
:- risposta(D,0,_,W), not weap_card(W,0), not weap_card(W,D).

:- risposta(_,R,A,W), not ass_card(A,R), not weap_card(W,R), R != 0.

#show ass_card/2.
#show weap_card/2.