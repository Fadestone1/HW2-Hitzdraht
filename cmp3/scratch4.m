% constants
nu = 15e-6; % weird online calculator
Ap = 26;
rho = 1.2;
coords = [0,0.0025, 0.02, 0.0415, 0.0535, 0.064, 0.094, 0.125, 0.1625, 0.2095, .3175, .41, .5375, .6575, .7825, .905, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

Ds = [.5e-3, .8e-3, 1e-3];

% functions
dpdx = (psi_means(pos, speed, angle, cidx+1) - psi_means(pos, speed, angle, cidx)) / (coords(cidx+1)-coords(cidx)) / .2;
pp = @(tau) nu / (rho*utau(tau)^3) * dpdx;

utau = @(tau) sqrt(tau / rho);
yp = @(y, tau) utau(tau) * y / nu;
formula = @(yp, K, tau) 2 * (1+pp(tau)*yp) / ( 1 + sqrt(1 + 4*(K*yp)^2 * (1+pp(tau)*yp) * (1 - exp(-yp * sqrt(1+pp(tau)*yp) / Ap))^2));

% lets write the integral so it takes normal space and gives normal space
f = @(X, yp) utau(X(1)) * deval(ode45(@(yp, y) formula(yp * utau(X(1)) / nu, X(2), X(1)), [0,yEff], 0), yEff)';

% optimize
yEff = [Ds/2*1.3];
uMess = [sqrt(sensor_means(pos, speed, angle, :) * 2 / rho)];

K = .2;
tau =  .1;
X = [tau, K];

[X,resNorm,res] = lsqcurvefit(f, X, yEff', squeeze(uMess), [.0000000001,1], [.0000000001,1]);