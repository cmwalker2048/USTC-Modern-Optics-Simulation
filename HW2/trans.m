% 将图片转换为60*60的二值化图片

image = imread('input.png');

% 将图像灰度化
gray_image = rgb2gray(image);

% 调整图像大小为 60x60
resized_image = imresize(gray_image, [4200, 4200]);

% 二值化图像
binary_image = imbinarize(resized_image);

% 将逻辑数组转换为数值数组
input = double(binary_image);

% 显示二值化图像
imshow(binary_image);

% 保存
save("input.mat","input");