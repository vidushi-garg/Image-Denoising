data = load('..\data\assignmentImageDenoisingPhantom.mat');
mri_data = load('..\data\brainMRIslice.mat');

disp("For Phantom Image");
%%RRMSE of given noisy image(a part)
error_of_noisy_image = calculate_RRMSE(data.imageNoiseless,data.imageNoisy);
disp(["RRMSE of given noisy image = ",num2str(error_of_noisy_image)]);

%%Print RRMSE using three different priors(b part)

%%Using Quadratic prior
disp("Using Quadratic prior for phantom image");
alpha = 0.11;
iterative = 3;
step_size = 0.1;
disp(["Optimal alpha(a*) value = ",num2str(alpha)]);
quadratic_updated_image_1 = call_quadratic(alpha,data.imageNoisy,iterative,step_size);
error_of_denoised_image_1 = calculate_RRMSE(data.imageNoiseless,quadratic_updated_image_1);
disp(["RRMSE(a*)  = ",num2str(error_of_denoised_image_1)]);
updated_image_2 = call_quadratic(0.8*alpha,data.imageNoisy,iterative,step_size);
error_of_denoised_image_2 = calculate_RRMSE(data.imageNoiseless,updated_image_2);
disp(["RRMSE(0.8a*)  = ",num2str(error_of_denoised_image_2)]);
updated_image_3 = call_quadratic(1.2*alpha,data.imageNoisy,iterative,step_size);
error_of_denoised_image_3 = calculate_RRMSE(data.imageNoiseless,updated_image_3);
disp(["RRMSE(1.2a*)  = ",num2str(error_of_denoised_image_3)]);

%%Using Huber Prior
disp("Using Huber prior for phantom image");
alpha = 0.113;
gamma=1;
iterative = 4;
disp(["Optimal alpha(a*) value = ",num2str(alpha)]);
disp(["Optimal gamma(b*) value = ",num2str(gamma)]);
huber_updated_image_1 = call_huber(alpha,gamma,data.imageNoisy,iterative);
error_of_denoised_huber_phantom_image_1 = calculate_RRMSE(data.imageNoiseless,huber_updated_image_1);
disp(["RRMSE(a* b*)  = ",num2str(error_of_denoised_huber_phantom_image_1)]);
huber_phantom_updated_image_2 = call_huber(0.8*alpha,gamma,data.imageNoisy,iterative);
error_of_denoised_huber_phantom_image_2 = calculate_RRMSE(data.imageNoiseless,huber_phantom_updated_image_2);
disp(["RRMSE(0.8a* b*)  = ",num2str(error_of_denoised_huber_phantom_image_2)]);
huber_phantom_updated_image_3 = call_huber(1.2*alpha,gamma,data.imageNoisy,iterative);
error_of_denoised_huber_phantom_image_3 = calculate_RRMSE(data.imageNoiseless,huber_phantom_updated_image_3);
disp(["RRMSE(1.2a* b*)  = ",num2str(error_of_denoised_huber_phantom_image_3)]);
disp(["RRMSE(a*,0.8b*)  =","Can't be calculated because gamma should be greater than 1 and multiplying 0.8 with gamma will make it less than 1"]);
huber_phantom_updated_image_4 = call_huber(alpha,1.2*gamma,data.imageNoisy,iterative);
error_of_denoised_huber_phantom_image_4 = calculate_RRMSE(data.imageNoiseless,huber_phantom_updated_image_4);
disp(["RRMSE(a* 1.2*b*)  = ",num2str(error_of_denoised_huber_phantom_image_4)]);

%%Using Discontinuity-Adaptive Prior
disp("Using Discontinuity-Adaptive prior for phantom image");
Adaptive_alpha = 0.39;
Adaptive_gamma = 1;
Adaptive_iterative_value = 4;
disp(["Optimal alpha(a*) value = ",num2str(Adaptive_alpha)]);
disp(["Optimal gamma(b*) value = ",num2str(Adaptive_gamma)]);
adaptive_updated_image_1 = call_adaptive(Adaptive_alpha,Adaptive_gamma,data.imageNoisy,Adaptive_iterative_value);
error_of_denoised_image_1 = calculate_RRMSE(data.imageNoiseless,adaptive_updated_image_1);
disp(["RRMSE(a*,b*)  = ",num2str(error_of_denoised_image_1)]);
adaptive_updated_image_2 = call_adaptive(0.8*Adaptive_alpha,Adaptive_gamma,data.imageNoisy,Adaptive_iterative_value);
error_of_denoised_image_2 = calculate_RRMSE(data.imageNoiseless,adaptive_updated_image_2);
disp(["RRMSE(0.8a*,b*)  = ",num2str(error_of_denoised_image_2)]);
adaptive_updated_image_3 = call_adaptive(1.2*Adaptive_alpha,Adaptive_gamma,data.imageNoisy,Adaptive_iterative_value);
error_of_denoised_image_3 = calculate_RRMSE(data.imageNoiseless,adaptive_updated_image_3);
disp(["RRMSE(1.2a*,b*)  = ",num2str(error_of_denoised_image_3)]);
disp(["RRMSE(a*,0.8b*)  =","Can't be calculated because gamma should be greater than 1 and multiplying 0.8 with gamma will make it less than 1"]);
adaptive_updated_image_4 = call_adaptive(Adaptive_alpha,1.2*Adaptive_gamma,data.imageNoisy,Adaptive_iterative_value);
error_of_denoised_image_4 = calculate_RRMSE(data.imageNoiseless,adaptive_updated_image_4);
disp(["RRMSE(a*,1.2b*)  = ",num2str(error_of_denoised_image_4)]);


%%Display Images(c part)

%%Noiseless Image
show_image(data.imageNoiseless,'Given Noiseless Phantom Image',1);
%%Noisy Image
show_image(data.imageNoisy,'Given Noisy Phantom Image',2);
%%Denoised image using quadratic prior
show_image(quadratic_updated_image_1,'Denoised Image using Quadratic Prior',3);
%%Denoised image using Huber prior
show_image(huber_updated_image_1,'Denoised Image using Huber Prior',4);
%%Denoised image using Discontinuity-Adaptive prior
show_image(adaptive_updated_image_1,'Denoised Image using Discontinuity-Adaptive Prior',5);

%%Objective Function Plot vs Iteration(d part)

%%Quadratic Prior
c = load('../results/quadraticObjectivePhantom.mat');
figure('Name','Figure 6 - For Phantom Image','NumberTitle','off');
imshow(c.quadraticObjectivePhantom,[]);

%%Huber Prior
b = load('../results/ObjectiveHuberPhantom.mat');
figure('Name','Figure 7 - For Phantom Image','NumberTitle','off');
imshow(b.ObjectiveHuberPhantom,[]);

%%Discontinuity-Adaptive Prior
a = load('../results/Objective_Adaptive.mat');
figure('Name','Figure 8 - For Phantom Image','NumberTitle','off');
imshow(a.Objective_Adaptive,[]);



disp("-------------------------------------------------------------------");
%%MRI IMAGE
disp("For MRI Image");
%%RRMSE of given noisy image(a part)
error_of_noisy_image = calculate_RRMSE(mri_data.brainMRIsliceOrig,mri_data.brainMRIsliceNoisy);
disp(["RRMSE of given noisy image = ",num2str(error_of_noisy_image)]);

%%Print RRMSE using three different priors(b part)

%%Using Quadratic prior
disp("Using Quadratic prior for MRI Image");
alpha = 0.51;
iterative = 2;
step_size = 0.01;
disp(["Optimal alpha(a*) value = ",num2str(alpha)]);
quadratic_updated_image_1 = call_quadratic(alpha,mri_data.brainMRIsliceNoisy,iterative,step_size);
error_of_denoised_image_1 = calculate_RRMSE(mri_data.brainMRIsliceOrig,quadratic_updated_image_1);
disp(["RRMSE(a*)  = ",num2str(error_of_denoised_image_1)]);
updated_image_2 = call_quadratic(0.8*alpha,mri_data.brainMRIsliceNoisy,iterative,step_size);
error_of_denoised_image_2 = calculate_RRMSE(mri_data.brainMRIsliceOrig,updated_image_2);
disp(["RRMSE(0.8a*)  = ",num2str(error_of_denoised_image_2)]);
updated_image_3 = call_quadratic(1.2*alpha,mri_data.brainMRIsliceNoisy,iterative,step_size);
error_of_denoised_image_3 = calculate_RRMSE(mri_data.brainMRIsliceOrig,updated_image_3);
disp(["RRMSE(1.2a*)  = ",num2str(error_of_denoised_image_3)]);

%%Using Huber Prior
disp("Using Huber prior for MRI Image");
alpha = 0.17;
gamma=2;
iterative = 400;
disp(["Optimal alpha(a*) value = ",num2str(alpha)]);
disp(["Optimal gamma(b*) value = ",num2str(gamma)]);
huber_brain_updated_image_1 = call_huber(alpha,gamma,mri_data.brainMRIsliceNoisy,iterative);
error_of_denoised_brain_huber_image_1 = calculate_RRMSE(mri_data.brainMRIsliceOrig,huber_brain_updated_image_1);
disp(["RRMSE(a* b*)  = ",num2str(error_of_denoised_brain_huber_image_1)]);
huber_brain_updated_image_2 = call_huber(0.8*alpha,gamma,mri_data.brainMRIsliceNoisy,iterative);
huber_brain_error_of_denoised_image_2 = calculate_RRMSE(mri_data.brainMRIsliceOrig,huber_brain_updated_image_2);
disp(["RRMSE(0.8a* b*)  = ",num2str(huber_brain_error_of_denoised_image_2)]);
updated_image_3 = call_huber(1.2*alpha,gamma,mri_data.brainMRIsliceNoisy,iterative);
error_of_denoised_image_3 = calculate_RRMSE(mri_data.brainMRIsliceOrig,updated_image_3);
disp(["RRMSE(1.2a* b*)  = ",num2str(error_of_denoised_image_3)]);
updated_image_5 = call_huber(alpha,0.8*gamma,mri_data.brainMRIsliceNoisy,iterative);
error_of_denoised_image_5 = calculate_RRMSE(mri_data.brainMRIsliceOrig,updated_image_5);
disp(["RRMSE(a* 0.8b*)  = ",num2str(error_of_denoised_image_5)]);
huber_phantom_updated_image_4 = call_huber(alpha,1.2*gamma,mri_data.brainMRIsliceNoisy,iterative);
error_of_denoised_huber_phantom_image_4 = calculate_RRMSE(mri_data.brainMRIsliceOrig,huber_phantom_updated_image_4);
disp(["RRMSE(a* 1.2*b*)  = ",num2str(error_of_denoised_huber_phantom_image_4)]);

%%Using Discontinuity-Adaptive Prior
disp("Using Discontinuity-Adaptive prior for MRI Image");
Adaptive_alpha = 0.15;
Adaptive_gamma = 70000;
Adaptive_iterative_value = 4;
disp(["Optimal alpha(a*) value = ",num2str(Adaptive_alpha)]);
disp(["Optimal gamma(b*) value = ",num2str(Adaptive_gamma)]);
adaptive_updated_image_1 = call_adaptive(Adaptive_alpha,Adaptive_gamma,mri_data.brainMRIsliceNoisy,Adaptive_iterative_value);
error_of_denoised_image_1 = calculate_RRMSE(mri_data.brainMRIsliceOrig,adaptive_updated_image_1);
disp(["RRMSE(a*,b*)  = ",num2str(error_of_denoised_image_1)]);
adaptive_updated_image_2 = call_adaptive(0.8*Adaptive_alpha,Adaptive_gamma,mri_data.brainMRIsliceNoisy,Adaptive_iterative_value);
error_of_denoised_image_2 = calculate_RRMSE(mri_data.brainMRIsliceOrig,adaptive_updated_image_2);
disp(["RRMSE(0.8a*,b*)  = ",num2str(error_of_denoised_image_2)]);
adaptive_updated_image_3 = call_adaptive(1.2*Adaptive_alpha,Adaptive_gamma,mri_data.brainMRIsliceNoisy,Adaptive_iterative_value);
error_of_denoised_image_3 = calculate_RRMSE(mri_data.brainMRIsliceOrig,adaptive_updated_image_3);
disp(["RRMSE(1.2a*,b*)  = ",num2str(error_of_denoised_image_3)]);
adaptive_updated_image_4 = call_adaptive(Adaptive_alpha,0.8*Adaptive_gamma,mri_data.brainMRIsliceNoisy,Adaptive_iterative_value);
error_of_denoised_image_4 = calculate_RRMSE(mri_data.brainMRIsliceOrig,adaptive_updated_image_4);
disp(["RRMSE(a*,0.8b*)  =",num2str(error_of_denoised_image_4)]);
adaptive_updated_image_5 = call_adaptive(Adaptive_alpha,1.2*Adaptive_gamma,mri_data.brainMRIsliceNoisy,Adaptive_iterative_value);
error_of_denoised_image_5 = calculate_RRMSE(mri_data.brainMRIsliceOrig,adaptive_updated_image_5);
disp(["RRMSE(a*,1.2b*)  = ",num2str(error_of_denoised_image_5)]);


%%Display Images(c part)

%%Noiseless Image
show_image(mri_data.brainMRIsliceOrig,'Given MRI Noiseless Image',9);
%%Noisy Image
show_image(mri_data.brainMRIsliceNoisy,'Given MRI Noisy Image',10);
%%Denoised image using quadratic prior
show_image(quadratic_updated_image_1,'MRI Denoised Image using Quadratic Prior',11);
%%Denoised image using Huber prior
show_image(huber_brain_updated_image_1,'MRI Denoised Image using Huber Prior',12);
%%Denoised image using Discontinuity-Adaptive prior
show_image(adaptive_updated_image_1,'MRI Denoised Image using Discontinuity-Adaptive Prior',13);

%%Objective Function Plot vs Iteration(d part)

%%Quadratic Prior
c = load('../results/QuadraticObjectiveMRI.mat');
figure('Name','Figure 14 - For MRI Image','NumberTitle','off');
imshow(c.QuadraticObjectiveMRI,[]);

%%Huber Prior
b = load('../results/ObjectiveHuberMRI.mat');
figure('Name','Figure 15 - For MRI Image','NumberTitle','off');
imshow(b.ObjectiveHuberMRI,[]);

%%Discontinuity-Adaptive Prior
a = load('../results/Mri_objective_Adaptive.mat');
figure('Name','Figure 16 - For MRI Image','NumberTitle','off');
imshow(a.Mri_objective_Adaptive,[]);


