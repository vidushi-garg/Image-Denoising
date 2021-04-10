function updated_image = call_adaptive(alpha,gamma,Y,iterative_value)

sigma = 1;

%%Different step size for each pixel
si = size(Y);
%Initially step size is step to 0.1
step_size = zeros(si(1,1),si(1,2)) + 0.1;

%Initial image is set to given Noisy image
x_0 = Y;
iteration = 0;

%%First Gradient
x_1 = abs(x_0 - step_size .* adaptive(gamma,alpha,x_0,Y));

%%Calculating the value of log P(x|y)

%Calculating Neighbours
top = circshift(x_0,[1 0]);
bottom= circshift(x_0,[-1 0]);
left = circshift(x_0,[0 1]);
right = circshift(x_0,[0 -1]);

%Calculating value of Discontinuity-Adaptive Prior
a = abs(x_0-top);
top_summation = gamma * a - (gamma^2)*log(1+ (a ./ gamma));
b = abs(x_0-bottom);
bottom_summation = gamma * b - (gamma^2)*log(1+ (b ./ gamma));
c = abs(x_0-left);
left_summation = gamma * c - (gamma^2)*log(1+ (c ./ gamma));
d = abs(x_0-right);
right_summation = gamma * d - (gamma^2)*log(1+ (d ./ gamma));

%Summative of potential function
summation = top_summation + bottom_summation + left_summation + right_summation;

%Objective function
old_F = (1-alpha)*((Y-x_0).^2)*(1/(sigma^2)) + alpha*summation;
new_F = old_F;

x_0 = x_1;
while (iteration<iterative_value)

    old_F = new_F;

    iteration =iteration + 1;
    %Updating image using gradient
    x_1 = abs(x_0 - step_size .* adaptive(gamma,alpha,x_0,Y));
    
    %%Calculating Prior
    
    %Calculating neighbours
    top = circshift(x_0,[1 0]);
    bottom= circshift(x_0,[-1 0]);
    left = circshift(x_0,[0 1]);
    right = circshift(x_0,[0 -1]);

    a = abs(x_0-top);
    top_summation = gamma * a - (gamma^2)*log(1+ (a ./ gamma));
    b = abs(x_0-bottom);
    bottom_summation = gamma * b - (gamma^2)*log(1+ (b ./ gamma));
    c = abs(x_0-left);
    left_summation = gamma * c - (gamma^2)*log(1+ (c ./ gamma));
    d = abs(x_0-right);
    right_summation = gamma * d - (gamma^2)*log(1+ (d ./ gamma));

    %Summation of Potential Function
    summation = top_summation + bottom_summation + left_summation + right_summation;

    %Updated value of Objective Function
    new_F = (1-alpha)*((Y-x_0).^2)*(1/(sigma^2)) + alpha*summation;

    %Updating the image pixels only when the better solution is found
    m = new_F<old_F;
    n = new_F>=old_F;
    x_0 = m .* x_1 + n .* x_0;
    %Step size is kept variable which depends on the Objective Function
    m = m .* step_size * 1.1;
    n = n .* step_size * 0.5;
    step_size = m+n;
end

%Returning the denoised image intensities
updated_image = x_0;

end