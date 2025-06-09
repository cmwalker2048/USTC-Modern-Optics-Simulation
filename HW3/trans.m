% 将图片转换为60*60的灰度化图片

% 读取图像
image = imread('Dark_Side_of_the_Moon.png');
% 调整图像大小为 60x60
resized_image = imresize(image, [60, 60]);
% 将图像灰度化
gray_image = rgb2gray(resized_image);
% 将灰度图像转换为二维数组
fig = double(gray_image);
% 显示灰度图像
imshow(gray_image);
% 保存
save("fig.mat","fig");