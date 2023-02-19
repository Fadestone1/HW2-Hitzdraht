nu = 15e-6; % weird online calculator
Ap = 26;
rho = 1.2;
coords = [0,0.0025, 0.02, 0.0415, 0.0535, 0.064, 0.094, 0.125, 0.1625, 0.2095, .3175, .41, .5375, .6575, .7825, .905, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];


global pos
global speed
global angle
global psi_means;

pos = 3;
speed = 2;
angle = 2;
positions = [.21, .32, .41];
Ds = [.5e-3, .8e-3, 1e-3];
[~, cidx] = min(abs(coords - positions(pos)));
dpdx = (psi_means(pos, speed, angle, cidx+1) - psi_means(pos, speed, angle, cidx)) / (coords(cidx+1)-coords(cidx)) / .2;
pp = @(tau) nu / (rho*utau(tau)^3) * dpdx;

utau = @(tau) sqrt(tau / rho);
yp = @(y, tau) utau(tau) * y / nu;
formula = @(yp, K, tau) 2 * (1+pp(tau)*yp) / ( 1 + sqrt(1 + 4*(K*yp)^2 * (1+pp(tau)*yp) * (1 - exp(-yp * sqrt(1+pp(tau)*yp) / Ap))^2));

umess = [sqrt(sensor_means(pos, speed, angle, :) * 2 / rho)];

K = 1;
tau = .5;
X = [tau, K];
for i=1:100
    disp(i)
    X = [tau, K];
    yEff = [[1], [Ds/2*1.3]];
    yEffp = yEff * utau(tau) / nu;
    uMessp = [[0]; [sqrt(squeeze(sensor_means(pos, speed, angle, :)) * 2 / rho)] / utau(tau)]';
    integral = @(X, ypi) ode45(@(yp, y) formula(yp, X(2), X(1)), [[0],ypi], 0);
    [X,resNorm,res] = lsqcurvefit(@subodecpm3, [tau, K], yEffp, uMessp, [.0000000001,1], [.0000000001,1]);
    K = X(2);
    tau = X(1);
    disp(resNorm)
end