:- module(nqueen, [nqueen/2]).


nqueen(N,Qs) :- bagof(X, between(1,N,X), Xs), place(Xs,[],Qs).
 
place([], Res, Res).
place(Xs,Qs,Res) :-
  select(Q,Xs,Ys), not_diag(Q,Qs,1), place(Ys,[Q|Qs],Res).
 
not_diag(_, []     , _).
not_diag(Q, [Qh|Qs], D) :-
     abs(Q - Qh) =\= D, D1 is D + 1, not_diag(Q,Qs,D1).
