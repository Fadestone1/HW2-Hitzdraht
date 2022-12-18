sm0 = zeros(24, 4);
sm10 = zeros(5, 24, 4);
sm15 = zeros(5, 24, 4);
sm20 = zeros(5, 24, 4);

% means
sm0(:,1) = mean(v0, 2);
sm10(:,:,1) = mean(v10, 3);
sm15(:,:,1) = mean(v15, 3);
sm20(:,:,1) = mean(v20, 3);

% rms
sm0(:,2) = rms(v0, 2);
sm10(:,:,2) = rms(v10, 3);
sm15(:,:,2) = rms(v15, 3);
sm20(:,:,2) = rms(v20, 3);

% skewness
sm0(:,3) = skewness(v0, 1, 2);
sm10(:,:,3) = skewness(v10, 1, 3);
sm15(:,:,3) = skewness(v15, 1, 3);
sm20(:,:,3) = skewness(v20, 1, 3);

% kurtosis
sm0(:,4) = kurtosis(v0, 1, 2);
sm10(:,:,4) = kurtosis(v10, 1, 3);
sm15(:,:,4) = kurtosis(v15, 1, 3);
sm20(:,:,4) = kurtosis(v20, 1, 3);
