:- use_module(nqueen).

query :-
  call(time(findall(X, nqueen(4, X), _))),
  call(time(findall(X, nqueen(5, X), _))),
  call(time(findall(X, nqueen(6, X), _))),
  call(time(findall(X, nqueen(7, X), _))),
  call(time(findall(X, nqueen(8, X), _))),
  call(time(findall(X, nqueen(9, X), _))),
  call(time(findall(X, nqueen(10, X), _))),
  call(time(findall(X, nqueen(11, X), _))),
  call(time(findall(X, nqueen(12, X), _))).
main :-
  catch(query, E, (print_message(error, E), fail)),
  halt.
main :-
  halt(1).
  
