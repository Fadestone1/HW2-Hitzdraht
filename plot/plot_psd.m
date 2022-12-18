%v = v - mean(v, 3); % it doesnt matter if we take psd of signal or
%schwankungsanteil of signal
fs = 10000;
window = 256;

% if any(excluded_sensors == sensor)
%     warning("check sensor number.")
% end

f=figure(9);
f.Position(4) = f.Position(2) - 280;
clf
v = v10;
alfai = 4;
sensors = [1,5,7];

[PSD1, F0] = pwelch(squeeze(v(alfai, sensors(1),:)), window, [], [], fs);
[PSD2, F0] = pwelch(squeeze(v(alfai, sensors(2),:)), window, [], [], fs);
[PSD3, F0] = pwelch(squeeze(v(alfai, sensors(3),:)), window, [], [], fs);
loglog(F0, PSD1, F0, PSD2, F0, PSD3);
[~,idx] = max(PSD2(10:end));
idx = idx + 9;
%xline(F0(idx), label=sprintf("%.f Hz",F0(idx)), LabelOrientation="horizontal")
legend(["Sensor "+sensors(1), "Sensor "+sensors(2), "Sensor "+sensors(3)], Location="northwest")
xlim([0,5000])
xlabel("f [Hz]")
ylabel("PSD")
exportgraphics(gcf,"figures/psd_10_alpha_"+(alfai-1)*2+".pdf",'ContentType','vector')

f=figure(10);
f.Position(4) = f.Position(2) - 280;
clf
v = v15;

[PSD1, F0] = pwelch(squeeze(v(alfai, sensors(1),:)), window, [], [], fs);
[PSD2, F0] = pwelch(squeeze(v(alfai, sensors(2),:)), window, [], [], fs);
[PSD3, F0] = pwelch(squeeze(v(alfai, sensors(3),:)), window, [], [], fs);
loglog(F0, PSD1, F0, PSD2, F0, PSD3);%, F0, PSD2, F0, PSD3);
[~,idx] = max(PSD2(10:end));
idx = idx + 9;
%xline(F0(idx), label=sprintf("%.f Hz",F0(idx)), LabelOrientation="horizontal")
legend(["Sensor "+sensors(1), "Sensor "+sensors(2), "Sensor "+sensors(3)], Location="northwest")
xlim([0,5000])
xlabel("f [Hz]")
ylabel("PSD")
exportgraphics(gcf,"figures/psd_15_alpha_"+(alfai-1)*2+".pdf",'ContentType','vector')

f=figure(11);
f.Position(4) = f.Position(2) - 280;
clf
v = v20;
%alfai = 5;

[PSD1, F0] = pwelch(squeeze(v(alfai, sensors(1),:)), window, [], [], fs);
[PSD2, F0] = pwelch(squeeze(v(alfai, sensors(2),:)), window, [], [], fs);
[PSD3, F0] = pwelch(squeeze(v(alfai, sensors(3),:)), window, [], [], fs);
loglog(F0, PSD1, F0, PSD2, F0, PSD3);%, F0, PSD2, F0, PSD3);
[~,idx] = max(PSD2(10:end));
idx = idx + 9;
%xline(F0(idx), label=sprintf("%.f Hz",F0(idx)), LabelOrientation="horizontal")
legend(["Sensor "+sensors(1), "Sensor "+sensors(2), "Sensor "+sensors(3)], Location="northwest")
xlim([0,5000])
xlabel("f [Hz]")
ylabel("PSD")
exportgraphics(gcf,"figures/psd_20_alpha_"+(alfai-1)*2+".pdf",'ContentType','vector')