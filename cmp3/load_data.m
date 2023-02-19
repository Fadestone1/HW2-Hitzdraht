%% calibration

%time_data = readmatrix("data/"+name, 'DecimalSeparator', ',', 'Range', [4, 1, 5000, 32]);
%data = readmatrix("data/"+name, "DecimalSeparator", ",", "Range", [4, 2, 5000, 4]);

pressure_names = ["0", "50", "100", "150", "200", "250"];
pressures_cal = [0, 50, 100, 150, 200, 250];

psi_cal_means = zeros(length(pressure_names), 28);
sensor_volts_cal = zeros(length(pressure_names), 3, 3000);
sensor_volts_cal_means = zeros(length(pressure_names), 3);
p_dyns_cal = zeros(length(pressure_names), 1);

for i=1:length(pressure_names)
    name = pressure_names(i);
    psi = readmatrix("data/KAL_PSI_"+name +"_Pa_time.dat", 'DecimalSeparator', ',', 'Range', [4, 1, 5000, 32]);
    hcl = readmatrix("data/KAL_HCL_"+name+"_Pa.dat", "DecimalSeparator", ",", "Range", [4, 1, 5000, 4]);

    psi_mean = mean(psi, 1);
    psi_cal_means(i, :) = psi_mean(1:28);
    p_dyns_cal(i) = psi_mean(32);
    sensor_volts_cal(i, :, :) = hcl';
    sensor_volts_cal_means(i, :) = mean(hcl, 1);
end
mdl1 = fitlm(-pressures_cal, sensor_volts_cal_means(:, 1));
mdl2 = fitlm(-pressures_cal, sensor_volts_cal_means(:, 2));
mdl3 = fitlm(-pressures_cal, sensor_volts_cal_means(:, 3));

fit1 = @(y) (y-mdl1.Coefficients.Estimate(1))/mdl1.Coefficients.Estimate(2);
fit2 = @(y) (y-mdl2.Coefficients.Estimate(1))/mdl2.Coefficients.Estimate(2);
fit3 = @(y) (y-mdl3.Coefficients.Estimate(1))/mdl3.Coefficients.Estimate(2);

psi_means = zeros(3, 2, 2, 28);
p_dyns = zeros(3, 2, 2, 1);
sensors = zeros(3, 2, 2, 3, 3000); % positions, speeds, angles, sensors, time
sensor_means = zeros(3,2,2,3,1);
speeds = zeros(3,2,2,1);
for pos=1:3
    cu = 1;
    for u=[10,20]
        ca = 1;
        for ang=[0,6]
            name = "_P"+pos+"_u"+u+"_a0"+ang;
            psi = readmatrix("data/Messung/PSI"+name+"_time.dat", 'DecimalSeparator', ',', 'Range', [4, 1, 5000, 32]);
            hcl = readmatrix("data/Messung/HCL"+name+".dat", "DecimalSeparator", ",", "Range", [4, 1, 5000, 4]);

            psi_mean = mean(psi, 1);
            psi_means(pos, cu, ca, :) = psi_mean(1:28);
            p_dyns(pos, cu, ca) = psi_mean(32);
            speeds(pos, cu, ca) = sqrt(2*psi_mean(32) / 1.2);

            pressures = [fit1(hcl(:,1)), fit2(hcl(:,2)), fit3(hcl(:,3))];
            
            sensors(pos, cu, ca, :, :) = pressures';
            sensor_means(pos, cu, ca, :, :) = mean(pressures, 1);
            ca = ca+1;
        end
        cu = cu + 1;
    end
end

% do the stupid
% for pos=1:3
%     cu = 1;
%     for u=[10,20]
%         ca = 1;
%         for ang=[0,6]
% 
%             ca = ca+1;
%         end
%         cu = cu + 1;
%     end
% % end
% u_mess = [0 15];
% yeff = d/2 * K
% subode = @(t,k) ode45(@(t,k) , tspan, y0);
% %p+?
% [X,resNorm,res] = lsqcurvefit(@subOdeCPM3, X0, yEff, uMess, [LL1 LL2], [UL1 UL2]);