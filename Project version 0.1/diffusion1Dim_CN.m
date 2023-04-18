function w = diffusion1Dim_CN(f,g1,g2,L,T,Mt,Ns,a)


%Crank_Nicolson:   function that solve a 1Dimension diffusion equation of 
%                  the type u_t = a * u_xx using the Crank Nicolson Method
%                   IC:  u(x,0)=f(x)       0 <= x <= L     t=0
%                   BC:  u(0,t)=g1(t)       u(L,t)=g2(t)   0 < t <= T
%Input Variable: 
%                 L = maximun lenght of the tube;
%                 T = time interval;
%                 Mt = number of time steps;
%                 Ns = number of spatial step;
%Output Variable:
%                 s: solution computed by the Implicit Euler Method                      
%                 we don't need a control index because, for definition,
%                 this type of method in unconditionally stable.


k = T/Mt; % time step = Time interval / number of time steps 
h = L/(Ns+1); % spatial step in x, we have N+1 Intervals, with N nodes
r=a* k/(2*h^2); %(In Crank-Nicolson Method we have a similar value of r
% with respect of the other method(add 2 on the denominator))
rr_b=1+2*r;
rr_a=1-2*r;

%discretization in space and time
x=h:h:Ns*h;  % start from the index 0+h   					    														    
t=0:k:Mt*k; 																							

% Evaluation of initial condition(IC):
u(:,1)=f(x);

% Evaluation of boundary condition(BC):
g1_k=g1(t);  
g2_k=g2(t);
 

B =diag(-r*ones(Ns-1,1),-1)+diag(rr_b*ones(Ns,1))+diag(-r*ones(Ns-1,1),+1);
A =diag(r*ones(Ns-1,1),-1)+diag(rr_a*ones(Ns,1))+diag(r*ones(Ns-1,1),+1);
F= zeros(Ns,1);

% finally we use a for cycle, because the solution evolves in time until 
% the end of the interval Mt, filling all the rows of the solution.
for  j = 1:Mt
    F(1)=r*(g1_k(j)+g1_k(j+1));
    F(Ns)=r*(g2_k(j)+g2_k(j+1));
    u(:,j+1)=B\(A*u(:,j)+F); 
end

% add the boundary conditions
w = [g1_k;u;g2_k];
end
