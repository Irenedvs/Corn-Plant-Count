% works 
clc;
clear all;
close all;
img_rgb1=imread('1N0A7638_row1.tiff');
img_new=im2double(img_rgb1)*255;
img_hsv=rgb2hsv(img_rgb1);
% for r=1:1:size(img_rgb,1)
%     for c=1:1:size(img_rgb,2)
%         if(img_hsv(r,c,2)>0.5)
%             img_bin1(r,c)=1;
%         else
%             img_bin1(r,c)=0;
%         end
%      end
% end
% for r=1:1:size(img_rgb,1)
%     for c=1:1:size(img_rgb,2)
%         img_new(r,c,1)=img_rgb(r,c,1)/img_rgb(r,c,1)+img_rgb(r,c,2)+img_rgb(r,c,3);
%         img_new(r,c,2)=img_rgb(r,c,2)/img_rgb(r,c,1)+img_rgb(r,c,2)+img_rgb(r,c,3);
%         img_new(r,c,3)=img_rgb(r,c,3)/img_rgb(r,c,1)+img_rgb(r,c,2)+img_rgb(r,c,3);
%     end
% end
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
m=find(N==max(N(100:end)));
for r=1:1:size(img_rgb1,1)
    for c=1:1:size(img_rgb1,2)
        if(img_neg(r,c)>0.75*m)
                img_bin(r,c)=1;
        else
                img_bin(r,c)=0;

        end
     end
end

 img_bin=bwareaopen(img_bin,40);
 img_bin=bwmorph(img_bin,'skel',Inf);
 cc = bwconncomp(img_bin);
 labeled = labelmatrix(cc);
 RGB_label = label2rgb(labeled, @copper, 'c', 'shuffle');
count=0;
for i=1:1:size(cc.PixelIdxList,2)
    n=floor(size(cc.PixelIdxList{i},1)/52);
    count=count+n;
    if(mod(size(cc.PixelIdxList{i},1),52)>15)
        count=count+1;
    end
end
fprintf(' The count is %d ',count);
%  color = img_rgb1;
%  color(img_bin ~= 0) =0 ;
%  seg_img=color;
%imwrite(seg_img,'1N0A7668_segmented_row.tiff');

