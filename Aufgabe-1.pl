% 1.1)
% noDups([2,4,7]) -> true
% noDups([2,4,7,4]) -> no.
noDups([]).
noDups([X|Xs]) :- member(X, Xs), !, fail.
noDups([X|Xs]) :- noDups(Xs).

% 1.2)
notMember(X,Ys) :- member(X,Ys), !, fail.
notMember(X,Ys).

/*
Tests:
notMember(0,[]) -> true
not(not(notMember(0,[]))) -> true
notMember(0,[0]) -> no
not(not(notMember(0,[0]))) -> no
notMember(0,[1]) -> true
not(not(notMember(0,[1]))) -> true

Das notMember-Prädikat ist in zwei Klauseln definiert. Die erste Klausel besagt, dass notMember(X,Ys) wahr ist, wenn member(X,Ys) wahr ist. 
Durch cut und fail wird dann aber garantiert, dass die erste Klausel nie erfolgreich sein kann, wodurch die Negation von member(X, Ys) entsteht. 
Die zweite Klausel besagt, dass notMember(X,Ys) immer wahr ist, unabhängig von den Werten von X und Ys.

Durch die Negation des notMember-Prädikat mit dem not-Operator, wird das resultierende goal member(X,Ys) sein, was die Negation des ursprünglichen goals ist. 
Wenn dieses goal dann wieder mit dem not-Operator negiert wird, ist das resultierende goal notMember(X,Ys), was damm wieder dem ursprünglichen goal entspricht.

Deshalb hat die doppelte Negation eines goals stets das gleiche Verhalten wie das Orginalgoal.
/*
