%% calibration

%time_data = readmatrix("data/"+name, 'DecimalSeparator', ',', 'Range', [4, 1, 5000, 32]);
%data = readmatrix("data/"+name, "DecimalSeparator", ",", "Range", [4, 2, 5000, 4]);

pressure_names = ["0", "50", "100", "150", "200", "250"];
pressures = [0, 50, 100, 150, 200, 250];

psi_means = zeros(length(pressure_names), 28);
sensor_volts = zeros(length(pressure_names), 3, 3000);
sensor_volts_means = zeros(length(pressure_names), 3);
p_dyns = zeros(length(pressure_names), 1);

for i=1:length(pressure_names)
    name = pressure_names(i);
    psi = readmatrix("data/KAL_PSI_"+name +"_Pa_time.dat", 'DecimalSeparator', ',', 'Range', [4, 1, 5000, 32]);
    hcl = readmatrix("data/KAL_HCL_"+name+"_Pa.dat", "DecimalSeparator", ",", "Range", [4, 1, 5000, 4]);

    psi_mean = mean(psi, 1);
    psi_means(i, :) = psi_mean(1:28);
    p_dyns(i) = psi_mean(32);
    sensor_volts(i, :, :) = hcl';
    sensor_volts_means(i, :) = mean(hcl, 1);
end
