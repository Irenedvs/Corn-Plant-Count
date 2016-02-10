% works 
clc;
clear all;
close all;
img_rgb1=imread('1N0A7688_centre_smoothed.tif');
img_new=im2double(img_rgb1)*255;
img_hsv=rgb2hsv(img_rgb1);
%% converting to Excessive green space
max_red=max(max(img_new(:,:,1)));
for r=1:1:size(img_rgb1,1)
    for c=1:1:size(img_rgb1,2)
        img_neg(r,c)=2.8*img_new(r,c,2)-2*img_new(r,c,1);
    end
end
img_neg=img_neg-min(min(img_neg));
img_neg=img_neg/(max(max(img_neg))-min(min(img_neg)));
img_neg=floor(img_neg*255);
N=histcounts(img_neg);
bin_width=255/size(N,2);
m=find(N==max(N(100:end)));
for r=1:1:size(img_rgb1,1)
    for c=1:1:size(img_rgb1,2)
        if(img_neg(r,c)>90 && img_neg(r,c)<160)
            if(img_new(r,c,1)>180)
                img_bin(r,c)=0;
            else
                img_bin(r,c)=1;
            end       
        else
                img_bin(r,c)=0;

        end
     end
end

 %img_bin=bwareaopen(img_bin,40);
 %img_bin=bwmorph(img_bin,'skel',Inf);
imwrite(img_bin,'test.jpg');
%  color = img_rgb1;
%  color(img_bin ~= 0) =0 ;
%  seg_img=color;
%imwrite(seg_img,'1N0A7668_segmented_row.tiff');

