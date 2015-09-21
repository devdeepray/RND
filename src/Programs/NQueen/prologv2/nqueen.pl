:- module(nqueen, [nqueen/2]).

nqueen(N, B) :- NI is N-1, nqueenh(NI, N,[], B).

not_member(X,Y) :- member(X,Y), !, fail.
not_member(_,_).

nqueenh(_, 0, S, S) :- !.
nqueenh(N, I, L, S) :- SI is I-1, between(0, N, H), not_member(H, L), nodiag(H, L, 1),
                        nqueenh(N, SI, [H|L], S).

nodiag(_, [], _).
nodiag(H, [H1|T], Dist) :- Distp1 is Dist+1, nodiag(H, T, Distp1), 
                           Diff is abs(H-H1), Diff \= Dist.
