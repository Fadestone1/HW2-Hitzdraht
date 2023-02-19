K = .4;
tau =  .7;

pos = 3;
speed = 2;
angle = 2;

X = [tau, K];
close all;
Ds = [.5e-3, .8e-3, 1e-3];
yEff = [[Ds/2*1.3]];
yEffp = yEff * utau(tau) / nu;
uMessp = [[sqrt(squeeze(sensor_means(pos, speed, angle, :)) * 2 / rho)] / utau(tau)]';

formula = @(yp, K, tau) 2 * (1+pp(tau)*yp) / ( 1 + sqrt(1 + 4*(K*yp)^2 * (1+pp(tau)*yp) * (1 - exp(-yp * sqrt(1+pp(tau)*yp) / Ap))^2));
int = @(yp, X) ode45(@(yp, y) formula(yp, X(2), X(1)), [[0],sort(yEffp)], 0);

hold on
scatter(yEffp, uMessp);
ode45(@(yp, y) formula(yp, X(2), X(1)), [[0],sort(yEffp)], 1)

legend(["Messpunkte y_{eff,i}^+", "Fit nach Modell"], Location="northwest")
xlabel("y^+")
ylabel("u^+")

exportgraphics(gcf(), "figures/handfit.pdf")