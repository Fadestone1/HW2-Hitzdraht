excluded_sensors = [6, 10, 12, 17,18,19,21]; % from norm plot

sensor_map = logical(ones(24,1));
for i = 1:24
    if any(excluded_sensors == i)
        sensor_map(i) = 0;
    end
end

tiledlayout(3,1);
sm = sm10;
alfai = 3;
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 2), "-s");
ylabel("RMS")
xlabel("x/c [1]");
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 3), "-s");
yline(0)
ylabel("Schiefe")
xlabel("x/c [1]");
nexttile;
plot(cords(sensor_map), sm(alfai, sensor_map, 4), "-s");
yline(0)
ylabel("Kurtosis")
xlabel("x/c [1]");