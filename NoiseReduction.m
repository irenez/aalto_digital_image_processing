ImgOrig = imread('city_orig.png');
ImgNoise = imread('city_noise.png');
[M, N] = size(ImgOrig);
x_mid = ceil(M/2);
y_mid = ceil(N/2);

% define filters
arith_filter =  ones(3)/9.;     % = fspecial('average');

% top-left: impulsive noise (salt&pepper)
top_left_orig = SliceArray(ImgOrig, 1, y_mid);
top_left_noise = SliceArray(ImgNoise, 1, y_mid);
mean_sq_err_tl = 4*sum(mean((top_left_orig - top_left_noise).^2))/(M*N);
fprintf('Mean square error for the top left quadrant of the noisy image: %f\n', ...
        mean_sq_err_tl)
    
% applying the median filter
top_left_median = medfilt2(top_left_noise);
mse_tl_median = 4*sum(mean((top_left_orig - top_left_median).^2))/(M*N);
fprintf('Mean square error for the top left quadrant of the median-filtered image: %f\n', ...
        mse_tl_median)

% applying the arithmetic mean filter
top_left_arith = imfilter(top_left_noise, arith_filter);
mse_tl_arith = 4*sum(mean((top_left_orig - top_left_arith).^2))/(M*N);
fprintf('Mean square error for the top left quadrant of the average-filtered image: %f\n', ...
        mse_tl_arith)

% % applying the geometric mean filter
% top_left_geom = GeometricMeanFilter(top_left_noise);
% mse_tl_geom = mean((top_left_orig - top_left_geom).^2)/(M*N/4);
% % top_left_harm = HarmonicMeanFilter(top_left_noise);


% top-right: impulsive and white gaussian noise
top_right_orig = SliceArray(ImgOrig, x_mid+1, y_mid);
top_right_noise = SliceArray(ImgNoise, x_mid+1, y_mid);
mean_sq_err_tr = 4*sum(mean((top_right_orig - top_right_noise).^2))/(M*N);
fprintf('Mean square error for the top right quadrant of the noisy image: %f\n', ...
        mean_sq_err_tr)

% applying the median filter
top_right_median = medfilt2(top_right_noise);
mse_tr_median = 4*sum(mean((top_right_orig - top_right_median).^2))/(M*N);
fprintf('Mean square error for the top right quadrant of the median-filtered image: %f\n', ...
        mse_tl_median)

% applying the arithmetic mean filter
top_right_arith = imfilter(top_right_noise, arith_filter);
mse_tr_arith = 4*sum(mean((top_right_orig - top_right_arith).^2))/(M*N);
fprintf('Mean square error for the top right quadrant of the average-filtered image: %f\n', ...
        mse_tr_arith)

% % applying the geometric mean filter
% top_right_geom = GeometricMeanFilter(top_right_noise);
% mse_tr_geom = 4*sum(mean((top_right_orig - top_right_geom).^2))/(M*N);


% bottom-left
bottom_left_orig = SliceArray(ImgOrig, 1, N);
bottom_left_noise = SliceArray(ImgNoise, 1, N);
mean_sq_err_bl = 4*sum(mean((bottom_left_orig - bottom_left_noise).^2))/(M*N);
fprintf('Mean square error for the bottom left quadrant of the noisy image: %f\n', ...
        mean_sq_err_bl)

% applying the median filter
bottom_left_median = medfilt2(bottom_left_noise);
mse_bl_median = 4*sum(mean((bottom_left_orig - bottom_left_median).^2))/(M*N);
fprintf('Mean square error for the bottom left quadrant of the median-filtered image: %f\n', ...
        mse_tl_median)

% applying the arithmetic mean filter
bottom_left_arith = imfilter(bottom_left_noise, arith_filter);
mse_bl_arith = 4*sum(mean((bottom_left_orig - bottom_left_arith).^2))/(M*N);
fprintf('Mean square error for the bottom left quadrant of the average-filtered image: %f\n', ...
        mse_bl_arith)
    
% % applying the geometric mean filter
% bottom_left_geom = GeometricMeanFilter(bottom_left_noise);
% mse_bl_geom = 4*sum(mean((bottom_left_orig - bottom_left_geom).^2))/(M*N);


% bottom-right: gaussian noise
bottom_right_orig = SliceArray(ImgOrig, x_mid+1, M);
bottom_right_noise = SliceArray(ImgNoise, x_mid+1, M);
mean_sq_err_br = 4*sum(mean((bottom_right_orig - bottom_right_noise).^2))/(M*N);
fprintf('Mean square error for the bottom right quadrant of the noisy image: %f\n', ...
        mean_sq_err_br)

% applying the median filter
bottom_right_median = medfilt2(bottom_right_noise);
mse_br_median = 4*sum(mean((bottom_right_orig - bottom_right_median).^2))/(M*N);
fprintf('Mean square error for the bottom right quadrant of the median-filtered image: %f\n', ...
        mse_tl_median)

% applying the arithmetic mean filter
bottom_right_arith = imfilter(bottom_right_noise, arith_filter);
mse_br_arith = 4*sum(mean((bottom_right_orig - bottom_right_arith).^2))/(M*N);
fprintf('Mean square error for the bottom right quadrant of the average-filtered image: %f\n', ...
        mse_br_arith)
    
% % applying the geometric mean filter
% bottom_right_geom = GeometricMeanFilter(bottom_right_noise);
% mse_br_geom = 4*sum(mean((bottom_right_orig - bottom_right_geom).^2))/(M*N);


subplot(2,3,1), imshow(top_left_orig), title('original image')
subplot(2,3,2), imshow(top_left_noise), title('noisy image')
subplot(2,3,3), imshow(top_left_median), title('median filter')
subplot(2,3,4), imshow(top_left_arith), title('arithmetic mean filter')
% subplot(2,3,5), imshow(top_left_geom), title('*** filter')
figure,
subplot(2,3,1), imshow(top_right_orig), title('original image')
subplot(2,3,2), imshow(top_right_noise), title('noisy image')
subplot(2,3,3), imshow(top_right_median), title('median filter')
subplot(2,3,4), imshow(top_right_arith), title('arithmetic mean filter')
% subplot(2,3,5), imshow(top_right_geom), title('*** filter')
figure,
subplot(2,3,1), imshow(bottom_left_orig), title('original image')
subplot(2,3,2), imshow(bottom_left_noise), title('noisy image')
subplot(2,3,3), imshow(bottom_left_median), title('median filter')
subplot(2,3,4), imshow(bottom_left_arith), title('arithmetic mean filter')
% subplot(2,3,5), imshow(bottom_left_geom), title('*** filter')
figure,
subplot(2,3,1), imshow(bottom_right_orig), title('original image')
subplot(2,3,2), imshow(bottom_right_noise), title('noisy image')
subplot(2,3,3), imshow(bottom_right_median), title('median filter')
subplot(2,3,4), imshow(bottom_right_arith), title('arithmetic mean filter')
% subplot(2,3,5), imshow(bottom_right_geom), title('*** filter')

% Uncomment the next lines to see the full image
    % with the respective filters applied
    
 medianFiltImg = ReconstructArr(top_left_median, top_right_median, bottom_left_median, bottom_right_median);
 arithFiltImg = ReconstructArr(top_left_arith, top_right_arith, bottom_left_arith, bottom_right_arith);
% geomFiltImg =  ReconstructArr(top_left_geom, top_right_geom, bottom_left_geom, bottom_right_geom);
% figure, imshow(medianFiltImg), title('Median filter') 
% figure, imshow(arithFiltImg), title('Arithmetic mean filter')
% figure, imshow(geomFiltImg), title('Geometric mean filter')
