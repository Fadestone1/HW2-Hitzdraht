clear;
close all;
clc;

load('data.mat');


xc = linspace(0.25,0.7,24);
t = linspace(0,1,10000);
for j = 1:5
    figure(j)
    hold on
    for i = 1:24
        dmp(:) = v10(j,i,:);
        if std(dmp-v0(i,:))>0.01
            plot(t(:),dmp-v0(i,:)+2*i)
        end
    end
    xlabel('Zeit (sec)');
end
