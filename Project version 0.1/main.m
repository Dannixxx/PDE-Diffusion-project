clear all 
close all
clc

L=20;
T=10;
Mt=20;
Ns=10;
a=0.119; 
k=T/Mt;
h=L/(Ns+1);
x=linspace(0,L,Ns+2);

[sEE,ok] = diffusion1Dim_EEul(@f,@g1,@g2,T,L,Mt,Ns,a);
[sIE] = diffusion1Dim_IEul(@f,@g1,@g2,T,L,Mt,Ns,a);
[sCN] = diffusion1Dim_CN(@f,@g1,@g2,T,L,Mt,Ns,a);

figure
subplot(1,3,1)
surf(sEE)
xlabel('space');ylabel('time');zlabel('concentration')
subplot(1,3,2) 
surf(sIE)
xlabel('space');ylabel('time');zlabel('concentration')
subplot(1,3,3) 
surf(sCN)
xlabel('space');ylabel('time');zlabel('concentration')