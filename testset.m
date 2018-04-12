%test set
X=[Widths.lon];
Y = [Widths.lat];
I = randi (length(X),500000,1);
X=X(I)';
Y=Y(I)';
