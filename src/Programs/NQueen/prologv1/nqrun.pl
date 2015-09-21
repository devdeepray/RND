:- use_module(nqueen).

query :-
  call(time(findall(_, nqueen(4, _), _))),
  call(time(findall(_, nqueen(5, _), _))),
  call(time(findall(_, nqueen(6, _), _))),
  call(time(findall(_, nqueen(7, _), _))),
  call(time(findall(_, nqueen(8, _), _))),
  call(time(findall(_, nqueen(9, _), _))),
  call(time(findall(_, nqueen(10, _), _))),
  call(time(findall(_, nqueen(11, _), _))),
  call(time(findall(_, nqueen(12, _), _))).
main :-
  catch(query, E, (print_message(error, E), fail)),
  halt.
main :-
  halt(1).
  
