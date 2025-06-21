%%  采用 Matlab默认的fit进行多项式拟合
% dt: 采样率
% border: 合成数据横轴边界
% M: [1:9] 模型阶数
function [wi, rms] = model(dt, border, M)
    %% 数据处理
    if nargin < 2
        dt = 1;  M = 6;
    end

    [x, y] = syntheticdata(dt, border); %合成训练集
    
    %fs 保存拟合多项式信息
    %gof 保存拟合优度信息
    [fs,gof] = fit(x, y, ['poly' num2str(M)]);
    


    % 多项式系数信息
    wi = zeros(M+1,1);    % 保存多项式系数
    for i = 1 : M
        for j = 1 : length(flip(coeffvalues(fs)))
            cof = flip(coeffvalues(fs));
            wi(j) = cof(j);
        end
    end

    % 模型评估参数信息
    % 残差平方和
    % 均方根误差
    sse = gof.sse;
    rms = gof.rmse;



    %% 绘图
    figure
    
        
    plot(fs, x, y);
    
    ax = gca;
    ax.XAxisLocation = 'origin'; 
    
    ylim([-1.5, 1.5])
   
    
    legend off;
    % 在整个figure底部添加文字
    annotation('textbox', [0 0 1 0.96], 'String', ...
        sprintf('M = %d 残差平方和: , SSE = %.4f 均方根误差: RMS = %.4f', ...
        M, sse, rms), ...
        'HorizontalAlignment', 'center', 'FontSize', 16, 'FontWeight', 'bold', ...
        'FontName', 'TimesRoman', 'EdgeColor', 'none');
   
    
    exportgraphics(gcf, './多项式拟合_训练M6.png', 'Resolution', 300);  % 高分辨率保存
end
    