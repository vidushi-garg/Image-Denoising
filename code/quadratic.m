function gradient = quadratic(alpha,X,Y)

sigma = 1;
%%Calculating the Neighbours
top = circshift(X,[1 0]);
bottom= circshift(X,[-1 0]);
left = circshift(X,[0 1]);
right = circshift(X,[0 -1]);

%%Differentiation of |u|^2 = 2*|u|
summation = abs(X-top) + abs(X-bottom) + abs(X-left) + abs(X-right);
%%Prior
s = (2*alpha) .* summation;
%%Solving equation => (1-alpha)*2*|(X-Y)|+2*alpha*sum(neighbours)
gradient = (1-alpha)*2*(abs(X-Y))/(sigma^2) +s;
end



