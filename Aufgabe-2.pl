% 2.a)
% ersetze(3,5,[1,5,7,3,9,3,3],R). -> yes. R / [1,5,7,5,9,5,5]
ersetze(X, Y, [], []).
ersetze(X, Y, [X|Xs], [Y|Ys]) :- ersetze(X, Y, Xs, Ys), !.
ersetze(X, Y, [Z|Xs], [Z|Ys]) :- ersetze(X, Y, Xs, Ys), !.

% 2.b)
% remDups([1,5,1,7,3,9,3,3],R). -> yes. R / [5,1,7,9,3]
remDups([], []).
remDups([X|Xs], Ys) :- remDups(Xs, Ys), member(X, Ys), !.
remDups([X|Xs], [X|Ys]) :- remDups(Xs, Ys).

% 2.c)
% vereinigung([1,3,5,7],[7,4,9,3],R). -> yes. R / [1,5,7,4,9,3]
vereinigung([], Ys, Ys).
vereinigung([X|Xs], Ys, Zs) :- vereinigung(Xs, Ys, Zs), member(X, Ys), !.
vereinigung([X|Xs], Ys, [X|Zs]) :- vereinigung(Xs, Ys, Zs).

% 2.d)
% diff([1,3,5,7],[7,4,9,3],R). -> yes. R / [1,5]
diff([], Ys, []).
diff([X|Xs], Ys, [X|Zs]) :- diff(Xs, Ys, Zs), not(member(X, Ys)), !.
diff([X|Xs], Ys, Zs) :- diff(Xs, Ys, Zs).