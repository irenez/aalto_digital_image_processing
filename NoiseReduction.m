close all
clear all

ImgOrig = imread('city_orig.png');
ImgNoise = imread('city_noise.png');
[M, N] = size(ImgOrig);
x_mid = ceil(M/2);
y_mid = ceil(N/2);
mse = ones(4);  % initialize a MeanSquareError matrix
                % use rows for the quadrants
                % and columns for the filters

% define filters
arith_filter =  ones(3)/9.;     % = fspecial('average');
gaussian_filter = fspecial('gaussian');

% ---------- top-left: impulsive noise (salt&pepper) ----------

top_left_orig = SliceArray(ImgOrig, 1, y_mid);
top_left_noise = SliceArray(ImgNoise, 1, y_mid);
mse(1,1) = 4*sum(mean((top_left_orig - top_left_noise).^2))/(M*N);
    
% applying the median filter
top_left_median = medfilt2(top_left_noise, [3 3]);
mse(1,2) = 4*sum(mean((top_left_orig - top_left_median).^2))/(M*N);
err_img_tl_median = top_left_noise - top_left_median;


% applying the arithmetic mean filter
top_left_arith = imfilter(top_left_noise, arith_filter);
mse(1,3) = 4*sum(mean((top_left_orig - top_left_arith).^2))/(M*N);
err_img_tl_arith = top_left_noise - top_left_arith;


% applying the gaussian filter
top_left_gauss = imfilter(top_left_noise, gaussian_filter);
mse(1,4) = 4*sum(mean((top_left_orig - top_left_gauss).^2))/(M*N);
err_img_tl_gauss = top_left_noise - top_left_gauss;


% ---------- top-right: impulsive and white gaussian noise --------

top_right_orig = SliceArray(ImgOrig, 1, N);
top_right_noise = SliceArray(ImgNoise, 1, N);
mse(2,1) = 4*sum(mean((top_right_orig - top_right_noise).^2))/(M*N);

% applying the median filter
top_right_median = medfilt2(top_right_noise, [3 3]);
mse(2,2) = 4*sum(mean((top_right_orig - top_right_median).^2))/(M*N);
err_img_tr_median = top_right_noise - top_right_median;


% applying the arithmetic mean filter
top_right_arith = imfilter(top_right_noise, arith_filter);
mse(2,3) = 4*sum(mean((top_right_orig - top_right_arith).^2))/(M*N);
err_img_tr_arith = top_right_noise - top_right_arith;


% applying the gaussian mean filter
top_right_gauss = imfilter(top_right_noise, gaussian_filter);
mse(2,4) = 4*sum(mean((top_right_orig - top_right_gauss).^2))/(M*N);
err_img_tr_gauss = top_right_noise - top_right_gauss;

% ---------- bottom-left --------

bottom_left_orig = SliceArray(ImgOrig, x_mid+1, y_mid);
bottom_left_noise = SliceArray(ImgNoise, x_mid+1, y_mid);
mse(3,1) = 4*sum(mean((bottom_left_orig - bottom_left_noise).^2))/(M*N);

% applying the median filter
bottom_left_median = medfilt2(bottom_left_noise, [3 3]);
mse(3,2) = 4*sum(mean((bottom_left_orig - bottom_left_median).^2))/(M*N);
err_img_bl_median = bottom_left_noise - bottom_left_median;


% applying the arithmetic mean filter
bottom_left_arith = imfilter(bottom_left_noise, arith_filter);
mse(3,3) = 4*sum(mean((bottom_left_orig - bottom_left_arith).^2))/(M*N);
err_img_bl_arith = bottom_left_noise - bottom_left_arith;


% applying the gaussian mean filter
bottom_left_gauss = imfilter(bottom_left_noise, gaussian_filter);
mse(3,4) = 4*sum(mean((bottom_left_orig - bottom_left_gauss).^2))/(M*N);
err_img_bl_gauss = bottom_left_noise - bottom_left_gauss;
    

% ---------- bottom-right: gaussian noise -------------

bottom_right_orig = SliceArray(ImgOrig, x_mid+1, M);
bottom_right_noise = SliceArray(ImgNoise, x_mid+1, M);
mse(4,1) = 4*sum(mean((bottom_right_orig - bottom_right_noise).^2))/(M*N);

% applying the median filter
bottom_right_median = medfilt2(bottom_right_noise, [3 3]);
mse(4,2) = 4*sum(mean((bottom_right_orig - bottom_right_median).^2))/(M*N);
err_img_br_median = bottom_right_noise - bottom_right_median;


% applying the arithmetic mean filter
bottom_right_arith = imfilter(bottom_right_noise, arith_filter);
mse(4,3) = 4*sum(mean((bottom_right_orig - bottom_right_arith).^2))/(M*N);
err_img_br_arith = bottom_right_noise - bottom_right_arith;


% applying the gaussian filter
bottom_right_gauss = imfilter(bottom_right_noise, gaussian_filter);
mse(4,4) = 4*sum(mean((bottom_right_orig - bottom_right_gauss).^2))/(M*N);
err_img_br_gauss = bottom_right_noise - bottom_right_gauss;


% decide the 'best filtered' image based on the min{error} value

for i = 1:4
    j = min(mse(i,2:4));
    % point to the index of the 'best' filter in the mse-matrix
    idx = find(mse(i,:) == j);
    [idx,i,j]
end

% draw the final image

finalFiltImg = ReconstructArr(top_left_gauss,top_right_gauss, bottom_left_arith, bottom_right_arith);
figure, imshow(finalFiltImg), title('filtered image') 


% === The following code draws each quadrant with the respective filters
% === with each quadrant in a different figure ===

% subplot(2,3,1), imshow(top_left_orig), title('original image')
% subplot(2,3,2), imshow(top_left_noise), title('noisy image')
% subplot(2,3,3), imshow(top_left_median), title('median filter')
% subplot(2,3,4), imshow(top_left_arith), title('arithmetic mean filter')
% subplot(2,3,5), imshow(top_left_gauss), title('gaussian filter')
% figure,
% subplot(2,3,1), imshow(top_right_orig), title('original image')
% subplot(2,3,2), imshow(top_right_noise), title('noisy image')
% subplot(2,3,3), imshow(top_right_median), title('median filter')
% subplot(2,3,4), imshow(top_right_arith), title('arithmetic mean filter')
% subplot(2,3,5), imshow(top_right_gauss), title('gaussian filter')
% figure,
% subplot(2,3,1), imshow(bottom_left_orig), title('original image')
% subplot(2,3,2), imshow(bottom_left_noise), title('noisy image')
% subplot(2,3,3), imshow(bottom_left_median), title('median filter')
% subplot(2,3,4), imshow(bottom_left_arith), title('arithmetic mean filter')
% subplot(2,3,5), imshow(bottom_left_gauss), title('gaussian filter')
% figure,
% subplot(2,3,1), imshow(bottom_right_orig), title('original image')
% subplot(2,3,2), imshow(bottom_right_noise), title('noisy image')
% subplot(2,3,3), imshow(bottom_right_median), title('median filter')
% subplot(2,3,4), imshow(bottom_right_arith), title('arithmetic mean filter')
% subplot(2,3,5), imshow(bottom_right_gauss), title('gaussian filter')

% -------------------------------------------------------------------

% === The following code shows the filtered images and the error images
%           === with each filter in a different figure ===
%           === and each quadrant in a different figure ===

% subplot(1,3,1), imshow(top_left_noise), title('noisy image')
% subplot(1,3,2), imshow(top_left_median), title('median filter')
% subplot(1,3,3), imshow(err_img_tl_median), title('error image')
% figure,
% subplot(1,3,1), imshow(top_left_noise), title('noisy image')
% subplot(1,3,2), imshow(top_left_arith), title('arithmetic mean filter')
% subplot(1,3,3), imshow(err_img_tl_arith), title('error image')
% figure,
% subplot(1,3,1), imshow(top_left_noise), title('noisy image')
% subplot(1,3,2), imshow(top_left_gauss), title('gaussian filter')
% subplot(1,3,3), imshow(err_img_tl_gauss), title('error image')
% figure,
% subplot(1,3,1), imshow(top_right_noise), title('noisy image')
% subplot(1,3,2), imshow(top_right_median), title('median filter')
% subplot(1,3,3), imshow(err_img_tr_median), title('error image')
% figure,
% subplot(1,3,1), imshow(top_right_noise), title('noisy image')
% subplot(1,3,2), imshow(top_right_arith), title('arithmetic mean filter')
% subplot(1,3,3), imshow(err_img_tr_arith), title('error image')
% figure,
% subplot(1,3,1), imshow(top_right_noise), title('noisy image')
% subplot(1,3,2), imshow(top_right_gauss), title('gaussian filter')
% subplot(1,3,3), imshow(err_img_tr_gauss), title('error image')
% figure,
% subplot(1,3,1), imshow(bottom_left_noise), title('noisy image')
% subplot(1,3,2), imshow(bottom_left_median), title('median filter')
% subplot(1,3,3), imshow(err_img_bl_median), title('error image')
% figure,
% subplot(1,3,1), imshow(bottom_left_noise), title('noisy image')
% subplot(1,3,2), imshow(bottom_left_arith), title('arithmetic mean filter')
% subplot(1,3,3), imshow(err_img_bl_arith), title('error image')
% figure,
% subplot(1,3,1), imshow(bottom_left_noise), title('noisy image')
% subplot(1,3,2), imshow(bottom_left_gauss), title('gaussian filter')
% subplot(1,3,3), imshow(err_img_bl_gauss), title('error image')
% figure,
% subplot(1,3,1), imshow(bottom_right_noise), title('noisy image')
% subplot(1,3,2), imshow(bottom_right_median), title('median filter')
% subplot(1,3,3), imshow(err_img_br_median), title('error image')
% figure,
% subplot(1,3,1), imshow(bottom_right_noise), title('noisy image')
% subplot(1,3,2), imshow(bottom_right_arith), title('arithmetic mean filter')
% subplot(1,3,3), imshow(err_img_br_arith), title('error image')
% figure
% subplot(1,3,1), imshow(bottom_right_noise), title('noisy image')
% subplot(1,3,2), imshow(bottom_right_gauss), title('gaussian filter')
% subplot(1,3,3), imshow(err_img_br_gauss), title('error image')

% -------------------------------------------------------------------

% === The following code shows the full image with the respective filters applied
    
% medianFiltImg = ReconstructArr(top_left_median, top_right_median, bottom_left_median, bottom_right_median);
% arithFiltImg = ReconstructArr(top_left_arith, top_right_arith, bottom_left_arith, bottom_right_arith);
% gaussFiltImg = ReconstructArr(top_left_gauss, top_right_gauss, bottom_left_arith, bottom_right_gauss);
% figure, imshow(medianFiltImg), title('Median filter') 
% figure, imshow(arithFiltImg), title('Arithmetic mean filter')
% figure, imshow(gaussFiltImg), title('Gaussian filter')
 
% finalFiltImg = ReconstructArr(top_left_median,top_right_median, bottom_left_gauss, bottom_right_median);
% figure, imshow(finalFiltImg), title('"intuitive" image') 