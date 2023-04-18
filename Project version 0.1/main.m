clear all 
close all
clc

L=20;
T = input("Define a value of time interval \n");
% T=10;
Mt = input("Define a value of time steps \n");
% Mt=20;
Ns = input("Define a value of spatial steps \n");
% Ns=10;
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
xlabel('space');ylabel('time');zlabel('concentration');title('Explicit Euler')
subplot(1,3,2) 
surf(sIE)
xlabel('space');ylabel('time');zlabel('concentration');title('Implicit Euler')
subplot(1,3,3) 
surf(sCN)
xlabel('space');ylabel('time');zlabel('concentration');title('Crank-Nicolson')


figure
t=0;
subplot(3,1,1)
plot(x,sEE,'k:')
xlabel('space');ylabel('concentration');title('Explicit Euler')
subplot(3,1,2)
plot(x,sIE,'k:')
xlabel('space');ylabel('concentration');title('Implicit Euler')
subplot(3,1,3)
plot(x,sCN,'k:')
xlabel('space');ylabel('concentration');title('Crank-Nicolson')
