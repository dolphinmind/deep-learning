% 定义 x 范围
x = linspace(-1, 1, 1000);

% 设置高斯基函数个数
num_basis = 6;

% 设置每个高斯函数的中心位置（等间距）
mu = linspace(-1, 1, num_basis);

% 设置标准差（你可以调小/调大以控制重叠）
sigma = 0.2;

% 新建图像
figure; hold on; grid on;
title('高斯基函数', 'FontSize', 18, 'FontWeight', 'bold', 'FontName', 'TimesRoman');
xlabel('x'); ylabel('\phi_k(x)');
colors = lines(num_basis);
legend_entries = cell(num_basis, 1);

% 绘制每一个高斯基函数
for k = 1:num_basis
    phi = exp(-((x - mu(k)).^2) / (2 * sigma^2));
    plot(x, phi, 'LineWidth', 2, 'Color', colors(k,:));
    legend_entries{k} = ['\mu = ', num2str(mu(k), '%.2f')];
end

legend(legend_entries, 'Location', 'northeast');
exportgraphics(gcf, '高斯基函数.png', 'Resolution', 300);  % 高分辨率保存
