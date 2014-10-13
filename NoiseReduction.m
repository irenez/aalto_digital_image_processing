ImgOrig = imread('city_orig.png');
ImgNoise = imread('city_noise.png');
[M, N] = size(ImgOrig);
x_mid = ceil(M/2);
y_mid = ceil(N/2);
mse = ones(4);  % initialize a MeanSquareError matrix
                % use columns for the quadrants
                % and rows for the filters

% define filters
arith_filter =  ones(3)/9.;     % = fspecial('average');
gaussian_filter = fspecial('gaussian');

% ---------- top-left: impulsive noise (salt&pepper) ----------

top_left_orig = SliceArray(ImgOrig, 1, y_mid);
top_left_noise = SliceArray(ImgNoise, 1, y_mid);
mse(1,1) = 4*sum(mean((top_left_orig - top_left_noise).^2))/(M*N);
    
% applying the median filter
top_left_median = medfilt2(top_left_noise);
mse(2,1) = 4*sum(mean((top_left_orig - top_left_median).^2))/(M*N);

% applying the arithmetic mean filter
top_left_arith = imfilter(top_left_noise, arith_filter);
mse(3,1) = 4*sum(mean((top_left_orig - top_left_arith).^2))/(M*N);

% applying the gaussian filter
top_left_gauss = imfilter(top_left_noise, gaussian_filter);
mse(4,1) = 4*sum(mean((top_left_orig - top_left_gauss).^2))/(M*N);


% ---------- top-right: impulsive and white gaussian noise --------

top_right_orig = SliceArray(ImgOrig, x_mid+1, y_mid);
top_right_noise = SliceArray(ImgNoise, x_mid+1, y_mid);
mse(1,2) = 4*sum(mean((top_right_orig - top_right_noise).^2))/(M*N);

% applying the median filter
top_right_median = medfilt2(top_right_noise);
mse(2,2) = 4*sum(mean((top_right_orig - top_right_median).^2))/(M*N);

% applying the arithmetic mean filter
top_right_arith = imfilter(top_right_noise, arith_filter);
mse(3,2) = 4*sum(mean((top_right_orig - top_right_arith).^2))/(M*N);

% applying the gaussian mean filter
top_right_gauss = imfilter(top_right_noise, gaussian_filter);
mse(4,2) = 4*sum(mean((top_right_orig - top_right_gauss).^2))/(M*N);


% ---------- bottom-left --------

bottom_left_orig = SliceArray(ImgOrig, 1, N);
bottom_left_noise = SliceArray(ImgNoise, 1, N);
mse(1,3) = 4*sum(mean((bottom_left_orig - bottom_left_noise).^2))/(M*N);

% applying the median filter
bottom_left_median = medfilt2(bottom_left_noise);
mse(2,3) = 4*sum(mean((bottom_left_orig - bottom_left_median).^2))/(M*N);

% applying the arithmetic mean filter
bottom_left_arith = imfilter(bottom_left_noise, arith_filter);
mse(3,3) = 4*sum(mean((bottom_left_orig - bottom_left_arith).^2))/(M*N);
    
% applying the gaussian mean filter
bottom_left_gauss = imfilter(bottom_left_noise, gaussian_filter);
mse(4,3) = 4*sum(mean((bottom_left_orig - bottom_left_gauss).^2))/(M*N);

    
% ---------- bottom-right: gaussian noise -------------

bottom_right_orig = SliceArray(ImgOrig, x_mid+1, M);
bottom_right_noise = SliceArray(ImgNoise, x_mid+1, M);
mse(1,4) = 4*sum(mean((bottom_right_orig - bottom_right_noise).^2))/(M*N);

% applying the median filter
bottom_right_median = medfilt2(bottom_right_noise);
mse(2,4) = 4*sum(mean((bottom_right_orig - bottom_right_median).^2))/(M*N);

% applying the arithmetic mean filter
bottom_right_arith = imfilter(bottom_right_noise, arith_filter);
mse(3,4) = 4*sum(mean((bottom_right_orig - bottom_right_arith).^2))/(M*N);
    
% applying the gaussian filter
bottom_right_gauss = imfilter(bottom_right_noise, gaussian_filter);
mse(4,4) = 4*sum(mean((bottom_right_orig - bottom_right_gauss).^2))/(M*N);

subplot(2,3,1), imshow(top_left_orig), title('original image')
subplot(2,3,2), imshow(top_left_noise), title('noisy image')
subplot(2,3,3), imshow(top_left_median), title('median filter')
subplot(2,3,4), imshow(top_left_arith), title('arithmetic mean filter')
subplot(2,3,5), imshow(top_left_gauss), title('gaussian filter')
figure,
subplot(2,3,1), imshow(top_right_orig), title('original image')
subplot(2,3,2), imshow(top_right_noise), title('noisy image')
subplot(2,3,3), imshow(top_right_median), title('median filter')
subplot(2,3,4), imshow(top_right_arith), title('arithmetic mean filter')
subplot(2,3,5), imshow(top_right_gauss), title('gaussian filter')
figure,
subplot(2,3,1), imshow(bottom_left_orig), title('original image')
subplot(2,3,2), imshow(bottom_left_noise), title('noisy image')
subplot(2,3,3), imshow(bottom_left_median), title('median filter')
subplot(2,3,4), imshow(bottom_left_arith), title('arithmetic mean filter')
subplot(2,3,5), imshow(bottom_left_gauss), title('gaussian filter')
figure,
subplot(2,3,1), imshow(bottom_right_orig), title('original image')
subplot(2,3,2), imshow(bottom_right_noise), title('noisy image')
subplot(2,3,3), imshow(bottom_right_median), title('median filter')
subplot(2,3,4), imshow(bottom_right_arith), title('arithmetic mean filter')
subplot(2,3,5), imshow(bottom_right_gauss), title('gaussian filter')


% Uncomment the next lines to see the full image
    % with the respective filters applied
    
finalFiltImg = ReconstructArr(top_left_median,top_right_median, bottom_left_gauss, bottom_right_median);
figure, imshow(finalFiltImg), title('filtered image') 

% medianFiltImg = ReconstructArr(top_left_median, top_right_median, bottom_left_median, bottom_right_median);
% arithFiltImg = ReconstructArr(top_left_arith, top_right_arith, bottom_left_arith, bottom_right_arith);
% figure, imshow(medianFiltImg), title('Median filter') 
% figure, imshow(arithFiltImg), title('Arithmetic mean filter')
% figure, imshow(geomFiltImg), title('Geometric mean filter')
