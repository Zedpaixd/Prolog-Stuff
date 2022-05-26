arc(newcastle,carlisle,58).
arc(carlisle,penrith,23).
arc(smallville,metropolis,15).
arc(penrith,darlington,52).
arc(smallville,ambridge,10).
arc(workington,carlisle,33).
arc(workington,ambridge,5).
arc(workington,penrith,39).
arc(darlington,metropolis,25).

connected(Arc1,Arc2,Weight) :- arc(Arc1,Arc2,Weight).
connected(Arc1,Arc2,Weight) :- arc(Arc2,Arc1,Weight).

%path(A,B,Path,Weight) :-
%       travel(A,B,[A],Q,Weight), 
%       reverse(Q,Path).

%travel(X,X,[X|X],Weight) :- 
%       connected(A,B,Weight).




propagate_min([X],[X]):- !.

propagate_min([H|R],[X,Y|T]):-
   propagate_min(R,[H1|T]),
   order(H,H1,X,Y).

order(X,X1,X,X1) :- !.

order(arc(Path1,R),arc(Path2,R1),arc(Path2,R1),arc(Path1,R)) :- Path1>Path2.  

verifex(Y,[X|Xs],Weight,R) :- 
  	arc(X,Y,Cost), 
    R is Weight+Cost,
    not(member(Y,[X|Xs])).

wp_list_extensions([arc(Weight,[H|T])|_],H,arc(Weight,[H|T])) :- !. 

wp_list_extensions([arc(Weight,X)|Rest],Y,WeightedPath) :-
  findall(arc(NewPath,[Z|X]), verifex(Z,X,Weight,NewPath), Rest1),
  append(Rest,Rest1,Ls),
  propagate_min(Ls,Rs), 
  wp_list_extensions(Rs,Y,WeightedPath).

shortest_path(X,Y,arc(W,Path)) :- 
  wp_list_extensions([arc(0,[X])],Y,arc(W,T)), 
  reverse(T,Path).
