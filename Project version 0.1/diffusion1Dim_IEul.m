function [s] = diffusion1Dim_IEul(f,g1,g2,L,T,Mt,Ns,a)

%Implicit_Euler: function that solve a 1Dimension diffusion equation of 
%                  the type u_t = a * u_xx using the Implicit Euler Method
%                   IC:  u(x,0)=f(x)       0 <= x <= L   t=0
%                   BC:  u(0,t)=g1(t)       u(L,t)=g2(t) 0 < t <= T
%
%Input Variable: 
%                 L = maximun lenght of the tube;
%                 T = time interval;
%                 Mt = number of time steps;
%                 Ns = number of spatial step;
%Output Variable:
%                 s: solution computed by the Implicit Euler Method                      
%                 we don't need a control index because, for definition,
%                 this type of method in unconditionally stable.
%                 

k = T/Mt; % time step = Time interval / number of time steps 
h = L/(Ns+1); % spatial step in x, we have N+1 Intervals, with N nodes
r = a*k/(h^2);

rr=1+2*r;

%discretization in space and time
x = h:h:Ns*h;   % start from the index 0+h 
t = 0:k:Mt*k;
																							
% Evaluation of initial condition(IC):
u(:,1)=f(x); 
% Evaluation of boundary condition(BC):
g1_k=g1(t);  
g2_k=g2(t);

% matrix of the internal nodes(NsxNs)
B = diag(-r*ones(Ns-1,1),-1)+diag(rr*ones(Ns,1))+diag(-r*ones(Ns-1,1),+1);

% finally we use a for cycle, because the solution evolves in time until 
% the end of the interval Mt, filling all the rows of the solution.
for  j = 1:Mt
    b(1)=u(1,j)+r*g1_k(j+1);
    b(Ns)=u(Ns,j)+r*g2_k(j+1);
    b(2:Ns-1)=u(2:Ns-1,j);
    u(:,j+1)=B\b';
end

% add the boundary conditions
s= [g1_k;u;g2_k];
end
