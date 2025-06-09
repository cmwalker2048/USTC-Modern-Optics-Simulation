% 2024Spring 近代光学基础第三次编程作业
%   计算全息
% 

clc;
clear all;
close all;

% 定义单位
mm = 1e-3;
mum = 1e-6;
nm = 1e-9;

% 定义输入光的参数
lambda = 632.8*nm;
k = 2*pi/lambda;

% 设置相位片参数
LL = 500*mum;
D = 200*mum;

% 设置像素尺寸
%Dx = 0.3*mum;
Dx = 2*mum;

% 设置相位片与全息图的间隔
Z = 400*mum;

% 设置全息图的参数
L = 500*mum; % 设置全息图的大小

% 抽样
x = -0.5*L:Dx:0.5*L-Dx;
[~,M] = size(x);
y = x;
[X,Y] = meshgrid(x,y);

% 导入图片
image = imread('Dark_Side_of_the_Moon.png'); % pink Floyd的专辑，强推！
%image = imread('tmp.jpg'); % pink Floyd的专辑，强推！
% 调整图像大小为 MxM
resized_image = imresize(image, [M, M]);
% 将图像灰度化
gray_image = rgb2gray(resized_image);
% 将灰度图像转换为二维数组
fig = double(gray_image);
% 显示灰度图像
imshow(gray_image);
% 保存
save("fig.mat","fig");

figure;imagesc(fig);
xlabel('x(2 mum)');
ylabel('y(2 mum)');
colorbar;
colormap("gray");
title("fig");

% 入射光设置
w0 = 100*mum;
Ui = exp(-(X.^2+Y.^2)/(w0.^2));
%Ui = 1;
% 屏函数初始化
P = heaviside(D/2-(sqrt(X.^2+Y.^2)));
% 全息图
U0 = fig; % 设置全息图真值
% RMSE阈值
RMSE0 = 100;
% 最大运行次数
MS = 50;
s = 0;

u1 = Ui.*P.*exp(1i*2*pi*rand(M,M));

% 主函数，GS算法
while s<MS
    u2 = asm(Z,u1,M,Dx,k,lambda);
    fu2 = U0.*exp(1i*angle(u2));
    fu1 = asm(-Z,fu2,M,Dx,k,lambda);
    u1 = Ui.*P.*exp(1i*angle(fu1));
    s = s+1;
    disp(s);
end

fig_out = u2;
phase = exp(1i.*angle(u1));

figure;imagesc(abs(u2));
xlabel('x(2 mum)');
ylabel('y(2 mum)');
colorbar;
colormap("gray");
title("output-XY plane");

figure;imagesc(real(u1));
xlabel('x(2 mum)');
ylabel('y(2 mum)');
colorbar;
colormap("gray");
title("Phase plane - Real");

figure;imagesc(imag(u1));
xlabel('x(2 mum)');
ylabel('y(2 mum)');
colorbar;
colormap("gray");
title("Phase plane - Imagine");
