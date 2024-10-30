

% PDEPE solver
function [pde_sol,txtPE] = solve_pdepe(dx, dt, diffCoeff, tubeLength, simTime, relTol, absTol)
tic
    x = linspace(0, tubeLength, round(tubeLength/dx)+1);
    t = linspace(0, simTime, round(simTime/dt)+1);

    m = 0;
    options = odeset('RelTol', relTol, 'AbsTol', absTol);
    pde_sol = pdepe(m, @pdefun, @icfun, @bcfun, x, t, options);
    % pde_sol=pde_solution';
    timePE=toc;
    txtPE=sprintf('\n ◉ Elapsed Time PDEPE : %.4f [s] \n',timePE);
    
end

% PDE function
function [c, f, s] = pdefun(x, t, u, dudx)
    diffCoeff = 0.119;
    c = 1;
    f = diffCoeff * dudx;
    s = 0;
end

% Initial condition for PDEPE
function u0 = icfun(x)
    u0 = initial_condition(x); 
end

% Boundary condition for PDEPE
function [pl, ql, pr, qr] = bcfun(xl, ul, xr, ur, t)
    pl = ul - boundary_condition(0, 20,t);
    ql = 0;
    pr = ur - boundary_condition(20, 20,t);
    qr = 0;
end