function show_image(value,image_title,number)

%%Code taken from the given Assignment Pdf
myNumOfColors = 200;
myColorScale =  [(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)',(0:1/(myNumOfColors-1):1)'];
figure(number);
imagesc (single (value));
title(image_title)
colormap (myColorScale);
colormap jet;
daspect ([1 1 1]);
axis tight;
colorbar



