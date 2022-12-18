sensor_map = true(24,1);
for i = 1:24
    if any(excluded_sensors == i)
        sensor_map(i) = 0;
    end
end

alfai = 4;
f=figure(4);
f.Position(3) = f.Position(1) - 319;
tiledlayout(3,1);
sm = sm10;

t=nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 2), "-s");
ylabel("RMS")
xlim([.25, .7])
xlabel("x/c [1]");
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 3), "-s");
yline(0)
xlim([.25, .7])
ylabel("Schiefe")
xlabel("x/c [1]");
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 4), "-s");
yline(0)
xlim([.25, .7])
ylabel("Kurtosis")
xlabel("x/c [1]");
exportgraphics(gcf,"figures/stats_10_alpha_"+(alfai-1)*2+".pdf",'ContentType','vector')
title(t, "alpha=" + (alfai-1)*2 + "°")

f=figure(5);
f.Position(3) = f.Position(1) - 319;
tiledlayout(3,1);
sm = sm15;

t=nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 2), "-s");
ylabel("RMS")
xlim([.25, .7])
xlabel("x/c [1]");
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 3), "-s");
yline(0)
xlim([.25, .7])
ylabel("Schiefe")
xlabel("x/c [1]");
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 4), "-s");
yline(0)
xlim([.25, .7])
ylabel("Kurtosis")
xlabel("x/c [1]");
exportgraphics(gcf,"figures/stats_15_alpha_"+(alfai-1)*2+".pdf",'ContentType','vector')
title(t, "alpha=" + (alfai-1)*2 + "°")

f=figure(6);
f.Position(3) = f.Position(1) - 319;
tiledlayout(3,1);
sm = sm20;

t=nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 2), "-s");
ylabel("RMS")
xlim([.25, .7])
xlabel("x/c [1]");
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 3), "-s");
yline(0)
xlim([.25, .7])
ylabel("Schiefe")
xlabel("x/c [1]");
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 4), "-s");
yline(0)
xlim([.25, .7])
ylabel("Kurtosis")
xlabel("x/c [1]");
exportgraphics(gcf,"figures/stats_20_alpha_"+(alfai-1)*2+".pdf",'ContentType','vector')
title(t, "alpha=" + (alfai-1)*2 + "°")