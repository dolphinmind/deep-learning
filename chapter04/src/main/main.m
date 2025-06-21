clear;
clc;
close all;

% [wi, rms] = model(1, 10, 6);
% 
% test(10, wi, rms, 0.1, 6);

% 正则化
for i = 1 : 25
    [x, y] = syntheticdata(0.2, 10);
    ridge_model(1, x, y, 25, exp(-3));
end

% ridge_model(1, x, y, 24, 0.01);
% ridge_model(1, x, y, 24, 0.1);

% [x, y] = syntheticdata(0.1, 10);
% ridge_model(0.1, x, y, 9, 0.001);
% ridge_model(0.1, x, y, 9, 0.01);
% ridge_model(0.1, x, y, 9, 0.1);