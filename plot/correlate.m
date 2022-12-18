v = v20;
alfai = 3;
sens1 = 4;
sens2 = 5;

if any(sens1 == excluded_sensors) || any(sens2 == excluded_sensors)
    warning("Check sensor numbers.")
end

A = squeeze(v(alfai, sens1, :));
B = squeeze(v(alfai, sens2, :));

f2 = 10000;
[c,lags] = xcorr(A,B);

xl = lags / f2 * 1000;
yl = c/max(c);
TF = islocalmax(c, MinSeparation=2);

Dx = cords(sens2) - cords(sens1);
zeroidx = find(xl==0, 1);
previdx = zeroidx;
nextidx = find(TF(zeroidx+1:end), 1)+zeroidx;
maxtimes = xl(TF);
Dt = (lags(nextidx)-lags(previdx))/f2;

figure(5)
plot(xl, yl, xl(TF), yl(TF), "b*")
xlabel("Zeitversatz \tau [ms]")
xline(xl(previdx));
nextxline = xline(xl(nextidx), label="\Deltat = " + Dt*1000 + " ms");
nextxline.LabelOrientation = "horizontal";
xlim([-5, 5])
fprintf("Konvektionsgeschwindigkeit %f m/s\n",Dx*.2 / Dt);
exportgraphics(gcf,"figures/corr_20_alpha_"+(alfai-1)*2+"_sens"+sens1+"_sens"+sens2+".pdf",'ContentType','vector')