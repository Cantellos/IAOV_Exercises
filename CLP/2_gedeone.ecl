:-lib(fd).

gedeone(G,D,U):-

G :: 0..100,
D :: 0..100,
U :: 0..100,

5 * (D + 11) #= 6 * G - 6 * D,

U #= D + 3,

U + 3 #= G - D,

labeling([G,D,U]).