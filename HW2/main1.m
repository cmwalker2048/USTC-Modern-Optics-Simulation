% 2024Spring 近代光学基础第二次编程作业
%   透镜成像
% 

clc;
clear all;
close all;

% 定义单位
mm = 1e-3;
mum = 1e-6;
nm = 1e-9;

% 定义输入光的参数
lambda = 633*nm;
k = 2*pi/lambda;

% 设置透镜参数
f = 100*mum;
D = 420*mum;
z1 = 200*mum;

% 设置物体的参数
load("input.mat");
L = 420*mum; % 设置屏的大小
N = 4200; % 设置数值的大小
dx = L/N;
x = -0.5*L:dx:0.5*L-dx;
y = x;
[X,Y] = meshgrid(x,y);

figure;imagesc(input);
xlabel('x(0.1 mum)');
ylabel('y(0.1 mum)');
colorbar;
colormap("gray");
title("input");

u1 = input; % 设置入射光

% 主函数，透镜传输
M = 1;
u2 = asm(z1,u1,N,dx,k,lambda);
u3 = u2*exp(-1i*k/(2*f)*(X.^2+Y.^2))*heaviside(D/2-(sqrt(X.^2+Y.^2)));
u4 = asm(z1*M,u1,N,dx,k,lambda);

figure;imagesc(abs(u4));
xlabel('x(0.1 mum)');
ylabel('y(0.1 mum)');
colorbar;
colormap("gray");
title("output-XY plane");
