function [out] = rmse(I1,I2)
%RMSE 此处显示有关此函数的摘要
%   此处显示详细说明
[nc,nr] = size(I1);
sum = 0;
for ii = 1:nc
    for jj = 1:nr
        sum = sum + abs((I1(ii,jj)-I2(ii,jj))^2);
    end
end

out = sqrt(sum/(nc*nr));

end

