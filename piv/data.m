clear
close all
clc

load('data.mat')
%Parameter allowed u10 with i6, 12, 15
%and u20 with i6, 12, 15
param = 'u10i6';

figure(1)
% subplot(3,1,1)
% contourf(x.(param), y.(param), u.(param)(:,:,100), 10,'LineStyle', 'none')
% cMap=jet(256);
% colormap(cMap)
% cb = colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% title('Instantaneous x-velocity')
% 
% subplot(3,1,2)
% contourf(x.(param), y.(param), v.(param)(:,:,100), 10,'LineStyle', 'none')
% cMap=jet(256);
% colormap(cMap)
% cb = colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% title('Instantaneous y-velocity')

subplot(2,1,1)
contourf(x.(param), y.(param), mag.(param)(:,:,100), 10,'LineStyle', 'none')
cMap=jet(256);
colormap(cMap)
cb = colorbar;
ylabel('y [mm]')
xlabel('x [mm]')
title('Instantaneous mag-velocity')

subplot(2,1,2)
mag_ = 0;
u_ = 0;
v_ = 0;
for i = 1:size(mag.(param),3)
    mag_ = mag_ + mag.(param)(:,:,i);
    u_ = u_ + u.(param)(:,:,i);
    v_ = v_ + v.(param)(:,:,i);
end
mag_ = mag_./size(mag.(param),3);
u_ = u_./size(u.(param),3);
v_ = v_./size(v.(param),3);
contourf(x.(param), y.(param), mag_, 10,'LineStyle', 'none')
cMap=jet(256);
colormap(cMap)
cb = colorbar;
ylabel('y [mm]')
xlabel('x [mm]')
title('Mean mag-velocity')

%%%% Normal POD %%%%
% Ntt=size(mag.(param),3);
% S=reshape(permute(mag.(param), [3 2 1]), Ntt, []);
% U=S-repmat(mean(S,1), Ntt, 1);
% C=(U'*U)/(Ntt-1);
% [PHI, LAM]=eig(C, 'vector'); %really long to compute
% [lambda, ilam]=sort(LAM, 'descend');
% PHI=PHI(:,ilam);
% A=U*PHI;
% k=1;
% Utilde_k=A(:,k)*PHI(:,k)';
% for p=1:4
%    index = 250*p;
%    U_m=Utilde_k(index,:);
%    U_p(:,:,p)=permute(reshape(U_m, size(mag.(param),2), size(mag.(param),1)), [2 1]);
% end
% 
% figure(2)
% subplot(2,2,1)
% contourf(x.(param),y.(param), U_p(:,:,1)+mag_, 'LineStyle','none')
% cMap=jet(256);
% colormap(cMap)
% cb=colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% 
% subplot(2,2,2)
% contourf(x.(param),y.(param), U_p(:,:,2)+mag_, 'LineStyle','none')
% cMap=jet(256);
% colormap(cMap)
% cb=colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% 
% subplot(2,2,3)
% contourf(x.(param),y.(param), U_p(:,:,3)+mag_, 'LineStyle','none')
% cMap=jet(256);
% colormap(cMap)
% cb=colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% 
% subplot(2,2,4)
% contourf(x.(param),y.(param), U_p(:,:,4)+mag_, 'LineStyle','none')
% cMap=jet(256);
% colormap(cMap)
% cb=colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% 
% for m = 1:3
%    PHI_m = PHI(:,m);
%    PHI_p(:,:,m) = permute(reshape(PHI_m, size(mag.(param),2), size(mag.(param),1)), [2 1]);
% end
% fs=1000;
% 
% figure(3)
% subplot(3,2,1)
% contourf(x.(param),y.(param), PHI_p(:,:,1), 'LineStyle','none')
% cMap=jet(256);
% colormap(cMap)
% cb=colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% title('Mode I')
% 
% subplot(3,2,3)
% contourf(x.(param),y.(param), PHI_p(:,:,2), 'LineStyle','none')
% cMap=jet(256);
% colormap(cMap)
% cb=colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% title('Mode II')
% 
% subplot(3,2,5)
% contourf(x.(param),y.(param), PHI_p(:,:,3), 'LineStyle','none')
% cMap=jet(256);
% colormap(cMap)
% cb=colorbar;
% ylabel('y [mm]')
% xlabel('x [mm]')
% title('Mode III')
% 
% subplot(3,2,2)
% plot(linspace(0, length(A(:,1))-1/fs, length(A(:,1))), A(:,1)');
% title('Mode I')
% ylabel('a_1')
% axis([0 1000 -400 400])
% 
% subplot(3,2,4)
% plot(linspace(0, length(A(:,2))-1/fs, length(A(:,2))), A(:,2)');
% title('Mode II')
% ylabel('a_2')
% axis([0 1000 -400 400])
% 
% subplot(3,2,6)
% plot(linspace(0, length(A(:,3))-1/fs, length(A(:,3))), A(:,3)');
% title('Mode III')
% ylabel('a_3')
% axis([0 1000 -400 400])


%%%% Snapshot POD %%%%
Ntt=size(mag.(param),3);
S=reshape(permute(mag.(param), [3 2 1]), Ntt, []);
U=S-repmat(mean(S,1), Ntt, 1);
C_s=(U*U')/(Ntt-1);
[A_s, LAM_s]=eig(C_s, 'vector'); %Really long to compute
[~, ilam_s]=sort(LAM_s, 'descend');
A_s=A_s(:,ilam_s);
PHI_s = U'*A_s;

Ntt_u=size(u.(param),3);
S_u=reshape(permute(u.(param), [3 2 1]), Ntt_u, []);
U_u=S_u-repmat(mean(S_u,1), Ntt_u, 1);
C_s_u=(U_u*U_u')/(Ntt_u-1);
[A_s_u, LAM_s_u]=eig(C_s_u, 'vector'); %Really long to compute
[~, ilam_s_u]=sort(LAM_s_u, 'descend');
A_s_u=A_s_u(:,ilam_s_u);
PHI_s_u = U_u'*A_s_u;

Ntt_v=size(v.(param),3);
S_v=reshape(permute(v.(param), [3 2 1]), Ntt_v, []);
U_v=S_v-repmat(mean(S_v,1), Ntt_v, 1);
C_s_v=(U_v*U_v')/(Ntt_v-1);
[A_s_v, LAM_s_v]=eig(C_s_v, 'vector'); %Really long to compute
[~, ilam_s_v]=sort(LAM_s_v, 'descend');
A_s_v=A_s_v(:,ilam_s_v);
PHI_s_v = U_v'*A_s_v;

k=1;
Utilde_k_s=A_s(:,k)*PHI_s(:,k)';
Utilde_k_s_u=A_s_u(:,k)*PHI_s_u(:,k)';
Utilde_k_s_v=A_s_v(:,k)*PHI_s_v(:,k)';
for p=1:4
   index = 250*p;
   U_m_s=Utilde_k_s(index,:);
   U_m_s_u=Utilde_k_s_u(index,:);
   U_m_s_v=Utilde_k_s_v(index,:);
   
   U_p_s(:,:,p)=permute(reshape(U_m_s, size(mag.(param),2), size(mag.(param),1)), [2 1]);
   U_p_s_u(:,:,p)=permute(reshape(U_m_s_u, size(u.(param),2), size(u.(param),1)), [2 1]);
   U_p_s_v(:,:,p)=permute(reshape(U_m_s_v, size(v.(param),2), size(v.(param),1)), [2 1]);
end

parameter = {'U_p_s','U_p_s_u','U_p_s_v'};
parameter2 = {'mag_','u_','v_'};
text = {'Magnitude velocity','x-velocity','y-velocity'};
for i = 1:3
    figure(i+3)
    sgtitle(['U_p for ' text{i}])
    subplot(2,2,1)
    contourf(x.(param),y.(param), eval([parameter{i} '(:,:,1)+' parameter2{i}]), 'LineStyle','none')
    cMap=jet(256);
    colormap(cMap)
    cb=colorbar;
    ylabel('y [mm]')
    xlabel('x [mm]')

    subplot(2,2,2)
    contourf(x.(param),y.(param), eval([parameter{i} '(:,:,2)+' parameter2{i}]), 'LineStyle','none')
    cMap=jet(256);
    colormap(cMap)
    cb=colorbar;
    ylabel('y [mm]')
    xlabel('x [mm]')

    subplot(2,2,3)
    contourf(x.(param),y.(param), eval([parameter{i} '(:,:,3)+' parameter2{i}]), 'LineStyle','none')
    cMap=jet(256);
    colormap(cMap)
    cb=colorbar;
    ylabel('y [mm]')
    xlabel('x [mm]')

    subplot(2,2,4)
    contourf(x.(param),y.(param), eval([parameter{i} '(:,:,4)+' parameter2{i}]), 'LineStyle','none')
    cMap=jet(256);
    colormap(cMap)
    cb=colorbar;
    ylabel('y [mm]')
    xlabel('x [mm]')
end


for m = 1:3
   PHI_m_s = PHI_s(:,m);
   PHI_m_s_u = PHI_s_u(:,m);
   PHI_m_s_v = PHI_s_v(:,m);
   PHI_p_s(:,:,m) = permute(reshape(PHI_m_s, size(mag.(param),2), size(mag.(param),1)), [2 1]);
   PHI_p_s_u(:,:,m) = permute(reshape(PHI_m_s_u, size(u.(param),2), size(u.(param),1)), [2 1]);
   PHI_p_s_v(:,:,m) = permute(reshape(PHI_m_s_v, size(v.(param),2), size(v.(param),1)), [2 1]);
end
fs=1000;

parameter = {'PHI_p_s','PHI_p_s_u','PHI_p_s_v'};
parameter2 = {'A_s','A_s_u','A_s_v'};
text = {'Magnitude velocity','x-velocity','y-velocity'};
for i = 1:3
    figure(i+6)
    sgtitle(['Snapshot POD and Mode for ' text{i}])
    subplot(3,2,1)
    contourf(x.(param),y.(param), eval([parameter{i} '(:,:,1)']), 'LineStyle','none')
    cMap=jet(256);
    colormap(cMap)
    cb=colorbar;
    ylabel('y [mm]')
    xlabel('x [mm]')
    title('Mode I')

    subplot(3,2,3)
    contourf(x.(param),y.(param), eval([parameter{i} '(:,:,2)']), 'LineStyle','none')
    cMap=jet(256);
    colormap(cMap)
    cb=colorbar;
    ylabel('y [mm]')
    xlabel('x [mm]')
    title('Mode II')

    subplot(3,2,5)
    contourf(x.(param),y.(param), eval([parameter{i} '(:,:,3)']), 'LineStyle','none')
    cMap=jet(256);
    colormap(cMap)
    cb=colorbar;
    ylabel('y [mm]')
    xlabel('x [mm]')
    title('Mode III')

    subplot(3,2,2)
    plot(linspace(0, length(eval([parameter2{i} '(:,1)']))-1/fs, length(eval([parameter2{i} '(:,1)']))), eval([parameter2{i} '(:,1)'])');
    title('Mode I')
    ylabel('a_1')
    axis([0 1000 -0.1 0.1])

    subplot(3,2,4)
    plot(linspace(0, length(eval([parameter2{i} '(:,2)']))-1/fs, length(eval([parameter2{i} '(:,2)']))), eval([parameter2{i} '(:,2)'])');
    title('Mode II')
    ylabel('a_2')
    axis([0 1000 -0.1 0.1])

    subplot(3,2,6)
    plot(linspace(0, length(eval([parameter2{i} '(:,3)']))-1/fs, length(eval([parameter2{i} '(:,3)']))), eval([parameter2{i} '(:,2)'])');
    title('Mode III')
    ylabel('a_3')
    axis([0 1000 -0.1 0.1])
end
