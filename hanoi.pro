move(1,A,B,_) :-
   write("Moved the topmost disk from "), 
    							write(A),
    							write(" to "),
    										write(B), nl.
move(N,A,B,C) :-
   N>1,
   M is N-1,
   move(M,A,C,B),
   move(1,A,B,_),
   move(M,C,B,A).
