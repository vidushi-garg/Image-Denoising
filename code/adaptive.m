function gradient = adaptive(gamma,alpha,X,Y)
sigma = 1;

%%Calculating differentiated value of Discontinuity-Adaptive Prior

%Calculating neighbours
top = circshift(X,[1 0]);
bottom= circshift(X,[-1 0]);
left = circshift(X,[0 1]);
right = circshift(X,[0 -1]);

a = abs(X-top);
top_summation = a ./ ((a ./  gamma) + 1);
b = abs(X-bottom);
bottom_summation = b ./ ((b ./  gamma) + 1);
c = abs(X-left);
left_summation = c ./ ((c ./  gamma) + 1);
d = abs(X-right);
right_summation = d ./ ((d ./  gamma) + 1);

%%Calculating summation of differentiated prior
summation = top_summation + bottom_summation + left_summation + right_summation;

s = alpha .* summation;
%%Solving equation => (1-alpha)*2*|(X-Y)|*(1/(sigma^2))+alpha*sum(neighbours) == 0
gradient = (1-alpha)*2*(abs(X-Y))*(1/(sigma^2)) + s;

end


