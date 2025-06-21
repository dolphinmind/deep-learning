%% 合成数据函数
% 输入参数 dt：采样率，默认值为1
% 输出参数 x, y：采样点和带噪声的正弦数据
function [x, y] = syntheticdata(dt, border)

    % 如果没有输入参数，设置默认采样率
    if nargin < 1
        dt = 1;
    end

    % 生成时间序列
    x = (0:dt:border)';     
    
    % 生成噪声，保证噪声幅度随采样率调整
    noise = randn(size(x)) * 0.1 * sqrt(dt); 
    
    % 生成带噪声的正弦信号
    y = sin(x) + noise;  

    % 绘图部分
    % plot(x, y, 'o', 'MarkerSize', 6, 'MarkerFaceColor', 'b'); % 实心蓝点
    % ax = gca;
    % ax.XAxisLocation = 'origin';
    % 
    % title('合成数据', 'FontSize', 20, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
    % xlabel('时间 (s)', 'FontSize', 16, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
    % ylabel('幅值', 'FontSize', 16, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
    % 
    % saveas(gcf, '合成数据.png');  % 保存图像

end
