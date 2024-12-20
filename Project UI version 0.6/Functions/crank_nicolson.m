 function [sol_crank,cond_numCN,txtCN] = crank_nicolson(dx, dt, diffCoeff, tubeLength, simTime)

 tic
 r=dt*diffCoeff/(2*(dx^2));
 Nx = round(tubeLength / dx);  % Number of spatial steps
 Nt = round(simTime / dt);     % Number of time steps
 
 x = linspace(0, tubeLength, Nx+1);
 t = linspace(0, simTime, Nt+1);

 u1=initial_condition(x(2:Nx));
 g0 = boundary_condition(0, tubeLength,t);
 g1 = boundary_condition(tubeLength, tubeLength,t);


 u1=u1(:);u=u1;v=-r*ones(1,Nx-2);

 A=(1+2*r)*eye(Nx-1)+diag(v,1)+diag(v,-1);
 % iA=inv(A);
 B1 = (1-2*r)*eye(Nx-1)+diag(-v,1)+diag(-v,-1);
 for j=1:Nt
     B=r*(g0(j)+g0(j+1))+(1-2*r)*u1(1)+r*u1(2);
     for i=1:Nx-3
         B(i+1,1)=[r,1-2*r,r]*u1(i:i+2);
     end
     B(Nx-1,1)=r*u1(Nx-2)+(1-2*r)*u1(Nx-1)+r*(g1(j)+g1(j+1));
     
     u1=A\B;
     u=[u u1];
 end
X=trid(A,B1);
cond_numCN=cond(X);

S=vertcat(g0,u,g1);
timeCN=toc;
sol_crank=S';
    
    %This part of the code is only useful in case the solution values ​​exceed the boundary 
    % conditions values ​​(documented case --> dx = 0.0100 [cm] and dt = 0.0100 [s] --> r = 11.90 >> 0.5),
    % only for some values ​​that reached the value 12 or -2 in the first
    % and last portions of the graph.
    % For all the other cases this problem didn't occurs.
    for i=1:size(sol_crank,1)
        for j=1:size(sol_crank,2)
            if sol_crank(i,j) > 10 
               sol_crank(i,j) = 10;
            elseif sol_crank(i,j) < 0
                sol_crank(i,j) = 0;
            end
        end
    end

clear U
txtCN= sprintf('\n ◉ Elapsed Time Crank - Nicolson : %.4f [s] , conditioning number: %.4f \n', timeCN, cond_numCN);

end

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
end
