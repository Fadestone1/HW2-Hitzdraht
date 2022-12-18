figure('Name', 'Before normalization')
tiledlayout(4, 6);
for i=1:24
    nexttile
    disp(i+"/"+24)
    histogram(v0(i,:), 20,'BinWidth',.005)
    xlim([-.1, .1])
    title("Sensor "+i)
end

figure('Name', 'After normalization')
tiledlayout(4, 6);
for i=1:24
    nexttile
    disp(i+"/"+24)
    histogram(v0_normed(i,:), 20,'BinWidth',.2)
    xlim([-2, 2])
    title("Sensor "+i)
end