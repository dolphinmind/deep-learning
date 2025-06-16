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
    ypre = V*wi; %利用训练模型预测数据结果

    % 评估参数SSE
    sse_errors = sum((ypre - ytest).^2, 1);  % 每列是一个模型的 SSE
    
    % 评估参数RMS
    rms_errors = zeros(9, 1);
    
    for i = 1 : M
        diff = ypre(:, i) - ytest;
        rms_errors(i) = sqrt(mean(diff .^ 2));     % RMS 计算
    end
    
    
    %% 绘制测试集预测图
    figure

    for i = 1 : M
    
        subplot(3, 3, i);
    
        % 测试数据用黑色实心圆点表示
        plot(x, ytest, 'ko', 'MarkerSize', 4, 'MarkerFaceColor', 'k', 'DisplayName', 'Test Data');
        hold on;
    
        % 模型预测用红色虚线
        plot(x, ypre(:, i), 'r--', 'LineWidth', 1.2, 'DisplayName', 'Model Prediction');
        hold off;
    
        ax = gca;
        ax.XAxisLocation = 'origin'; 
    
        ylim([-1.5, 1.5]);
    
        title([' M = ' num2str(i) ', SSE = ' num2str(sse_errors(i)) ', RMS = ' num2str(rms_errors(i))], ...
            'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
        legend('Location', 'best');
    
    end
    
    
    % 在整个figure顶部添加文字
    annotation('textbox', [0 0 1 0.99], 'String', ...
        sprintf('测试集: 模型预测'), ...
        'HorizontalAlignment', 'center', 'FontSize', 16, 'FontWeight', 'bold', ...
        'FontName', 'TimesRoman', 'EdgeColor', 'none');
    exportgraphics(gcf, '多项式拟合_测试.png', 'Resolution', 300);  % 高分辨率保存


    %% 绘图
    figure
    x = [1:1:M];
    plot(x, rms_errors,'*-', 'DisplayName', '测试');
    hold on;
    plot(x, rms, '*-','DisplayName', '训练');
    legend('Location', 'best'); 

    title(['均方根误差图'],...
    'FontSize', 18, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
    xlabel('M', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('$E_{\mathrm{RMS}}$', 'Interpreter', 'latex', 'FontSize', 12, 'FontWeight', 'bold');
    exportgraphics(gcf, '均方根误差图.png', 'Resolution', 300);  % 高分辨率保存

end

