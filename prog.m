clear;
close all;
clc;

load('data.mat');

figure(1)
hold on
xc = linspace(0.25,0.7,24);
t = linspace(0,10,10000);
for i = 1:24
    dmp(:) = v10(1,i,:);
    plot(t(:),dmp-v0(i,:)+2*i)
end