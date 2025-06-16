addpath(genpath('./src'));  

% 数据边界:
border = 10;
% 模型阶数
M = 9;


% 训练
[wi, rms] = model(1, border,  M);

% 测试
test(border, wi, rms, 0.1, M);

% 正则化
[x, y] = syntheticdata(1, 10);
ridge_model(1, x, y, 9, 0.001);
ridge_model(1, x, y, 9, 0.01);
ridge_model(1, x, y, 9, 0.1);

[x, y] = syntheticdata(0.1, 10);
ridge_model(0.1, x, y, 9, 0.001);
ridge_model(0.1, x, y, 9, 0.01);
ridge_model(0.1, x, y, 9, 0.1);
