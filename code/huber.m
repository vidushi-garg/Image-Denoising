function gradient = huber(alpha,gamma,X,Y)

%%calculating summation of potential function
top = circshift(X,[1 0]);
bottom= circshift(X,[-1 0]);
left = circshift(X,[0 1]);
right = circshift(X,[0 -1]);

if(abs(X-top)<=gamma)
    sumTop= X - top;
else
    if((X-top) < 0)
        sumTop = -gamma;
    else
        sumTop = gamma;
    end
end

if(abs(X-bottom)<=gamma)
    sumBottom= X - bottom;
else
    if((X-bottom) < 0)
        sumBottom = -gamma;
    else
        sumBottom = gamma;
    end
end

if(abs(X-left)<=gamma)
    sumLeft= X - left;
else
    if((X-left) < 0)
        sumLeft = -gamma;
    else
        sumLeft = gamma;
    end
end

if(abs(X-right)<=gamma)
    sumRight= X - right;
else
    if((X-right) < 0)
        sumRight = -gamma;
    else
        sumRight = gamma;
    end
end

summation = sumTop + sumBottom + sumLeft + sumRight;
%%reweighting prior part
s = alpha .* summation;

%%Solving equation => (1-alpha)*2*|(X-Y)|+2*alpha*sum(neighbours) == 0

gradient = (1-alpha)*2*abs((X-Y)) + s;
end




