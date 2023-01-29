im_a = read(Tiff("data/vp1a.tif"));
im_b = read(Tiff("data/vp1b.tif"));

% im_a = [0,0,0,0;
%     0,0,0,0;
%     0,0,0,0;
%     0,0,0,0];
% im_b = [0,0,0,0;
%     0,0,0,0;
%     0,0,0,0;
%     0,0,0,0];


imsize = size(im_a);
regionsize = 24;

li = (regionsize):regionsize:imsize(1);
lj = (regionsize):regionsize:imsize(2);

Rs = zeros(length(li), length(lj), regionsize*2-1, regionsize*2-1);
Vs = zeros(length(li), length(lj), 2);

count_i = 1;
for i=li
    count_j = 1;
    for j=lj
        slice_i = (i-regionsize+1):i;
        slice_j = (j-regionsize+1):j;
        C = xcorr2(im_a(slice_i, slice_j), im_b(slice_i, slice_j));
        Rs(count_i, count_j, :, :) = C;
        [~,column] = max(max(C));
        [~,row] = max(C(:,column));
        Vs(count_i, count_j, :) = [-(column-regionsize); -(row-regionsize)];
        count_j = count_j + 1;
    end
    count_i = count_i + 1;
end

%% vector field plot
x = repmat((li-regionsize/2)', [1,length(lj)]);
y = repmat(lj-regionsize/2, [length(li), 1]);
u = squeeze(Vs(:, :, 1));
v = squeeze(Vs(:, :, 2));

figure(1);
quiver(x, y, u, v, 0.7);
set(gca, 'YDir', 'reverse')
xlabel("x [px]")
ylabel("y [px]")

axis("equal")
xlim([1,512]);
ylim([1,480]);

exportgraphics(gcf(), "figures/cross_quiver.pdf");

%% region plot
showx = round(imsize(1)/regionsize*.4);
showy = round(imsize(1)/regionsize*.5);
figure(2)
colormap(cividis)
contourf(squeeze(Rs(showx, showy, :, :)))
hold on

xline(regionsize)
yline(regionsize)

%quiver(regionsize, regionsize,-Vs(showx, showy, 1), -Vs(showx, showy, 2), 0, "k")
c = colorbar();
c.Label.String = "Korrelation";

xlabel("Lags x [px]")
ylabel("Lags y [px]")
set(gca, 'YDir', 'reverse')
axis("equal")
hold off
exportgraphics(gcf(), "figures/cross_region_curf.pdf");

figure(3);
%tiledlayout(1,2);
%nexttile;
%slice_i = (showi*regionsize-regionsize+1):showi*regionsize;
%slice_j = (showj*regionsize-regionsize+1):showj*regionsize;
colormap(eclipse)
starti = showx*regionsize-regionsize+1;
stopi = showx*regionsize;
startj = showy*regionsize-regionsize+1;
stopj = showy*regionsize;
imagesc(1:512, 1:480, im_a);
xline(starti, "r-");
xline(stopi, "r-");
yline(startj, "r-");
yline(stopj, "r-");

axis("equal")
xlim([0,512])
ylim([0,480])

exportgraphics(gcf(), "figures/cross_image_a.pdf");

figure(4)
colormap(eclipse)
starti = showx*regionsize-regionsize+1;
stopi = showx*regionsize;
startj = showy*regionsize-regionsize+1;
stopj = showy*regionsize;
imagesc(1:512, 1:480, im_b);
xline(starti, "r-");
xline(stopi, "r-");
yline(startj, "r-");
yline(stopj, "r-");

axis("equal")
xlim([0,512])
ylim([0,480])

exportgraphics(gcf(), "figures/cross_image_b.pdf");