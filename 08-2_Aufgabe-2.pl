% 2.1)
/*
Wenn Klausel 1 Klausel 2 subsumiert, dann enthält Klausel 2 jedes Literal in Klausel 1. 
Das heißt, wenn Klausel 1 für eine bestimmte Belegung wahr ist, dann ist Klausel 2 automatisch auch für diese Belegung wahr.
Damit eine Menge von Klauseln erfüllbar ist, muss es eine Belegung geben, die jede Klausel der Menge erfüllt. 
Daher kann Klausel 2 aus der Menge entfernt werden, wenn sie durch Klausel 1 subsumiert wird, 
da Klausel 2 bereits durch Klausel 1 abgedeckt ist und nicht benötigt wird, um die Menge der Klauseln zu erfüllen.
*/

% 2.2)
% subsumes([-2,-3,-1,-2],[-1,-6,-2,-3,42]). -> yes
% Annahme: es wird keine leere Klausel übergeben.
subsumes([], Ys).
subsumes([X|Xs], Ys) :- member(X, Ys), subsumes(Xs, Ys).
subsumes([X|Xs], Ys) :- !, fail.

% 2.3)
% someoneSubsumes([[1,-2],[-1,-2]],[-2,-3,-1,-2]). -> yes
someoneSubsumes([], Ys) :- fail.
someoneSubsumes([X|Xs], Ys) :- subsumes(X, Ys), !.
someoneSubsumes([X|Xs], Ys) :- someoneSubsumes(Xs, Ys).

% 2.4)
% removeSubsumed([1,-3],[[2,-3,1],[3,1],[2,3,1],[3,-1],[-3,2,1]],X). -> X = [[3,1],[2,3,1],[3,-1]]
removeSubsumed(X, [], []).
removeSubsumed(X, [Y|Ys], Zs) :- subsumes(X, Y), removeSubsumed(X, Ys, Zs), !.
removeSubsumed(X, [Y|Ys], [Y|Zs]) :- removeSubsumed(X, Ys, Zs), !.
