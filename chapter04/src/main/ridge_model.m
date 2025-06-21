%% 采用最小二乘法进行多项式拟合实验
% 
% dt:      采样率
% border:  横轴边界
% M:       最大阶数
% lambda:  正则化强度

function ridge_model(dt, x, y, M, lambda)

    if nargin < 4
        lambda = 0;  % 默认为无正则化（即普通最小二乘）
    end
    if nargin < 3
        M = 9;
    end

    % 构造Vandermonde矩阵（包括x^0常数项）
    N = length(x);
    V = zeros(N, M + 1);  % V(i,j) = x(i)^(j-1)
    for k = 1:(M + 1)
        V(:, k) = x.^(k - 1);
    end

    % 初始化输出
  

    for i = 1:M
        Vi = V(:, 1:(i + 1));  % 使用阶数为 i 的模型

        % 岭回归闭式解：w = inv(VᵗV + λI) * Vᵗy
        I = eye(i + 1);
        w = (Vi' * Vi + lambda * I) \ (Vi' * y);


        % 预测和误差计算
        yhat = Vi * w;
        rms(i) = sqrt(mean((yhat - y).^2));
    end

    % 绘图：训练集拟合曲线

    ypre =  Vi*w;
    plot(x, ypre);
    ax = gca; ax.XAxisLocation = 'origin'; ylim([-1.5, 1.5]);

    title(['M =' num2str(M) ',' '$\ln \lambda$' '=' num2str(log(lambda))], 'Interpreter', 'latex', 'FontSize', 14)

    hold on;
    
end
