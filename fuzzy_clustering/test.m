[A,B] = meshgrid(linspace(-1,1),linspace(-1,1)) ;

X = A;
Y = B;
Z = sin(A);

surf(X,Y,Z)