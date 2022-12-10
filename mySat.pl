% 4.1)
% Damit alle gefundenen Belegungen ausgegeben werden, müssen die ! Operatoren bei sat([],X,X) und sat([[L|_]|Rest],X,Y) entfernt werden.
 
   sat([],X,X) 		  :- write(X).                    % Belegung gefunden

   sat([[]|_],_,_) 	  :- !,fail.                         % leere Klausel

   sat([[L|_]|Rest],X,Y)  :- member(L,X),!,             % L schon wahr
                             sat(Rest,X,Y).

   sat([[L|Ls]|Rest],X,Y) :- NL is -L, member(NL,X),!,   %-L schon wahr
                             sat([Ls|Rest],X,Y).

   sat([[L|_]|Rest],X,Y)  :- sat(Rest,[L|X],Y).       % probiere L=true  

   sat([[L|Ls]|Rest],X,Y) :- NL is -L, 
                             sat([Ls|Rest],[NL|X],Y).    % probiere L=false

% 4.2)
% Benutzung des build-in findall/3 Predicates, das dann alle möglichen Belegungen in einer Liste zusammenfasst.

solve(Input, L) :- findall(X, sat(Input, [], X), L).

test1(X) :- sat([[1,2]], [], X).
test2(L) :- solve([[1,2]], L).
test3(L) :- solve([[1,-4],[-1,3,-8],[1,8,11],[2,11],[-7,-3,9],
                   [-7,8,-9],[7,8,-10],[7,10,-11],[-3,-7,8],
                   [3,7,-1],[-3,-4,7],[3,-7],[-3,7]], L).