% 定义 x 范围
x = linspace(-1, 1, 1000);

% 设置最大幂次
max_order = 9;

% 颜色映射（可选）
colors = lines(max_order);

% 新建图像
figure; hold on; grid on;
title('多项式基函数','FontSize', 18, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
xlabel('x'); ylabel('y');
legend_entries = cell(max_order, 1);

% 绘制每一个幂函数
for n = 1:max_order
    y = x.^n;
    plot(x, y, 'LineWidth', 2, 'Color', colors(n,:));
    legend_entries{n} = ['x^', num2str(n)];
end

legend(legend_entries, 'Location', 'southeast');

exportgraphics(gcf, '多项式基函数.png', 'Resolution', 300);  % 高分辨率保存