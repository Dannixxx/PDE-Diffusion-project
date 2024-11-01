

% Explicit Euler Method with pre-iteration normalization
function [sol_explicit, cond_numEE, spectr_rad, r, txtEE] = explicit_euler(dx, dt, diffCoeff, tubeLength, simTime)
    %Explicit_Euler: function that solves a 1D diffusion equation of the type
    %                 u_t = a * u_xx using the Explicit Euler Method
    %                   IC:  u(x,0)=initial_condition(x)       0 <= x <= L     t=0
    %                   BC:  u(0,t)=boundary_condition(0)       u(L,t)=boundary_condition(L)   0 < t <= T
    %
    % Input Variables: 
    %     TubeLength   = maximum length of the tube
    %     simTime      = simulation time interval
    %     dt           = time step
    %     dx           = spatial step
    %     diffCoeff    = diffusion coefficient a
    % Output Variables:
    %     sol_explicit = solution computed by the Explicit Euler Method
    %     ctl          = control index for stability (1: stable, 0: unstable)
    %     cond_numEE   = condition number for the spatial step
    %     r            = stability parameter for Euler method
    %     spectr_rad   = spectral radius for the Explicit Euler Method

    tic  % Start timer

    % Discretize space and time
    Nx = round(tubeLength / dx);  % Number of spatial steps
    Nt = round(simTime / dt);     % Number of time steps
    x = linspace(0, tubeLength, Nx+1);  % Spatial grid
    t = linspace(0, simTime, Nt+1);     % Temporal grid

    % Initialize solution matrix and parameters
    u = zeros(Nx+1, Nt+1);  % Solution matrix initialization
    r = diffCoeff * dt / dx^2;  % Stability parameter

    % % % Stability check           ---------------->REMOVE
    % % ctl = 1;  % Control index for stability
    % % if r > 0.5
    % %     fprintf('Explicit Euler Method --> Unstable Method, r = %.3f\n', r);
    % %     ctl = 0;  % Mark as unstable
    % % else
    % %     fprintf('Explicit Euler Method --> Stable Method, r = %.3f\n', r);
    % % end

    % Coefficients for the update formula
    rr = 1 - 2*r;

    % Initial condition
    u(:,1) = initial_condition(x);

    % Boundary conditions
    u(1,:) = boundary_condition(0, tubeLength, t);
    u(Nx+1,:) = boundary_condition(tubeLength, tubeLength, t);

    % Matrix of internal nodes (Nx x Nx)
    A = diag(r*ones(Nx,1), -1) + diag(rr*ones(Nx+1,1)) + diag(r*ones(Nx,1), +1);

    % Condition number of the matrix
    cond_numEE = cond(A);


    if r >= 0.6
        %  Time evolution loop for Explicit Euler using log-scaled values ---

        for j = 1:Nt
            if max(u(2:Nx,j))> 1e307;
                u = normalize(u,"norm",Inf);
        end
            u(2:Nx, j+1) = r*u(1:Nx-1, j) + rr*u(2:Nx, j) + r*u(3:Nx+1, j);
            %u(2:Nx, j+1) = log(abs(r*(u(1:Nx-1, j)) + rr*(u(2:Nx, j)) + r*(u(3:Nx+1, j))) + epsilon);
        end
    else
     % --- Time evolution loop for Explicit Euler ---
    for j = 1:Nt
        u(2:Nx, j+1) = r*u(1:Nx-1, j) + rr*u(2:Nx, j) + r*u(3:Nx+1, j);
    end

    end
    timeEE=toc;  % End timer


    % Transpose solution matrix for plotting (t x x)
    sol_explicit = u';

    % Spectral radius of the matrix
    lambda = eig(A);
    spectr_rad = max(abs(lambda));  % Compute spectral radius
    
     % Stability condition for Explicit Euler method
        stable_dt = (dx^2 / (2 * diffCoeff));
        stability_condition = dt <= stable_dt;  % Conditioned stability
        txtEE = sprintf('\n ------------------------------Current parameter:  dx = %.4f [cm]      dt = %.4f [s] ------------------------------ \n \n ◉ Stability condition (Explicit Euler): dt <= dx^2 / (2a^2) = %.4f [s] \n',dx,dt,stable_dt);
        if stability_condition
            txtEE = [txtEE, sprintf('\n         ➤ ✅ Solution is stable.\n')];
        else
            txtEE = [txtEE, sprintf('\n         ➤ ⛔ WARNING: Solution is unstable.\n')];
      
        end
txtresult= sprintf('\n ◉ Elapsed Time Explicit Euler : %.4f [s], conditioning number: %.4f \n', timeEE,cond_numEE);
txtEE =[txtEE, txtresult];
end
