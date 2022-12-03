maennlich(pierre).
weiblich(monique).
maennlich(romain).
weiblich(suzanne).
maennlich(marc).
weiblich(sophie).
maennlich(alexandre).
weiblich(melanie).
maennlich(raoul).
weiblich(jeanne).
maennlich(arnaud).
maennlich(maxime).
weiblich(sonia).
maennlich(julien).
weiblich(solene).
maennlich(antonin).
maennlich(oscar).
maennlich(cesar).

kind(suzanne, pierre).
kind(suzanne, monique).
kind(marc, pierre).
kind(marc, monique).
kind(alexandre, pierre).
kind(alexandre, monique).

kind(jeanne, romain).
kind(jeanne, suzanne).
kind(arnaud, romain).
kind(arnaud, suzanne).
kind(maxime, romain).
kind(maxime, suzanne).

kind(sonia, marc).
kind(sonia, sophie).

kind(solene, alexandre).
kind(solene, melanie).
kind(antonin, alexandre).
kind(antonin, melanie).

kind(oscar, raoul).
kind(oscar, jeanne).

kind(cesar, julien).
kind(cesar, sonia).

verheiratet(pierre, monique).
verheiratet(romain, suzanne).
verheiratet(marc, sophie).
verheiratet(alexandre, melanie).
verheiratet(julien, sonia).

% P ist Grossvater von E
opa(P,E) :- maennlich(P),
						kind(X,P),
						kind(E, X). 
						
% X ist Bruder von Y						
bruder(X,Y) :- 	maennlich(X),
								kind(X, Z1),
								kind(X, Z2),
								kind(Y, Z1),
								kind(Y, Z2),
								verheiratet(Z1, Z2),
								X \= Y.

% X ist Schwester von Y
schwester(X,Y) :- weiblich(X),
									kind(X, Z1),
									kind(X, Z2),
									kind(Y, Z1),
									kind(Y, Z2),
									verheiratet(Z1, Z2),
									X \= Y.
									
% X Ist Cousin von Y									
cousin(X,Y) :- 	maennlich(X),
								opa(P, X),
								opa(P, Y),
								not(schwester(X, Y)),
								not(bruder(X, Y)),
								X \= Y.
