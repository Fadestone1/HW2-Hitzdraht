addpath("util")

alfas = 0:2:8;

% load pressures
p_dyn10 = zeros(5, 1);
p_dyn15 = zeros(5, 1);
p_dyn20 = zeros(5, 1);

v10 = zeros(5, 24, 10000);
v15 = zeros(5, 24, 10000);
v20 = zeros(5, 24, 10000);

cords = zeros(24);

folder_path = "data/";

% load offset measurement
p_dyn0 = readmatrix("data/u15_a08.dat", ...
    'DecimalSeparator', ',', 'Range', [1 9 1 9], ...
    'Delimiter',{'\t',' '});
v0 = readmatrix("data/Offset.dat", 'Range', 3)';

for i = 1:5
    % u = 10
    name = folder_path + "u10_a" + num2str((i-1)*2, '%02.f')+".dat";
    p_dyn10(i) = readmatrix(name, ...
    'DecimalSeparator', ',', 'Range', [1 9 1 9], ...
    'Delimiter',{'\t',' '});
    v10(i,:,:) = readmatrix(name, 'Range', 3)';
    
    % u = 15
    name = folder_path + "u15_a" + num2str((i-1)*2, '%02.f')+".dat";
    p_dyn15(i) = readmatrix(name, ...
    'DecimalSeparator', ',', 'Range', [1 9 1 9], ...
    'Delimiter',{'\t',' '});
    v15(i,:,:) = readmatrix(name, 'Range', 3)';
        
    % u = 20
    name = folder_path + "u20_a" + num2str((i-1)*2, '%02.f')+".dat";
    p_dyn20(i) = readmatrix(name, ...
    'DecimalSeparator', ',', 'Range', [1 9 1 9], ...
    'Delimiter',{'\t',' '});
    v20(i,:,:) = readmatrix(name, 'Range', 3)';
end

cords = readmatrix(folder_path+'coords.dat');
cords = cords(:,2);

clear folder_path i name

run("stats.m");