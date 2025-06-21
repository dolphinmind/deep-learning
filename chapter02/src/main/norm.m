x = linspace(0, 5, 1000);
mu = 2.5; sigma = 1;

% 标准正态分布的 PDF 和 CDF
pdf_original = normpdf(x, mu, sigma);
cdf_original = normcdf(x, mu, sigma);

% 截断点的 CDF 值（这里是0点）
cdf_0 = normcdf(0, mu, sigma);

% 截断正态分布的 PDF 和 CDF
pdf_vals = pdf_original ./ (1 - cdf_0);
cdf_vals = (cdf_original - cdf_0) ./ (1 - cdf_0);

% 绘图
figure;
yyaxis left;
plot(x, pdf_vals, 'b-', 'LineWidth', 2);
ylabel('截断正态分布 PDF');
ylim([0 max(pdf_vals)*1.1]);

yyaxis right;
plot(x, cdf_vals, 'r--', 'LineWidth', 2);
ylabel('截断正态分布 CDF');
ylim([0 1.05]);

title('截断正态分布的 PDF 与 CDF (x \geq 0)');
xlabel('x');
legend('PDF','CDF');
grid on;
