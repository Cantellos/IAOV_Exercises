{install(X)}:- package(X).

:- requires(P1,P2), install(P1), not install(P2).

:- conflict(P1,P2), install(P1), install(P2).

op(N) :- install(N), not installed(N).
op(N) :- installed(N), not install(N).

#minimize{1,N:op(N)}.

#show install/1.