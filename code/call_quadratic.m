function updated_image = call_quadratic(alpha,Y,variable,step_size)

sigma = 1;
%%Initially x_0 is set to the noisy image
x_0 = Y;
iteration = 0;

%%First new image using gradient
x_1 = x_0 - step_size * quadratic(alpha,x_0,Y);
x_1= abs(x_1);

%%Calculating only the first value of objective function i.e.log P(x|y)
%%Calculating neighbours
top = circshift(x_0,[1 0]);
bottom= circshift(x_0,[-1 0]);
left = circshift(x_0,[0 1]);
right = circshift(x_0,[0 -1]);

%%Prior
summation = (x_0-top).^2 + (x_0-bottom).^2 + (x_0-left).^2 + (x_0-right).^2;

%%Objective Function
old_F = (1-alpha)*((Y-x_0).^2)/(sigma^2) + alpha*summation;
old_F = sum(sum(old_F));
new_F = old_F;

x_0 = x_1;
while iteration < variable
    old_F = new_F;
    iteration =iteration + 1;
    %%Calculating new image using gradient
    x_1 = x_0 - step_size * quadratic(alpha,x_0,Y);
    x_1= abs(x_1);
    %%Calculating the value of objective function i.e.log P(x|y)
    top = circshift(x_0,[1 0]);
    bottom= circshift(x_0,[-1 0]);
    left = circshift(x_0,[0 1]);
    right = circshift(x_0,[0 -1]);

    summation = (x_0-top).^2 + (x_0-bottom).^2 + (x_0-left).^2 + (x_0-right).^2;

    new_F = (1-alpha)*((Y-x_0).^2)/(sigma^2) + alpha*summation;

    new_F = sum(sum(new_F));

    %%Updating step size
    if new_F < old_F
        step_size = step_size *1.1;

    else
        step_size = step_size * 0.5;
    end
    %%Previous image is set to current image
    x_0 = x_1;


end

%%Returning the value of denoised image
updated_image = x_0;
