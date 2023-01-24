function printstat(v, i, j)

%assuming time data in last pos
dim = length(size(v));

if length(size(v)) == 3
    vl = v(i, j, :);
elseif length(size(v)) == 2
    vl = v(j, :);
end
vs = vl - mean(vl, dim);

fprintf("Sensor %d at alpha %d°\n", j, (i-1)*2);
fprintf("Mean \t\t%f\n", mean(vl, dim));
fprintf("RMS \t\t%f\n", rms(vs - mean(vl, dim), dim));
fprintf("Skewness \t%f\n", skewness(vs, 1, dim));
fprintf("Kurtosis \t%f\n", kurtosis(vs, 1, dim));

end