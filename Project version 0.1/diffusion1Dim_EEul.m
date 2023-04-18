function [s,ctl] = diffusion1Dim_EEul(f,g1,g2,L,T,Mt,Ns,a)

%Explicit_Euler: function that solve a 1Dimension diffusion equation of 
%                  the type u_t = a * u_xx using the Explicit Euler Method
%                   IC:  u(x,0)=f(x)       0 <= x <= L     t=0
%                   BC:  u(0,t)=g1(t)       u(L,t)=g2(t)   0 < t <= T
%
%Input Variable: 
%                 L = maximun lenght of the tube;
%                 T = time interval;
%                 Mt = number of time steps;
%                 Ns = number of spatial step;
%Output Variable:
%                 s: solution computed by the Explicit Euler Method                      
%                       
%                 ctl: control index, used for check the 
%                   method is stable or unstable, due to the nature
%                   of the Explicit method.
%                   Stability depends by the value r, if r<= 0.5, the 
%                   method is stable, otherwise is unstable.


k = T/Mt; % time step = Time interval / number of time steps 
h = L/(Ns+1); % spatial step in x, we have N+1 Intervals, with N nodes
r = a*k/(h^2);

% with this " if " conditional statement,we check the control index of 
% the method: 
% in case of r>0.5,we exit from the loop with a message that  
% show that the method is unstable, otherwise we exit from the loop  
% for compute the solution

ctl = 1;
if r>0.5
    disp("Explicit Euler Method --> Unstable Method")
    ctl = 0;
    w = [];
end
disp("Explicit Euler Method --> Stable Method")
rr = 1-2*r;
%discretization in space and time
x = h:h:Ns*h;   % start from the index 0+h 
t = 0:k:Mt*k;

% Evaluation of initial condition(IC):
u(:,1)=f(x);

% Evaluation of boundary condition(BC):
g1_k = g1(t);
g2_k = g2(t);

% matrix of the internal nodes(NsxNs)
A = diag(r*ones(Ns-1,1),-1) + diag(rr*ones(Ns,1))+ diag(r*ones(Ns-1,1),+1);

% finally we use a for cycle, because the solution evolves in time until 
% the end of the interval Mt, filling all the rows of the solution.

for j=1:Mt
    u(:,j+1) = A*u(:,j);
    u(1,j+1) = u(1,j+1)+r*g1_k(j);
    u(Ns,j+1) = u(Ns,j+1)+r*g2_k(j);
end

% add the boundary conditions
s= [g1_k;u;g2_k];
end


