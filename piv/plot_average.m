xshifts = [24, 23.8, 24, 24, 23.8, 24];
yshifts = [23, 28, 31.5, 23, 28, 31.5];
alphas = [6, 12, 15, 6, 12, 15];
us = [10, 10, 10, 20, 20, 20];
paramidx = 6;

alphadeg = alphas(paramidx);
alpharad = -deg2rad(alphadeg);
param = "u"+us(paramidx)+"i"+alphadeg;

idx = 100;
mask = u.(param)(:,:,100) == 0;

h = (1:159) * 0 - 50;
for i=1:159
    row = squeeze(mask(:, i));
    for j=length(row):-1:1
        if row(j)
            h(i) = j;
            break;
        end
    end
end
h = flip(h)*1.005;

xl = x.(param);
xl = xl(1, :);

yl = y.(param);
yl = yl(:, 1);

xtim = linspace(0,1,1000);

ytim = 5 * .15 * (0.2969 * sqrt(xtim) - 0.1260 * xtim - 0.3516 * xtim.^2 + 0.2843 * xtim.^3 - 0.1015 * xtim.^4 );
xtim = xtim*200;
ytim = ytim * 200;

%cos(alpharad)*xtim-sin(alpharad)*y_u, sin(alpharad)*xtim+cos(alpharad)*y_u
xoffset = -54.0-200+xshifts(paramidx);
yoffset = 108.4+yshifts(paramidx);

xtimrot = xtim - 200*.12;
xtimrot_l = cos(alpharad)*xtim-sin(alpharad)*(-ytim) + xoffset - 200*.12*cos(alpharad);
xtimrot_u = cos(alpharad)*xtim-sin(alpharad)*(ytim) + xoffset - 200*.12*cos(alpharad);

ytimrot_l =  sin(alpharad)*xtim+cos(alpharad)*(-ytim) + yoffset;
ytimrot_u =  sin(alpharad)*xtim+cos(alpharad)*(ytim) + yoffset;

climsu = [-22, 22];
climsv = [-13, 13];
figure(1)
tiledlayout(2, 2);
nexttile
utmp = u.(param);
utmp(isnan(utmp)) = -inf;
imagesc(xl, yl, fliplr(-utmp(:,:,idx)))
hold on
fill(cat(2, linspace(min(xl), max(xl)*1.01, length(xl)), min(xl)), cat(2, h/length(yl)*(max(yl)-min(yl))+min(yl), min(yl)), "k")
plot(xtimrot_l, ytimrot_l, "w-");
plot(xtimrot_u, ytimrot_u, "w-");
set(gca(), "YDir", "normal");
axis("equal")
xlim([min(xl), max(xl)])
ylim([min(yl), max(yl)])
colormap(turbo)
cb = colorbar();
cb.Label.String = "u [m/s]";
clim(climsu)
ylabel('y [mm]')
title('Instantaneous velocity')

nexttile
imagesc(xl, yl, fliplr(-v.(param)(:,:,idx)))
set(gca(), "YDir", "normal")
hold on
fill(cat(2, linspace(min(xl), max(xl)*1.01, length(xl)), min(xl)), cat(2, h/length(yl)*(max(yl)-min(yl))+min(yl), min(yl)), "k")
plot(xtimrot_l, ytimrot_l, "w-");
plot(xtimrot_u, ytimrot_u, "w-");
set(gca(), "YDir", "normal");
axis("equal")
xlim([min(xl), max(xl)])
ylim([min(yl), max(yl)])
colormap(turbo)
clim(climsv)
cb = colorbar();
cb.Label.String = "v [m/s]";
title('Instantaneous velocity')

nexttile;
imagesc(xl, yl, fliplr(-mean(u.(param), 3)))
set(gca(), "YDir", "normal")
hold on
fill(cat(2, linspace(min(xl), max(xl)*1.01, length(xl)), min(xl)), cat(2, h/length(yl)*(max(yl)-min(yl))+min(yl), min(yl)), "k")
plot(xtimrot_l, ytimrot_l, "w-");
plot(xtimrot_u, ytimrot_u, "w-");
set(gca(), "YDir", "normal");
axis("equal")
xlim([min(xl), max(xl)])
ylim([min(yl), max(yl)])
colormap(turbo)
clim(climsu)
cb = colorbar();
cb.Label.String = "u [m/s]";
ylabel('y [mm]')
xlabel('x [mm]')
title('Mean velocity')

nexttile;
imagesc(xl, yl, fliplr(mean(v.(param), 3)))
set(gca(), "YDir", "normal")
hold on
fill(cat(2, linspace(min(xl), max(xl)*1.01, length(xl)), min(xl)), cat(2, h/length(yl)*(max(yl)-min(yl))+min(yl), min(yl)), "k")
plot(xtimrot_l, ytimrot_l, "w-");
plot(xtimrot_u, ytimrot_u, "w-");
set(gca(), "YDir", "normal");
axis("equal")
xlim([min(xl), max(xl)])
ylim([min(yl), max(yl)])
colormap(turbo)
clim(climsv)
cb = colorbar();
cb.Label.String = "v [m/s]";
xlabel('x [mm]')
title('Mean velocity')

exportgraphics(gcf(), "figures/joshs" + param + ".pdf")