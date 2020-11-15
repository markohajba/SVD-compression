% image compression based on SVD
% image package is needed in GNU Octave
% part of the lecture of the course Numerical mathematics
% Marko Hajba, Virovitica College

clear all;
close all;
clc


A=imread('photo3','png'); 	% load image
Abw2=rgb2gray(A); 		% transform image into black and white image
Abw=double(Abw2); 		% we need real number to be able to calculate
[nx,ny]=size(Abw); 		% image dimensions
figure(1), subplot(1,2,1), imshow(Abw2) 	% show black and white version of the picture

% save black-white version of the picture
imwrite(Abw2, 'BW_original.jpg')

[U, S, V] = svd(Abw); 		%SVD

MSE_error=[];
PSNR_error=[];
norm_2_error = [];

brojac=1;
for k = 4 : 20: 244  		% rank of the approximation
    
    k
    A1 = U(:, 1:k) * S(1:k, 1:k)* V(:, 1:k)'; % reduced image

    % transform coefficients to the range of the pixels 0-255:
    A1_comp=uint8(A1);
    
    %%% norm_ 2 is equal to \sigma k+1 from (Eckhard - Young-Mirsky theorem)
    norm_2_error(brojac) = S(k+1, k+1)
    
    %%% calculate MSE:
    D = abs(Abw-double(A1_comp)).^2;
    MSE_error(brojac)=sum(D(:)) / (nx*ny)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%% calculate PSNR:
    PSNR_error(brojac)=10* log10(255^2/ MSE_error(brojac))
    
    figure(1), subplot(1,2,2), imshow(A1_comp), title(['k=' num2str(k)]) %crno-bijela verzija
    w8 = waitforbuttonpress;
    brojac=brojac+1;
end

%optional save image to file:
%imwrite(A1_comp, 'compress_svd.jpg')