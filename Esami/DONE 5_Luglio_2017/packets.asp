{result(X):package(X)}:- package(X).

result(X):- install(X).

:- requires(X,Y), result(X), not result(Y).
:- conflict(X,Y), result(X), result(Y).

op(X):- installed(X), not result(X).
op(X):- result(X), not installed(X).

#minimize{1,X:op(X)}.

#show result/1.