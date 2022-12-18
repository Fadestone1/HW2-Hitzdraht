v = v15;
alfai = 2;
sens1 = 7;
sens2 = 8;

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
previdx = zeroidx;%find(TF(1:zeroidx), 1, "last");
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
