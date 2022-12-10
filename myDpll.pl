/* Davis Putnam Resolution. H.P.Gumm, 2011.
   Repr�sentation: 
   Literale: a, ~a, b, ~b, ... oder auch 1,2,3,~1,~2,~3, oder a1, ~b1, b2, ...
   Klauseln : Listen von Literalen, z.B.: [a,~b,c]
   Klauselmengen : Listen von Klauseln.  [[a,~b,c],[~c,b],[~a,b]]
   Environment/Belegung repr�sentiert durch die Menge/Liste der Literale, die wahr sind */

    :- op(100,fx,'~').        %     ~ als pr�fix-Operator erkl�ren
    
/*  ============================ Die Hauptroutine: solve  ================== */

   solve(Cs,Env) :- resolve(Cs,[],Env),!,write(" L�sung: "),write(Env),nl.
   solve(Cs,_)   :- write(" unerf�llbar "),nl.
        
% resolve(Klauseln,partielleBelegung,Belegung)
   resolve([],Env,Env)   :-!.  				 							     % Env gefunden 
   resolve(Cs,_,_)       :- member([],Cs),!,fail.	 	     % leere Klausel vorhanden : unerf�llbar.
   resolve(Cs,Env,Env1)  :- chooseLit(Cs,L),             % W�hle ein Literal L aus
                            update(L,Env,EnvNeu),        % versuche L in Env aufzunehmen
			    									simpClauses(L,Cs,Cs1),       % Vereinfache die Klauselmenge wg. L=true
 			    									resolve(Cs1,EnvNeu,Env1).    % Mach mit dem neuen Env weiter 
 			    
   chooseLit(Cs,Lit) 		 	:- member([Lit],Cs),!.	% Falls Unit-Clause vorhanden, w�hle deren Literal 
   chooseLit([C|_],Lit) 	:- member(Lit,C).		 		% Ansonsten irgendein Literal der ersten Klausel
   
% update(Lit,Env,EnvNeu)
    update(Lit,Env,_)   :- negate(Lit,NL), member(NL,Env),!,fail. 
    update(Lit,Env,[Lit|Env]).     

 % F�r Lit=True : 	 - entferne alle Klauseln mit Lit und E
 %                   - entferne ~Lit aus allen �brigen Klauseln  
   simpClauses(Lit,[],[])                :- !.		 	      						% keine Klausel �brig - nichts zu tun
   simpClauses(Lit,[C|Cs],Cs1)           :- member(Lit,C), !,         % Literal kommt in erster Klausel C vor
  				            											simpClauses(Lit,Cs,Cs1).  % entferne C und mache mit Rest weiter   				  				
   simpClauses(Lit,[C|Cs],[C1|Cs1])      :- delNeg(Lit,C,C1),!,       % Lit kommt in erster Klausel negiert vor
  				                                  simpClauses(Lit,Cs,Cs1).  % entferne Lit aus C und mit Rest weiter 
   simpClauses(Lit,[Cl|Cls],[Cl|ClsNeu]) :- simpClauses(Lit,Cls,ClsNeu).      
   
% verk�rze Klauseln, in denen Lit negativ vorkommt
    delNeg(Lit,Clause,Clause1) :- negate(Lit,NL), delmem(NL,Clause,Clause1),!.
    delNeg(_,Clause,Clause).
    
% Negiere ein Literal 
   negate(~L,L) :- !.
   negate(L,~L).
   
% Entferne Element E aus Liste L:
% Variante 1
%   delmem(_,[],[]) :- !,fail.
%   delmem(A,[A|As],As) :- !.
%   delmem(A,[B|Bs],[B|Rs]) :- delmem(A,Bs,Rs).

% Variante 2
   delmem(A,[A|As],Bs) :- delmem(A,As,Bs).
	 delmem(A,[B|Bs],[B|Rs]) :- delmem(A,Bs,Rs).
/*
Aufgabe 4.3)
Der Code funktioniert für die gegebenen Testfälle gleich, egal welche Variante für delem genutzt wird. 
Die zweite Variante iteriert über die komplette übergebene Klausel und versucht das Literal zu entfernen,
dieses kann aber nur einmal in der Klausel enthalten sein. Deshalb ist die erste Variante effizienter,
da die Iteration abgebrochen wird sobald das Literal gefunden wurde. Außerdem enthält sie eine Absicherung
für den Fall, das eine leere Klausel übergeben wird, was nicht passieren darf.
*/
 
  /* --------------------- Testbeispiele ------------------------------*/

  test(Cs,Env) :- clauses(Cs), write("Klauseln: "),write(Cs),nl,solve(Cs,Env),nl.

  % durch Backtracking von "clauses(Cs)" werden alle folgenden Klauseln getestet:  
  % Untersuchen Sie auch das "output"-Fenster, in das "write(...)" schreibt. 
  
  clauses([[b,c],[c,d,~b],[~d,c],[b]]).

  clauses([[~b,~c],[c,d,~b],[~d,c],[b]]).

  clauses([[1,4],[1,3,-8],[1,8,11],[2,11],[~7,~3,9],[~7,8,~9],[7,8,~10],
             [7,10,~11],[~3,~7,8],[3,7,~1],[~3,~4,7],[3,~7],[~3,7]]).

  clauses([[p,q,s],[~p,r,~t],[r, s],[~r,q,~p],[~s,p],[~p,~q,s,~r],[p,~q,s],[~r,~s],[~p,~s]]).


 taubentest(Env) :-   solve([[11,12],[21,22],[31,32],        % jede Taube in einem Schlag
                             [~11,~21],[~11,~31],[~21,~31],  % keine zwei im selben Schlag
                             [~12,~22],[~12,~32],[~22,~32]   %       -- " --
                            ],
                            Env).

                    