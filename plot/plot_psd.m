excluded_sensors = [6, 10, 12, 17,18,19,21];
v = v10;

%v = v - mean(v, 3); % it doesnt matter if we take psd of signal or
%schwankungsanteil of signal

alfai = 2;
sensor = 20;
fs = 10000;

if any(excluded_sensors == sensor)
    warning("check sensor number.")
end

figure(2)
[PSD, F0] = pwelch(squeeze(v(alfai, sensor,:)), 256, [], [], fs);

loglog(F0, PSD)
xlabel("f [Hz]")
ylabel("PSD")