% 定义 x 范围
x = linspace(-1, 1, 1000);

% 设置 Sigmoid 基函数数量
num_basis = 9;

% 设置每个 sigmoid 的中心
centers = linspace(-1, 1, num_basis);

% 设置斜率
a = 10;

% 颜色设置
colors = lines(num_basis);

% 开始绘图
figure; hold on; grid on;
title('Sigmoid 基函数','FontSize', 18, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
xlabel('x'); ylabel('\phi_k(x)');
legend_entries = cell(num_basis, 1);

for k = 1:num_basis
    phi = 1 ./ (1 + exp(-a * (x - centers(k))));
    plot(x, phi, 'LineWidth', 2, 'Color', colors(k,:));
    legend_entries{k} = ['b = ', num2str(centers(k), '%.2f')];
end

legend(legend_entries, 'Location', 'southeast');
exportgraphics(gcf, 'Sigmoid激活函数.png', 'Resolution', 300);  % 高分辨率保存