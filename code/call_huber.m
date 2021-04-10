function updated_image = call_huber(alpha,gamma,K,variable)

si = size(K);
step_size = zeros(si(1,1),si(1,2)) + 0.1;
x_0 = K;
iteration = 0;

%%First Gradient
x_1 = x_0 - step_size .* huber(alpha,gamma,x_0,K);
x_1= abs(x_1);
%%Calculating the value of log P(x|y)
top = circshift(x_0,[1 0]);
bottom= circshift(x_0,[-1 0]);
left = circshift(x_0,[0 1]);
right = circshift(x_0,[0 -1]);

% summation for huber
part1top = (abs(x_0 -top)<= gamma);
part1top = part1top .* abs(x_0-top);
part2top = abs(x_0 -top)> gamma;
part2top = part2top .* abs(x_0-top);
part1top = 0.5 * abs(part1top) .^ 2;
part2top = gamma * abs(part2top) - 0.5 * gamma^2 ;
huberTop = part1top + part2top;
part1bottom = abs(x_0 -bottom)<= gamma;
part1bottom = part1bottom .* abs(x_0-bottom);
part2bottom = abs(x_0 -bottom)> gamma;
part2bottom = part2bottom .* abs(x_0 -bottom);
part1bottom = 0.5 * abs(part1bottom) .^ 2;
part2bottom = gamma * abs(part2bottom) - 0.5 * gamma^2 ;
huberBottom = part1bottom + part2bottom;
part1left = abs(x_0 -left)<= gamma;
part1left = part1left .* abs(x_0 -left);
part2left = abs(x_0 -left)> gamma;
part2left = part2left .* abs(x_0 -left);
part1left = 0.5 * abs(part1left) .^ 2;
part2left = gamma * abs(part2left) - 0.5 * gamma^2 ;
huberLeft = part1left + part2left;
part1right = abs(x_0 -right)<= gamma;
part1right = part1right .* abs(x_0 -right);
part2right = abs(x_0 -right)> gamma;
part2right = part2right .* abs(x_0 -right);
part1right = 0.5 * abs(part1right) .^ 2;
part2right = gamma * abs(part2right) - 0.5 * gamma^2 ;
huberRight = part1right + part2right;
summationHuber = huberTop + huberBottom + huberLeft + huberRight ;

%%calculating Objective function value using Huber prior 
old_F = (1-alpha)*((K-x_0).^2) + alpha*summationHuber;
new_F = old_F;
x_0 = x_1;
while (iteration<variable)
    old_F = new_F;

    iteration =iteration + 1;
    
    %Updating Image using gradient
    x_1 = x_0 - step_size .* huber(alpha,gamma,x_0,K);
    x_1 = abs(x_1);
    
    %Calculating neighbours
    top = circshift(x_0,[1 0]);
    bottom= circshift(x_0,[-1 0]);
    left = circshift(x_0,[0 1]);
    right = circshift(x_0,[0 -1]);

   % summation for huber
    part1top = (abs(x_0 -top)<= gamma);
    part1top = part1top .* abs(x_0-top);
    part2top = abs(x_0 -top)> gamma;
    part2top = part2top .* abs(x_0-top);
    part1top = 0.5 * abs(part1top) .^ 2;
    part2top = gamma * abs(part2top) - 0.5 * gamma^2 ;
    huberTop = part1top + part2top;
    part1bottom = abs(x_0 -bottom)<= gamma;
    part1bottom = part1bottom .* abs(x_0-bottom);
    part2bottom = abs(x_0 -bottom)> gamma;
    part2bottom = part2bottom .* abs(x_0 -bottom);
    part1bottom = 0.5 * abs(part1bottom) .^ 2;
    part2bottom = gamma * abs(part2bottom) - 0.5 * gamma^2 ;
    huberBottom = part1bottom + part2bottom;
    part1left = abs(x_0 -left)<= gamma;
    part1left = part1left .* abs(x_0 -left);
    part2left = abs(x_0 -left)> gamma;
    part2left = part2left .* abs(x_0 -left);
    part1left = 0.5 * abs(part1left) .^ 2;
    part2left = gamma * abs(part2left) - 0.5 * gamma^2 ;
    huberLeft = part1left + part2left;
    part1right = abs(x_0 -right)<= gamma;
    part1right = part1right .* abs(x_0 -right);
    part2right = abs(x_0 -right)> gamma;
    part2right = part2right .* abs(x_0 -right);
    part1right = 0.5 * abs(part1right) .^ 2;
    part2right = gamma * abs(part2right) - 0.5 * gamma^2 ;
    huberRight = part1right + part2right;
    summationHuber = huberTop + huberBottom + huberLeft + huberRight ;

    % Calculating objective function value using huber prior
    new_F = (1-alpha)*((K-x_0).^2) + alpha*summationHuber;

    %%changing step-size based on change in objective function values
    m = new_F<old_F;
    n = new_F>=old_F;
    x_0 = m .* x_1 + n .* x_0;
    m = m .* step_size * 1.1;
    n = n .* step_size * 0.5;
    step_size = m+n;

end
%%final denoised image
updated_image=x_0;

  