% 1.1)
% find(3,[1,4,5,3,2,3],N). -> yes. N / 4 und find(6,[1,4,3,5,2,3],N). -> yes. N / 0
find(_, [], 0).
find(X, [X|Xs], 1).
find(X, [_|Xs], N) :- find(X, Xs, N1), N1 > 0, N is N1 + 1, !.
find(X, [_|Xs], N) :- find(X, Xs, N1), N1 = 0, N is N1, !.

% 1.2)
% sumAll([1,3,-7],R). -> yes. R / -3
sumAll([], 0).
sumAll([X|Xs], R) :- sumAll(Xs, R1), R is R1 + X.

% 1.3)
% mapSquare([1,3,-7],R). -> yes. R / [1,9,49]
mapSquare([], []).
mapSquare([X|Xs], [Y|Ys]) :- mapSquare(Xs, Ys), Y is X * X.

% 1.4)
% filterPos([1,-2,-3,3,-7],R). -> yes. R / [1,3]
filterPos([], []).
filterPos([X|Xs], [X|Ys]) :- filterPos(Xs, Ys), X >= 0.
filterPos([X|Xs], Ys) :- filterPos(Xs, Ys), X < 0.
