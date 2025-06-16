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
    W = zeros(M + 1, M);  % 每列是一个模型的权重
    rms = zeros(M, 1);    % 每个模型对应一个 RMS

    for i = 1:M
        Vi = V(:, 1:(i + 1));  % 使用阶数为 i 的模型

        % 岭回归闭式解：w = inv(VᵗV + λI) * Vᵗy
        I = eye(i + 1);
        w = (Vi' * Vi + lambda * I) \ (Vi' * y);

        % 保存系数（对齐在W前部）
        W(1:i + 1, i) = w;

        % 预测和误差计算
        yhat = Vi * w;
        rms(i) = sqrt(mean((yhat - y).^2));
    end

    % 绘图：训练集拟合曲线
    figure
    for i = 1:M
        subplot(3, 3, i);
        yhat = V(:, 1:(i+1)) * W(1:(i+1), i);
        plot(x, y, 'ko', 'MarkerSize', 4, 'MarkerFaceColor', 'k'); hold on;
        plot(x, yhat, 'LineWidth', 1.2); hold off;
        title(['M = ' num2str(i) ', RMS = ' num2str(rms(i))], ...
            'FontSize', 10, 'FontWeight', 'bold');
        ax = gca; ax.XAxisLocation = 'origin'; ylim([-1.5, 1.5]);
    end

    annotation('textbox', [0 0 1 0.99], 'String', ...
        sprintf('训练集: 多项式拟合 (λ = %.3f), dt = %.3f', lambda, dt), ...
        'HorizontalAlignment', 'center', 'FontSize', 16, ...
        'FontWeight', 'bold', 'EdgeColor', 'none',...
        'FontName', 'TimesRoman', 'EdgeColor', 'none');

    timestamp = datestr(now, 'HHMMSS');
    filename = ['figure_' timestamp '.png'];
    exportgraphics(gcf, filename, 'Resolution', 300);
    
end
