% ---------------------------------------
% solve(+Klauseln)
% ---------------------------------------
solve(Klauseln) 	:- member([],Klauseln),!,
			   print(Klauseln),print(" unerf�llbar"),nl,!,fail.  	    % unerf�llbar, falls leere Klausel erreicht

solve(Klauseln)		:- pickTwo(Klauseln,K1,K2),            		    % w�hle zwei Klauseln K1,K2
			   member(Lit,K1), NLit is -Lit, member(NLit,K2),         % so dass ein Lit in K1 negiert in K2 vorkommt
			   resolve(K1,K2,Lit,NLit,K3),														% und die Resolven
			   sort(K3,K3s),
			   not (member(K3s,Klauseln)),!,
																	    print(K1),print(' + '),print(K2),print(' ---> '),print(K3s),nl,                           % noch nicht vorhanden ist
			   solve([K3s|Klauseln]).                                  % f�ge die Resolvente hinzu und mache weiter
			   
solve(Klauseln)		:- print(Klauseln),print(" erf�llbar"),nl.				    % 	

% -------------------------
% resolvent(+K1,+K2,+L,+NL,-K)			   			   
% ------------------------			     
resolve(K1,K2,Lit,NLit,K)  :- remove(Lit,K1,RestK1),			    % entferne Lit aus K1
			      remove(NLit,K2,RestK2),                           % und dessen Negation aus K2
			      combine(RestK1,RestK2,K).                         % kombiniere die Reste zu neuer Klausel 
% -------------------
% combine(+K1,+K2,-K)			   			   
% -------------------			     
combine([],K,K)							:-!.					                        % 	
combine([L|Ls],K,KNeu) 			:- member(L,K),!,combine(Ls,K,KNeu).  % ein Literal soll nur einmal vorkommen
combine([L|Ls],K,_) 				:- NL is -L, member(NL,K),!,fail.     % kein Literal soll pos und neg vorkommen
combine([L|Ls],K,[L|KNeu]) 	:- combine(Ls,K,KNeu).                % ansonsten wie bei "append"

% -----------------
% pickTwo(+KM,-K1,-K2)			   			         % W�hle aus Klauselmenge KM zwei verschiedene Klauseln, K1 und K2
% -----------------		
% Version 1	     
% pickTwo([],_,_) 	:- !,fail.					       % KM ist leer	
% pickTwo([_],_,_) 	:- !,fail.					       % KM ist einelementig	
% pickTwo([X|Xs],X,Y) 	:- member(Y,Xs).	     % K1 : erste Klausel aus KM,  K2 eine aus dem Rest 
% pickTwo([_|Ys],X,Y) 	:- pickTwo(Ys,X,Y).    % igroriere erste KLausel, w�hle zwei aus dem Rest der Klauselmenge

% Version 2
pickTwo(Xs,A,B) :- member(A,Xs),member(B,Xs), A \= B.

/*
Durch Version 2 ist es möglich das pickTwo durch Backtracking Lösungen zurückgibt, die identisch sind und sich nur in der Reihenfolge
unterscheiden. So würde pickTwo([1,2],A,B) dann A=1, B=2 und als nächste Lösungen A=2, B=1 zurückgeben. Dies kann bei Version 1 nicht passieren,
hier würde pickTwo([1,2],A,B) dann A=1, B=2 als einzige Lösung zurückgeben.
*/

% -----------------
% remove(+L,+K1,-K)			   			   
% -----------------			     
remove(L,[],_) 		:- !,fail.					       % 	
remove(L,[L|Ls],Ls) 	:- !.						       % 
remove(L,[X|Xs],[X|Ys]) :- remove(L,Xs,Ys).	 % 	

sort([],[])   :-!.
sort([X],[X]) :-!.
sort([X|Xs],R) :- sort(Xs,Zs),insert(X,Zs,R).

insert(X,[],[X]) :-!.
insert(X,[Y|Ys],[X,Y|Ys]) :- XX is X*X, YY is Y*Y, XX =< YY,!.    % Ignoriere negation, z.B. [-1,2,-3] ist sortiert. 
insert(X,[Y|Ys],[Y,X|Ys]).

% Einige Testf�lle
% ------------------			      	
solve([]).
test(1) :- solve([[]]).
test(2) :- solve([[1],[-1,2],[2]]).
test(3) :- solve([[-2,1,3],[-2,3],[1,2],[-2,1],[-1,2]]).		
test(4) :- solve([[-1,2,3],[-2,3],[-2,1],[-1,2],[-3,-1],[-3]]).	
test(5) :- solve([[-1,2,3],[-2,3],[-2,-1],[-1,2],[-3,1],[3]]).	      		
test(6) :- solve([[-1,2,3],[-2,-3],[1,-3],[2,3],[1,-2,3],[-1,-2,3]]).	 

aufgabe(3) :- solve([[-1,2,-3],[2,3],[-3],[-1,2],[1,-2]]). 
aufgabe(4) :- solve([[-1,2,-3],[2,3],[-3],[-1,2],[1,-2]]).

aufgabe1 :- solve([[1,-3],[-1,2],[1,4],[-2,4],[-1,-4],[3,-4]]).
