tiledlayout(3, 2)
imagesc(x.(param)(1,:),y.(param)(:,1), , 'LineStyle','none')
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