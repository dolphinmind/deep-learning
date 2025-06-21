t = linspace(0, 1, 1000);

% 尺度函数 phi(t)
phi = double(t >= 0 & t < 1);

% 母小波函数 psi(t)
psi = double(t >= 0 & t < 0.5) - double(t >= 0.5 & t < 1);

figure;
subplot(2,1,1);
plot(t, phi, 'LineWidth', 2);
title('Haar尺度函数 \phi(t)');
ylim([-0.2, 1.2]);
grid on;

subplot(2,1,2);
plot(t, psi, 'LineWidth', 2);
title('Haar母小波函数 \psi(t)');
ylim([-1.2, 1.2]);
grid on;
