

function [result_text,k,lengthSpace,lengthTime,r] = solve_problem(chk_spatialSteps,spatialSteps,chk_timeSteps,timeSteps, diffCoeff, tubeLength, simTime, relTol, absTol, plot2D,plot3D, plotPDEPE, plotCondTime, plotCondSpace, plotTruncErrorTime, plotTruncErrorSpace, plotRelErrorTime, plotRelErrorSpace,plot_savefig,figuresFolder)
    
    % Initialize output variables with default values
    k = 0;  % Iteration counter
    lengthSpace = 0;  % Default length for spatial steps
    lengthTime = 0;  % Default length for time steps
    % Initial result message
    uitext_results.Value = "Solving diffusion equation...";
    drawnow;

    % Filter for active spatial and time step sizes
    activeSpatialSteps = [spatialSteps(1), spatialSteps(2),spatialSteps(3)] .* chk_spatialSteps;  % Only take checked values
    activeSpatialSteps = activeSpatialSteps(activeSpatialSteps > 0);  % Remove unchecked
    activeTimeSteps = [timeSteps(1), timeSteps(2),timeSteps(3)] .* chk_timeSteps;       % Only take checked values
    activeTimeSteps = activeTimeSteps(activeTimeSteps > 0);  % Remove unchecked
    
    [cond_numEE,cond_numIE,cond_numCN,LTE_EE,GTE_EE,RTE_EE,LTE_IE,GTE_IE,RTE_IE,LTE_CN,GTE_CN,RTE_CN,result_text,lengthSpace,lengthTime,r] = initialization_var(activeSpatialSteps,activeTimeSteps);

    % If no active step sizes are selected
    if isempty(activeSpatialSteps) || isempty(activeTimeSteps)
        result_text = 'You need to select at least one spatial step and one time step.';
        uitext_results.Value = result_text; 
        drawnow;
        return ; % Return default values for k, lengthSpace, and lengthTime
    end
  
    % Timing the computations
    Start=tic;

    if plotPDEPE && k==0
        Plot_PDEfig = figure("Name","plot PDEPE", WindowState='maximized');
        set(0, 'CurrentFigure', Plot_PDEfig);
        sgtitle("PDEPE 3D-Solutions");
        k=k+1;
    else
        k=k+1;
    end
    
    for i = 1:lengthSpace
        for j = 1:lengthTime
            dx = activeSpatialSteps(i);
            dt = activeTimeSteps(j);

            % Solve using the explicit, implicit Euler, and Crank-Nicolson methods
            [sol_explicit,cond_numEE(i,j),spectr_rad,r(i,j), sol_implicit,cond_numIE(i,j),sol_crank,cond_numCN(i,j), pde_sol,result_text_for] = solve_diffusion(dx, dt, diffCoeff, tubeLength, simTime, relTol, absTol,result_text);
            
            
            result_text_for = [result_text_for, sprintf('\n --------    ✦ Calcutation with dx=%.3f, dt=%.3f  completed \n' , dx, dt)];
            result_text=[result_text, result_text_for];

            [LTE_EE(i,j),GTE_EE(i,j),RTE_EE(i,j),LTE_IE(i,j),GTE_IE(i,j),RTE_IE(i,j),LTE_CN(i,j),GTE_CN(i,j),RTE_CN(i,j)]=errors(sol_explicit,sol_implicit,sol_crank,pde_sol);

            % if any(isnan(sol_explicit(:))) || any(isnan(sol_implicit(:))) || any(isnan(sol_crank(:)))
            %     uitext_results.Value = sprintf('Numerical solution encountered instability. Please try different step sizes. %.4f %.4f',dx, dt);
            %     return;
            if plot2D
                fig2D=plot2D_solution(sol_explicit,sol_implicit,sol_crank,dx,dt,tubeLength, simTime, r(i,j));
                if plot_savefig
                 file_name2D = fullfile(figuresFolder, sprintf( "2D Sol_spatial step size = %.3f, temporal step size = %.3f, variable r=%.3f.png",dx,dt,r(i,j)));
                 saveas(fig2D,file_name2D);
                 clear file_name2D 
                 clear fig2D
                end   
            end

            if plot3D
            Fig3d=plot3D_solution(sol_explicit,sol_implicit,sol_crank,dx,dt,tubeLength, simTime, r(i,j));
                if plot_savefig
                     file_name3D = fullfile(figuresFolder, sprintf("3D Sol_spatial step= %.3f, temporal step = %.3f,variable r=%.3f.png",dx,dt,r(i,j)));
                     saveas(Fig3d,file_name3D);
                     clear file_name3D
                     clear Fig3d
                end
            end

            if plotPDEPE
                [Plot_PDEfig,k] = plot_PE (pde_sol,dx, dt, tubeLength, simTime,k,lengthSpace,lengthTime,plotPDEPE,Plot_PDEfig);
            end
            k=k+1;
        end
    end
    if plot_savefig && plotPDEPE
       file_namePDE = fullfile(figuresFolder, sprintf("3D Sol_PDEPE.png"));
       saveas(Plot_PDEfig,file_namePDE);
   % clear Plot_PDEfig
    end
   
    % Compute and plot condition numbers, truncation errors, etc.ite 
    if plotCondTime || plotCondSpace || plotTruncErrorTime || plotTruncErrorSpace || plotRelErrorTime || plotRelErrorSpace || plot_savefig
        plot_additional_graphs(cond_numEE,cond_numIE,cond_numCN,LTE_EE,GTE_EE,RTE_EE,LTE_IE,GTE_IE,RTE_IE,LTE_CN,GTE_CN,RTE_CN, activeSpatialSteps, activeTimeSteps, plotCondTime, plotCondSpace, plotTruncErrorTime, plotTruncErrorSpace, plotRelErrorTime, plotRelErrorSpace,plot_savefig,figuresFolder);
    end
     % Elapsed time for the computation
    Tsim = toc(Start);

    print_tab=print_table(lengthTime,activeTimeSteps,lengthSpace,activeSpatialSteps,r,LTE_EE,GTE_EE,RTE_EE,LTE_IE,GTE_IE,RTE_IE,LTE_CN,GTE_CN,RTE_CN,cond_numEE,cond_numIE,cond_numCN);

    elapsedTime = sprintf('                 ⚡ Total Time of Simulations: %.2f seconds \n\n', Tsim);
    % Append the formatted table and the time of simulation to result_text
    result_text = [result_text,print_tab,elapsedTime];
    
    % result_text = [result_text , elapsedTime];
    uitext_results.Value = "Simulation Complete";
    drawnow;
    result_text==strjoin(result_text, '\n');
    
    % This function provides the values ​​of space and time (between 0 and 1) in which the stability limit is obtained r = 0.5
    Plot_stability = test_stability(diffCoeff);
    if plot_savefig
      file_name_stab = fullfile(figuresFolder, sprintf("Stability limit for time and space.png"));
      saveas(Plot_stability,file_name_stab);
      clear file_name_stab
      clear Plot_stability
    end   

end 



        


