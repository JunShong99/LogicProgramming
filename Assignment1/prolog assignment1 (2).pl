
%Task 1
fatherOf(abdul,nur_ain).
fatherOf(abdul,mokhtar).

fatherOf(dollah,fatimah).
fatherOf(dollah,kasim).
fatherOf(dollah,abu).
fatherOf(mokhtar,aisyah).
fatherOf(mokhtar,mamat).

motherOf(nur_ain,fatimah).
motherOf(nur_ain,kasim).
motherOf(nur_ain,abu).
motherOf(emey,aisyah).
motherOf(emey,mamat).

%Task 2
parent(X,Y):-fatherOf(X,Y);motherOf(X,Y).

%Task 3
sibling(X,Y):-parent(A,X),parent(A,Y),X\==Y.

%Task 4
grandfather(X,Y):-parent(W,Y),parent(X,W).

%Task 5
cousin(X,Y):-parent(A,X),parent(B,Y),sibling(A,B).






