

 
function [sol_implicit,cond_numIE,txtIE] =implicit_euler(dx, dt, diffCoeff, tubeLength, simTime)

 %Implicit_Euler: function that solve a 1Dimension diffusion equation of 
%                   the type u_t = a * u_xx using the Implicit Euler Method
%                   IC:  u(x,0)=initial_condidion(x)       0 <= x <= L     t=0
%                   BC:  u(0,t)=g1(t)       u(L,t)=g2(t)   0 < t <= T
%
%Input Variable: 
%                 TubeLength = maximun lenght of the tube;
%                 simTime = time interval for simulation;
%                 dt = time step;
%                 dx = spatial step;
%                 diffCoeff= diffusion coefficient a
%Output Variable:
%                 sol_implicit: solution computed by the Implicit Euler Method                      
%                 we don't need a control index because, for definition,
%                 this type of method in unconditionally stable.
%
%                 cond_num: condition number for a given spatial step
%                 
tic
 Nx = round(tubeLength / dx);  % Number of spatial steps
 Nt = round(simTime / dt);     % Number of time steps

 % x=[0:Nx]'*dx; t=[0:Nt]*dt;
 x = linspace(0, tubeLength, Nx+1);
 t = linspace(0, simTime, Nt+1);

 for i=1:Nx+1, u(i,1)=initial_condition(x(i)); end
 for n=1:Nt+1, u([1 Nx+1],n)=[boundary_condition(0, tubeLength,t(n)); boundary_condition(tubeLength, tubeLength,t(n))]; end
 
 r = diffCoeff*dt/(dx^2);
 r2=1+2*r;

 % matrix of the internal nodes(NsxNs)
 B = diag(-r*ones(Nx-2,1),-1)+diag(r2*ones(Nx-1,1))+diag(-r*ones(Nx-2,1),+1);

 %evaluation of the condition number 
 cond_numIE = cond(inv(B));

 
 for k=2:Nt+1
    b= [r*u(1,k); zeros(Nx-3,1); r*u(Nx+1,k)] +u(2:Nx,k-1); 
    u(2:Nx,k)= trid(B,b);
 
 end
 timeIE=toc;

% % % figure("Name","Implicit")

sol_implicit=u';

txtIE=sprintf('\n ◉ Elapsed Time Implicit Euler : %.4f [s], conditioning number: %.4f \n', timeIE, cond_numIE);

clear u 


 function x=trid(A,b)
 %solve a tridiagonal system of equations
 N=size(A,2);
     for i=2:N %Upper Triangularization
     tmp= A(i,i-1)/A(i-1,i-1);
     A(i,i) =A(i,i)-A(i-1,i)*tmp;
     A(i,i-1) =0;
     b(i,:) =b(i,:)-b(i-1,:)*tmp;
     end
 x(N,:)=b(N,:)/A(N,N);
     for j=N-1:-1: 1 %Back Substitution
     x(j,:) =(b(j,:)-A(j,j+1)*x(j+1))/A(j,j);
     end
