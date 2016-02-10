clc;
close all;
%img_rgb=imread('1N0A7638_lab_smooth+k.tiff');
img_rgb1=imread('1N0A7688_centre_smoothed.tif');
%img_gray=rgb2gray(img_rgb);
img_gray=imread('test.jpg');
bw=edge(img_gray,'canny');
[H,T,R] = hough(bw,'RhoResolution',0.5,'ThetaResolution',0.5);
P  = houghpeaks(H,20,'threshold',ceil(0.1*max(H(:))));
lines = houghlines(bw,T,R,P,'FillGap',100);
%% Determining the longest line segment and determining the rotation angle
max_len=0;
index=0;
for k = 2:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
      index=k;
   end
end
img_rot=imrotate(img_gray,90+lines(index).theta);
img_rot1=imrotate(img_rgb1,90+lines(index).theta);
%% Hough transform on the rotated image
%img_gray=rgb2gray(img_rot);
img_gray=img_rot;
bw=edge(img_gray,'canny');
[H,T,R] = hough(bw,'RhoResolution',0.5,'ThetaResolution',0.5);
P  = houghpeaks(H,20,'threshold',ceil(0.1*max(H(:))));
lines = houghlines(bw,T,R,P,'FillGap',100);
max_len=0;
for k = 2:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
      index=k;
   end
end
figure, imshow(img_rot1), hold on;
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','cyan');
y1_new=xy_long(1,2)+36;
y2_new=xy_long(1,2)-36;
test=img_rot1(y2_new:y1_new,:,:);
figure,imshow(test);
imwrite(test,'1N0A7638_row.tiff');
% 
% xy = [lines(33).point1; lines(33).point2];
% figure, imshow(img_rgb), hold on;
% plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
% 
% x_new(1,1)=xy(1,1)+3;
% x_new(1,1)=xy(1,1)+3;
% z=img_rgb(


