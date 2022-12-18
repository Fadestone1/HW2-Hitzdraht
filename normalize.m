% IMPORTANT do not execute script more than once, it should only be run
% implicitly be the load function

% gotta normalize the data somehow
% normalize the data so that mean=0 and rms=1 for the v=0 measurements

% idea that data is reynolds zerlegung of data and we can manipulate the
% mean and amplitude independently
offset = -mean(v0, 2);
amp = 1 ./ rms(v0-mean(v0, 2), 2);

fnorm = @(X) amp'.*(X - mean(X, 3)) + mean(X, 3) + offset';

v0_normed = amp.*(v0 - mean(v0, 2) + mean(v0, 2) + offset);

% all other data shall only be used in normed form
v10 = fnorm(v10);
v15 = fnorm(v15);
v20 = fnorm(v20);