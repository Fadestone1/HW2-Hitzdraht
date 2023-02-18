x = -pressures;
y = -sensor_volts_means(:, 1);
mdl1 = fitlm(x, y);
plot(x, y, "kx");
hold on
plot([x(1), x(end)], mdl.feval([x(1), x(end)]), "k-");

x = -pressures;
y = -sensor_volts_means(:, 2);
mdl2 = fitlm(x, y);
plot(x, y, "bo");
hold on
plot([x(1), x(end)], mdl.feval([x(1), x(end)]), "b--");

x = -pressures;
y = -sensor_volts_means(:, 3);
mdl3 = fitlm(x, y);
plot(x, y, "rs");
hold on
plot([x(1), x(end)], mdl.feval([x(1), x(end)]), "r:");


mdls = {mdl1, mdl2, mdl3};
disp("Sensor 1")