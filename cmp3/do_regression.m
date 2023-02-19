x = -pressures_cal;
y = sensor_volts_cal_means(:, 1);
mdl1 = fitlm(x, y);
plot(x, y, "kx");
hold on
plot([x(1)*.95, x(end)*1.1], mdl1.feval([x(1)*.95, x(end)*1.1]), "kx-");

x = -pressures_cal;
y = sensor_volts_cal_means(:, 2);
mdl2 = fitlm(x, y);
plot(x, y, "bo");
hold on
plot([x(1)*.95, x(end)*1.1], mdl2.feval([x(1)*.95, x(end)*1.1]), "bo--");

x = -pressures_cal;
y = sensor_volts_cal_means(:, 3);
mdl3 = fitlm(x, y);
plot(x, y, "rs");
hold on
plot([x(1)*.95, x(end)*1.1], mdl3.feval([x(1)*.95, x(end)*1.1]), "rs:");

xlim([min(x), max(x)])
legend({"", "Sensor 1", "", "Sensor 2", "", "Sensor 3"})
xlabel("Pressure [Pa]")
ylabel("Voltage [V]")

exportgraphics(gcf(), "figures/regression.pdf")

mdls = {mdl1, mdl2, mdl3};
disp("Sensor 1")
mdl1.disp()

disp("Sensor 2")
mdl2.disp()

disp("Sensor 3")
mdl3.disp()