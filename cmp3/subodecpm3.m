function [output] = subodecpm3(X, ypi)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
global speed
global pos
global angle
global psi_means

nu = 15e-6; % weird online calculator
Ap = 26;
rho = 1.2;
coords = [0,0.0025, 0.02, 0.0415, 0.0535, 0.064, 0.094, 0.125, 0.1625, 0.2095, .3175, .41, .5375, .6575, .7825, .905, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

positions = [.21, .32, .41];
Ds = [.5e-3, .8e-3, 1e-3];

[~, cidx] = min(abs(coords - positions(pos)));

dpdx = (psi_means(pos, speed, angle, cidx+1) - psi_means(pos, speed, angle, cidx)) / (coords(cidx+1)-coords(cidx)) / .2;

utau = @(tau) sqrt(tau / rho);
pp = @(tau) nu / (rho*utau(tau)^3) * dpdx;

yp = @(y, tau) utau(tau) * y / nu;

formula = @(yp, K, tau) 2 * (1+pp(tau)*yp) / ( 1 + sqrt(1 + 4*(K*yp)^2 * (1+pp(tau)*yp) * (1 - exp(-yp * sqrt(1+pp(tau)*yp) / Ap))^2));

[B, I] = sort(ypi);
[~,J] = sort(I);
integral = @(X, ypi) ode45(@(yp, y) formula(yp, X(2), X(1)), [[0],ypi], 0);
[t,y] = integral(X, B);

y = y(2:end);
output = y(J)';
end

