{install(ID)}:- package(ID).

:- requires(P1,P2), install(P1), not install(P2).

:- conflict(P1,P2), install(P1), install(P2).

op(X):- install(X), not installed(X).
op(X):- not install(X), installed(X).

#minimize{1,N:op(N)}.

#show install/1.