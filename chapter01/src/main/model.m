%%  采用 Matlab默认的fit进行多项式拟合
% dt: 采样率
% border: 合成数据横轴边界
% M: [1:9] 模型阶数
function [wi, rms] = model(dt, border, M)
    %% 数据处理
    if nargin < 2
        dt = 1;  M = 9;
    end

    [x, y] = syntheticdata(dt, border); %合成训练集
    
    fs = cell(M, 1);      % 保存拟合多项式信息
    gof = cell(M, 1);     % 保存拟合优度信息
    for i = 1 : M
        [fs{i},gof{i}] = fit(x, y, ['poly' num2str(i)]);
    end
    


    % 多项式系数信息
    wi = zeros(M+1,M);    % 保存多项式系数
    for i = 1 : M
        for j = 1 : length(flip(coeffvalues(fs{i})))
            cof = flip(coeffvalues(fs{i}));
            wi(j, i) = cof(j);
        end
    end

    % 模型评估参数信息
    sse = zeros(M, 1);    % 残差平方和
    rms = zeros(M, 1);    % 均方根误差
    for i = 1 :  M
        sse(i) = gof{i}.sse;
        rms(i) = gof{i}.rmse;
    end

    %  寻找评估参数最小值对应的模型
    [minValueSSE, minIndexSSE] = min(sse);
    [minValueRMS, minIndexRMS] = min(rms);


    %% 绘图
    figure
    for i = 1 : M
        % 绘图
        subplot(3, 3, i);
        plot(fs{i}, x, y);
    
        ax = gca;
        ax.XAxisLocation = 'origin'; 
    
        ylim([-1.5, 1.5])
    
        title([' M = ' num2str(i) ', SSE = ' num2str(gof{i}.sse) ', RMS = ' num2str(gof{i}.rmse)], ...
            'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
    
        legend off;
    end
    % 在整个figure底部添加文字
    annotation('textbox', [0 0 1 0.06], 'String', ...
        sprintf('最小残差平方和: M = %d, SSE = %.4f     最小均方根误差: M = %d, RMS = %.4f', ...
        minIndexSSE, minValueSSE, minIndexRMS, minValueRMS), ...
        'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold', ...
        'FontName', 'TimesRoman', 'EdgeColor', 'none');
    
    % 在整个figure顶部添加文字
    annotation('textbox', [0 0 1 0.99], 'String', ...
        sprintf('训练集: 多项式拟合'), ...
        'HorizontalAlignment', 'center', 'FontSize', 16, 'FontWeight', 'bold', ...
        'FontName', 'TimesRoman', 'EdgeColor', 'none');
    
    exportgraphics(gcf, './多项式拟合_训练.png', 'Resolution', 300);  % 高分辨率保存
end
    