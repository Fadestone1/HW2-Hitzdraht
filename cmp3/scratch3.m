
%K = .3;
%tau =  .6;
speed = 2;
pos = 2;
angle = 1;
lr = .0001;

Ds = [.5e-3, .8e-3, 1e-3];
yEff = [Ds/2*1.3];

%X = [.3, .6];

close all;

uMess = [sqrt(sensor_means(pos, speed, angle, :) * 2 / rho)];
%uMessp = [[0]; [sqrt(squeeze(sensor_means(pos, speed, angle, :)) * 2 / rho)] / utau(tau)]';

err = 100;
dwp = [0,0];
for i=1:10000
    % get error from X
    f = @(X) ode45(@(yp, y) formula(yp, X(2), X(1)), [[0],yEff * utau(tau) / nu], 0);
    [t,u_out] = f(X);
    u_out = u_out(2:end);
    err = sum(((squeeze(u_out) - squeeze(uMess) / utau(X(1))).^2));
    
    dtau = [1e-7,0];
    [t,u_out] = f(X+dtau);
    u_out = u_out(2:end);
    err_tau = sum((u_out - squeeze(uMess) / utau(X(1))).^2);
    dErr_dtau = (err_tau-err) / dtau(1);
    
    dK = [0,1e-7];
    [t,u_out] = f(X+dK);
    u_out = u_out(2:end);
    err_K = sum((u_out - squeeze(uMess) / utau(X(1))).^2);
    dErr_dK = (err_K-err) / dK(2);
    
    dErr_dX = [dErr_dtau, dErr_dK];

    dw = dErr_dX * lr + .1*dwp;
    X = X - dErr_dX * lr + .1*dwp;
    %dwp = dw;

    if X(2)> 1
         X(2) = 1;
         disp("K 1 warn")
     end
    disp(err)
end

% derive by tau and K