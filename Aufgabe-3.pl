% 3.a)
% mirror(node(node(blatt(2),blatt(4)),blatt(7)), R). -> yes. R / node(blatt(7), node(blatt(4), blatt(2)))
mirror(blatt(X), blatt(X)).
mirror(node(X1, Y1), node(Y2, X2)) :- mirror(X1, X2), mirror(Y1, Y2).

% 3.b)
% inorder(node(node(blatt(2),blatt(4)),blatt(7)), R). -> yes. R / [2,4,7]
inorder(blatt(X), [X]).
inorder(node(X, Y),  Z) :- inorder(X, Z1), inorder(Y, Z2), append(Z1, Z2, Z).
