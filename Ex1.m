fid=fopen('H:\Desktop\BioImg\Ex1\head.128','r'); % Opens file for reading
[x,npels]=fread(fid,[128,128],'uchar'); % Reads data values
% into matrix x with 128 rows,
% and 128 columns
x=x'; % Matlab reads in arrays with a different index order [Ctd...]
 % to that of ‘C’ File was created using C, so transpose matrix
fclose(fid); % Close the file handle

%% 
map = gray(64);
image(x);colormap(map);colorbar; 

%% 
mymap = gray(256);
image(x);colormap(mymap);colorbar; 

%% 
clear; close all; % Close all windows, and clear all variables
[X,map] = imread('trees.tif');
image(X); % Display the image…
colormap(map); % with its colormap (as read from the TIFF file) 

%% 
clear; close all; % Close all windows, and clear all variables
[X,map] = imread('lily.tif');

column_ramp = [0:1/255:1]';% Create column of values running from 0 to 1
% The next 3 lines create three colourmaps, intended for displaying the
% red green and blue components separately.
redmap = [column_ramp,zeros(256,1),zeros(256,1)];
greenmap = [zeros(256,1),column_ramp,zeros(256,1)];
bluemap = [zeros(256,1),zeros(256,1),column_ramp];
% Below, display the three image planes in 3 separate windows
figure(1); colormap(redmap);image(X(:,:,1)); colorbar;
figure(2); colormap(greenmap);image(X(:,:,2)); colorbar;
figure(3); colormap(bluemap);image(X(:,:,3)); colorbar

%% 
colormap(gray(256));
image(X(:,:,1)); % Display the image…

%% 
close all;
figure;
R=double(X(:,:,1)); 
G=double(X(:,:,2)); 
B = double(X(:,:,3));

tri_x = R./(R+G+B);
tri_x = tri_x/max(max(tri_x));
tri_x = 255*tri_x;
tri_x = floor(tri_x);


colormap(gray(256)); image(tri_x);

tri_y = G./(R+G+B);
tri_y = tri_y/max(max(tri_y));
tri_y = 255*tri_y;
tri_y = floor(tri_y);

figure;
colormap(gray(256)); image(tri_y);

tri_z = B./(R+G+B);
tri_z = tri_z/max(max(tri_z));
tri_z = 255*tri_z;
tri_z = floor(tri_z);

figure;
colormap(gray(256)); image(tri_z);

%% 
info = dicominfo('US-PAL-8-10x-echo.dcm');
[X, map] = dicomread('US-PAL-8-10x-echo.dcm');
montage(X, map);colorbar; 

M=immovie(X,map);
movie(M,20,10);

%% 
X1 = zeros(430,600,10);
for k = 1:10
    for i = 1:430
        for j = 1:600
            if ((map(X(i,j,1,k),1) == map(X(i,j,1,k),2))&&(map(X(i,j,1,k),3) == map(X(i,j,1,k),2)))
                X1(i,j,k) = 1;
                
            else
                X1(i,j,k) = 0;
            end
        end
    end
end

X1 = 255*X1;
colormap(gray(265)); image(X1(:,:,1));