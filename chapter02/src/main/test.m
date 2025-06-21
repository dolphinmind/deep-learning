% wi:  多项式模型权重系数
% rms: 模型均方根
% dt:  测试集采样率
% M:   多项式阶数「模型」
function test(border, wi, rms, dt, M)

    %% 数据处理
    [x, ytest] = syntheticdata(dt, border);%合成测试数据集
    
    % 利用模型预测
    n = length(x);
    V = zeros(n,M+1);     
    for k = 1:(M+1)
        V(:,k) = x.^(k-1);
    end
    ypre = V * wi; %利用训练模型预测数据结果

    % 评估参数SSE
    sse_errors = sum((ypre - ytest).^2);  % 每列是一个模型的 SSE
    
    % 评估参数RMS
    diff = ypre - ytest;
    rms_errors = sqrt(mean(diff .^ 2));     % RMS 计算
    
    
    %% 绘制测试集预测图
    figure
    % 测试数据用黑色实心圆点表示
    plot(x, ytest, 'ko', 'MarkerSize', 4, 'MarkerFaceColor', 'k', 'DisplayName', 'Test Data');
    hold on;
    
    % 模型预测用红色虚线
    plot(x, ypre, 'r--', 'LineWidth', 1.2, 'DisplayName', 'Model Prediction');
    hold off;
    
    ax = gca;
    ax.XAxisLocation = 'origin'; 
    
    ylim([-1.5, 1.5]);
    
    title([' M = ' num2str(M) ', SSE = ' num2str(sse_errors) ', RMS = ' num2str(rms_errors)], ...
        'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
    legend('Location', 'best');
    
    
    
    % 在整个figure顶部添加文字
    annotation('textbox', [0 0 1 0.99], 'String', ...
        sprintf('测试集: 模型预测'), ...
        'HorizontalAlignment', 'center', 'FontSize', 16, 'FontWeight', 'bold', ...
        'FontName', 'TimesRoman', 'EdgeColor', 'none');
    exportgraphics(gcf, '多项式拟合_测试.png', 'Resolution', 300);  % 高分辨率保存

end

