% 2024Spring 近代光学基础第一次编程作业
%
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
f = 50*mum;

% 定义光屏的参数
L = 120*mum; % 设置屏的大小
R = 50*mum; % 设置圆孔的大小
N = 1200; % 设置数值的大小
dx = L/N;
x = -0.5*L:dx:0.5*L-dx;
y = x;
[X,Y] = meshgrid(x,y);
aperture = heaviside(R-(sqrt(X.^2+Y.^2)));
aperture(aperture==0.5)=0;


u1 = aperture; % 设置入射光
u1 = u1.*exp(-1i*k*(X.^2+Y.^2)/(2*f));


figure;imagesc(real(u1));
xlabel('x(0.1 mum)');
ylabel('y(0.1 mum)');
xticks('auto');
yticks('auto');
colorbar;
colormap("gray");
title("input");
% 主函数，返回任意z处的X-Y光场分布

U = zeros(1,N,5000);
for zz = 300:700
    u2 = asm(zz*dx,u1,N,dx,k,lambda);
    U(1,:,zz) = abs((u2(N/2,:)+u2(N/2+1,:))/2);
    disp(zz);
end

YZ = squeeze(U(1,:,300:700));

figure;imagesc(YZ());
xlabel('z(0.1 mum)');
ylabel('y(0.1 mum)');
colorbar;
colormap("gray");
title("output-YZ plane");
