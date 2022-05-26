menu(Tree):-
    writeln("Menu:"),nl,
    writeln("1. Create an empty binary search tree"),nl,
    writeln("2. Insert or modify node"),nl,
    writeln("3. Delete node"),nl,
    writeln("4. Node lookup"),nl,
    writeln("5. Show tree"),nl,
    writeln("6. Exit"),nl,nl,
    read(Q),action(Q,Tree,_).

action(1,_,nil) :- writeln("Created an empty binary search tree..."),
    			   menu(nil),!.

action(2,Tree,NewTree) :- writeln("Enter value of key: "),
						  read(K),
						  write("Enter value of node: "),
						  read(V),
					      insert(Tree,K,V,NewTree),
    					  menu(NewTree),!.

action(3,Tree,NewTree) :- writeln("(Read the code for the delete) Enter value of key: "),
    					  read(K),
    					  delete(K,Tree,NewTree),
    					  menu(NewTree),!.

action(4,Tree,_) :- writeln("Enter value of key: "),
    					  read(K),
    					  nodeLookup(Tree,K),
    					  menu(Tree),!.

action(5,Tree,_) :- showTree(Tree),
    				menu(Tree),!.

action(6,_,_) :- writeln("Exitted."),!.

action(_,Tree,_) :- writeln("Bad choice"),menu(Tree),!.



%writeln("Enter value of key: "),
%read(K),
%write("Enter value of node: "),
%read(V),
%insert(Tree,K,V,NewTree).

insert(nil,K,V,bt(K,V,nil,nil)).
insert(bt(K,_,B1,B2),K,V,bt(K,V,B1,B2)) :- !.
insert(bt(K1,V1,B1,B2),K,V,bt(K1,V1,B1,B2New)):-
    K1<K, !,
    insert(B2,K,V,B2New).
insert(bt(K1,V1,B1,B2),K,V,bt(K1,V1,B1New,B2)):-
    insert(B1,K,V,B1New).

showTree(nil).
showTree(bt(K,V,B1,B2)) :-
    showTree(B1),
    write("Key: "),write(K),
    write(": value: "), writeln(V),
    showTree(B2).

nodeLookup(nil,_) :-
    writeln("Unable to find").
nodeLookup(bt(K,V1,_,_),K) :-
    writeln(V1).
nodeLookup(bt(K1,_,L,_),K) :-
    K < K1,
    nodeLookup(L,K).
nodeLookup(bt(K1,_,_,R),K) :-
    K > K1,
    nodeLookup(R,K).


delete(_,nil,nil):- !.

delete(Key,bt(Key1,Value,T1,T2),bt(Key1,Value,T1,T2New)) :- 
  Key>Key1,!,
  delete(Key,T2,T2New). 

delete(Key,bt(Key1,Value,T1,T2),bt(Key1,Value,T1New,T2)) :- 
  Key<Key1,!,
  delete(Key,T1,T1New).   

delete(Key,bt(Key,_,nil,T2),T2):- !.

delete(Key,bt(Key,_,T1,nil),T1):- !.

delete(Key,bt(Key,_,T1,T2),NewTree):-
  reAdd(T1,T2,NewTree), !.

reAdd(bt(Key,Value,T1,nil),T,bt(Key,Value,T1,T)): -!.

reAdd(bt(Key,Value,T1,T2),T,bt(Key,Value,T1,T2New)):-
  reAdd(T2,T,T2New).
