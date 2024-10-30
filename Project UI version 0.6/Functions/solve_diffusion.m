


function [sol_explicit,cond_numEE,spectr_rad,r,sol_implicit,cond_numIE,sol_crank,cond_numCN, pde_sol,result_text] = solve_diffusion(dx, dt, diffCoeff, tubeLength, simTime, relTol, absTol,result_text)

    % Solver for explicit, implicit Euler, Crank-Nicolson, and PDEPE
    % sol_* are solution matrices for each method over time
    [sol_explicit,cond_numEE,spectr_rad,r,txtEE] = explicit_euler(dx, dt, diffCoeff, tubeLength, simTime);
    [sol_implicit,cond_numIE,txtIE] = implicit_euler(dx, dt, diffCoeff, tubeLength, simTime);
    [sol_crank,cond_numCN,txtCN] = crank_nicolson(dx, dt, diffCoeff, tubeLength, simTime);
    [pde_sol,txtPE] = solve_pdepe(dx, dt, diffCoeff, tubeLength, simTime, relTol, absTol);
    result_text = sprintf('%s\n %s\n %s\n %s', txtEE, txtIE, txtCN, txtPE);
    
end


