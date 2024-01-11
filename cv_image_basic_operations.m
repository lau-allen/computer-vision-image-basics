%===================================================
% Image Basic Operations
% Allen Lau 
%===================================================

% ---------------- Question 1 ------------------------
% Read in a color image C1(x,y) = (R(x,y), G(x,y), B(x,y))
% in Windows BMP format, and display it.

% Define path to image
img = './images/IDPicture.bmp';
% Read img 
C1 = imread(img);
% Define row, column, and channel vars 
[ROWS, COLS, CHANNELS] = size(C1);
% Display the image 
imshow(C1);
title('Figure 1: ID Picture');

%%

% ---------------- Question 2 ------------------------
% Display the images of the three color components, 
% R(x,y), G(x,y) and B(x,y), separately. You should 
% display three black-white-like images.

% create blank image for R
% Use uint8 to convert double to unsigned 8-bit integers
CR1 = uint8(zeros(ROWS,COLS,CHANNELS));
% populate blank image with red band values in all bands
for band = 1 : CHANNELS
    CR1(:,:,band) = (C1(:,:,1));
end

% create blank image for G
CG1 = uint8(zeros(ROWS,COLS,CHANNELS));
% populate blank image with green band values in all bands
for band = 1 : CHANNELS
    CG1(:,:,band) = (C1(:,:,2));
end

% create blank image for B 
CB1 =uint8(zeros(ROWS, COLS, CHANNELS));
% populate blank image with blue band values in all bands
for band = 1 : CHANNELS
    CB1(:,:,band) = (C1(:,:,3));
end

% define figure 
No1 = figure;

% concatenate images together 
disimg = [C1, CR1; CG1, CB1];

%display figure
image(disimg);
title('Figure 2: ID Picture and 3 Color Components')

%%

% ---------------- Question 3 ------------------------
% Generate an intensity image I(x,y) and display it. 
% You should use the equation I = 0.299R + 0.587G + 0.114B 
% (the NTSC standard for luminance) and tell us what are 
% the differences between the intensity image thus generated 
% from the one generated using a simple average of the R, G 
% and B components. Please use an algorithm to show the 
% differences instead by just observing the images by your eyes.

% Intensity Image - Calculated via Simple Average 
% convert color image to grayscale (intensity image)
% by summing the R,G,B values for each pixel and dividing by 3
I1_avg = uint8(round(sum(C1,3)/3));

% display the intensity image to console 
%disp(I1_avg);

% define figure 
No2 = figure; 
% display figure
colormap("gray");
image(I1_avg);
title('Figure 3: Intensity Image; Average of R, G, B Components');
colorbar;

% Intensity Image - Calculated using NTSC Luminance Standard
I1_ntsc = 0.299*C1(:,:,1) + 0.587*C1(:,:,2) + 0.114*C1(:,:,3);

% define figure and display 
No3 = figure; 
colormap("gray");
image(I1_ntsc);
title('Figure 4: Intensity Image; NTSC Luminance Standard');
colorbar;

% plot histograms of the intensity images to review differences 
No4 = figure; 
histogram(I1_avg)
title('Figure 5: Intensity Image, Average Distribution')
xlabel('Intensity Value')
ylabel('Frequency')

No5 = figure;
histogram(I1_ntsc)
title('Figure 6: Intensity Image, NTSC Luminance Standard Distribution')
xlabel('Intensity Value')
ylabel('Frequency')

%%

% ---------------- Question 4 ------------------------
% The original intensity image should have 256 gray levels.
% Please uniformly quantize this image into K levels 
% (with K=4, 16, 32, 64).  As an example,  when K=2,  
% pixels whose values are below 128 are turned to 0,  
% otherwise to 255.  Display the four quantized images with 
% four different K levels,  and tell us how the images still 
% look like or different from the original ones, and where 
% you cannot see any differences.

% function quantized_img = uniform_quantization(K,img), where K = levels and img =
% original image to be quantized

% K=4 
% call function defining K and img 
k4_img = uniform_quantization(4,I1_avg);
% display quantized image 
No6 = figure;
subplot(2,2,1)
image(k4_img)
colormap('gray')
title('K=4')

% K=16
% call function defining K and img 
k16_img = uniform_quantization(16,I1_avg);
% display quantized image 
subplot(2,2,2)
image(k16_img)
colormap('gray')
title('K=16')

% K=32
% call function defining K and img 
k32_img = uniform_quantization(32,I1_avg);
% display quantized image
subplot(2,2,3)
image(k32_img)
colormap('gray')
title('K=32')

% K=64
% call function defining K and img 
k64_img = uniform_quantization(64,I1_avg);
% display quantized image
subplot(2,2,4)
image(k64_img)
colormap('gray')
title('K=64')

% subplot display settings
s_title = sgtitle('Figure 7: Uniformly Quantized Intensity Images');
set(s_title, 'FontWeight', 'bold');

%%

% ---------------- Question 5 ------------------------
% Quantize  the original three-band color image C1(x,y) into 
% K level color images CK(x,y)= (R'(x,y), G'(x,y), B'(x,y)) 
% (with uniform intervals) , and display them. You may choose 
% K=2 and 4 (for each band).  Do they have any advantages 
% in viewing and/or in computer processing (e.g., transmission 
% or segmentation)?

% function quantized_img = uniform_quantization(K,img), where K = levels and img =
% original image to be quantized

% K=2
% call function defining K and img 
k2_C1 = uniform_quantization(2,C1);
% display quantized image
No7 = figure;
subplot(1,2,1)
image(k2_C1)
title('K=2')

% K=4
% call function defining K and img 
k4_C1 = uniform_quantization(4,C1);
% display quantized image
subplot(1,2,2)
image(k4_C1)
title('K=4')

% subplot display settings
s_title2 = sgtitle('Figure 8: Uniformly Quantized Color Images');
set(s_title2, 'FontWeight', 'bold')

%%

% ---------------- Question 6 ------------------------
% Quantize  the original three-band color image C1(x,y) 
% into a color image CL(x,y)= (R'(x,y), G'(x,y), B'(x,y)) 
% (with a logarithmic function) , and display it. You may choose  
% a function  I’ =C ln (I+1) ( for each band), where I is the 
% original value (0~255) , I’ is the quantized value,  and C 
% is a constant to scale I’  into (0~255), and ln is the natural 
% logarithmic function.  Please describe how you find the best C 
% value so for an input in the range of 0-255, the output range 
% is still 0 – 255. Note that when I = 0, I’ = 0 too

% calculate constant C such that I' is scaled into O~255
% setting I' = 255, I = 255; when I = 0, equation simplifies to C*ln(1)=C*0
i_prime = 255;
i_original = 255;
C = i_prime/(log(i_original + 1)); % C = 45.9859
% disp(C)

% call function to generate log quantization 
log_img = log_quantization(C,C1);
% display
No9 = figure;
image(log_img)
title('Figure 9: Logarithmic Quantization I’=Cln(I+1) of Color Image')

%%

% ---------------- FUNCTIONS ------------------------

% --- uniform_quantization --- 
% parameters: K = levels, img = original image to be quantized
% output: quantized_img = resultant uniformly quantized image 

% Logic uses integer division to map a pixel intensity value to a specific 
% quantization level. The number to integer divide by is equal to 256/K. 
% So for each pixel in the image, we do pixel_intensity integer division by
% 256/K. Then we use that value to retrieve its corresponding mapped
% intensity value from the dictionary. 
function quantized_img = uniform_quantization(K,img)
    % retrieve the row, col, and channel info of the original img 
    [ROWS, COLS, CHANNELS] = size(img);

    % create a new empty image
    quantized_img = uint8(zeros(ROWS,COLS,CHANNELS));

    % define keys for dictionary to map to intensity value
    % keys are from 0 to K-1 based on int division logic for quantization
    keys = 0:K-1;

    % define dictionary values mapped to keys for uniform quantization
    step = 256/K;
    values = 0:step:255;

    % create dictionary 
    dict = dictionary(keys,values);

    % loop through the rows, cols, and channels
    for band = 1:CHANNELS
        for i = 1:ROWS
            for j = 1:COLS
                % use integer division to determine which level to map
                % pixel to
                i_value = dict(idivide(img(i,j,band),step));
                % set the specific pixel to that intensity value, retrieved
                % from the dictionary 
                quantized_img(i,j,band) = i_value;
            end
        end
    end 
end 

% --- log_quantization --- 
% parameters: C = scaling constant, img = original image to be quantized
% output: quantized_img = resultant log (I'=Cln(I+1)) quantized image 

function quantized_img = log_quantization(C,img)
    % retrieve the row, col, and channel info of the original img 
    [ROWS, COLS, CHANNELS] = size(img);

    % create a new empty image
    quantized_img = uint8(zeros(ROWS,COLS,CHANNELS));

    % loop through the rows, cols, and channels
    for band = 1:CHANNELS
        for i = 1:ROWS
            for j = 1:COLS
                % obtain i from original image, and convert to double as a
                % requirement to using log() function 
                i_original = double(img(i,j,band)+1);
                % calculate the new intensity value based on I'=Cln(I+1)
                i_prime = C*log(i_original);
                % set pixel to I'
                quantized_img(i,j,band)=i_prime;
            end
        end
    end 

end