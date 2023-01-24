f=figure('Name', 'Before normalization')
f.Position(3:4) = f.Position(1:2) + [296,160];

t1=tiledlayout(6,4);
for i=1:24
    nexttile
    histogram(v0(i,:), 20,'BinWidth',.005)
    xlim([-.1, .1])
    yticks([1000]);
    ylim([0,1500]);
    title("Sensor "+i)
end
exportgraphics(gcf,'figures/norm_hists_before.pdf','ContentType','vector')
title(t1, "Before normalization")

f=figure('Name', 'After normalization')
f.Position(3:4) = f.Position(1:2) + [296,160];
title("After normalization")
t2=tiledlayout(6,4);
for i=1:24
    nexttile
    histogram(v0_normed(i,:), 20,'BinWidth',.2)
    yticks([1000]);
    xlim([-2, 2])
    ylim([0,1500]);
    title("Sensor "+i)
end
exportgraphics(gcf,'figures/norm_hists_after_minmax.pdf','ContentType','vector')
title(t2, "After normalization")