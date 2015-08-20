nqueen(N, B) :- !, nqueenh(N, N, B).

not_member(X,Y) :- member(X,Y), !, fail.
not_member(_,_).

nqueenh(_, 0, []) :- !.
nqueenh(N, I, [H|T]) :- SI is I-1, NP is N-1, !, nqueenh(N, SI, T), between(0, NP, H), not_member(H, T), nodiag(H, T, 1).

nodiag(_, [], _).
nodiag(H, [H1|T], Dist) :- Distp1 is Dist+1, !, nodiag(H, T, Distp1), Diff is abs(H-H1), Diff \= Dist.
