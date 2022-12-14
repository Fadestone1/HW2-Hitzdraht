function [sm1, sm2, sm3, sm4] = fstat(m, dim)
% FSTAT return first 4 standard moments along last dimension
if ~exist("dim")
    dim = length(size(m));
end

ms = m - mean(m, dim);

sm1 = mean(m, dim);
sm2 = rms(ms, dim);
sm3 = skewness(ms, 1, dim);
sm4 = kurtosis(ms, 1, dim)-3;
end

