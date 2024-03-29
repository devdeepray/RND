:- module(nqueen, [nqueen/2]).

nqueen(N, B) :- NI is N-1, nqueenh(NI, N, B).

not_member(X,Y) :- member(X,Y), !, fail.
not_member(_,_).

nqueenh(_, 0, []) :- !.
nqueenh(N, I, [H|T]) :- SI is I-1, nqueenh(N, SI, T), between(0, N, H), not_member(H, T), nodiag(H, T, 1).

nodiag(_, [], _).
nodiag(H, [H1|T], Dist) :- Distp1 is Dist+1, nodiag(H, T, Distp1), 
                           Diff is abs(H-H1), Diff \= Dist.
