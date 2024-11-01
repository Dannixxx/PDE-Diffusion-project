

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
    result_text=[];

    cond_numEE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    cond_numIE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    cond_numCN = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));

    lengthSpace = length(activeSpatialSteps);
    lengthTime = length(activeTimeSteps);

    % If no active step sizes are selected
    if isempty(activeSpatialSteps) || isempty(activeTimeSteps)
        result_text = 'You need to select at least one spatial step and one time step.';
        uitext_results.Value = result_text; 
        drawnow;
        return ; % Return default values for k, lengthSpace, and lengthTime
    end
  
    % Timing the computations
    Start=tic;
    r = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    
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
            
            % Append current progress to result_text
            %result_text = sprintf('%s\nFinished solving for dx=%.3f, dt=%.3f', result_text, dx, dt);
            result_text_for = [result_text_for, sprintf('\n --------    ✦ Calcutation with dx=%.3f, dt=%.3f  completed \n' , dx, dt)];
            result_text=[result_text, result_text_for];

            % if any(isnan(sol_explicit(:))) || any(isnan(sol_implicit(:))) || any(isnan(sol_crank(:)))
            %     uitext_results.Value = sprintf('Numerical solution encountered instability. Please try different step sizes. %.4f %.4f',dx, dt);
            %     return;
            if plot2D
                fig2D=plot2D_solution(sol_explicit,sol_implicit,sol_crank,dx,dt,tubeLength, simTime, r(i,j));
                if plot_savefig
                 file_name2D = fullfile(figuresFolder, sprintf( "2D Sol_spatial step size = %.3f, temporal step size %.3f, variable r=%.3f.png",dx,dt,r(i,j)));
                 saveas(fig2D,file_name2D);
                 clear file_name2D 
                 clear fig2D
                end   
            end

            if plot3D
            Fig3d=plot3D_solution(sol_explicit,sol_implicit,sol_crank,dx,dt,tubeLength, simTime, r(i,j));
                if plot_savefig
                     file_name3D = fullfile(figuresFolder, sprintf("3D Sol_spatial step= %.3f, temporal step %.3f,variable r=%.3f.png",dx,dt,r(i,j)));
                     saveas(Fig3d,file_name3D);
                     clear file_name3D
                     clear Fig3d
                end
            end

            if plotPDEPE
                [Plot_PDEfig,k] = plot_PE (pde_sol,dx, dt, tubeLength, simTime,k,lengthSpace,lengthTime,plotPDEPE,Plot_PDEfig);
                 % % % if plot_savefig
                     % % % file_namePDE = fullfile(figuresFolder, sprintf("3D Sol_PDEPE_spatial step = %.3f, temporal step %.3f.png",dx,dt));
                     % % % saveas(Plot_PDEfig,file_namePDE);
                     % clear Plot_PDEfig
                 % end
            end
            k=k+1;
        end
    end
    if plot_savefig
       file_namePDE = fullfile(figuresFolder, sprintf("3D Sol_PDEPE.png"));
       saveas(Plot_PDEfig,file_namePDE);
   % clear Plot_PDEfig
    end
   
    % Compute and plot condition numbers, truncation errors, etc.ite 
    if plotCondTime || plotCondSpace || plotTruncErrorTime || plotTruncErrorSpace || plotRelErrorTime || plotRelErrorSpace || plot_savefig
        plot_additional_graphs(cond_numEE,cond_numIE,cond_numCN, activeSpatialSteps, activeTimeSteps, plotCondTime, plotCondSpace, plotTruncErrorTime, plotTruncErrorSpace, plotRelErrorTime, plotRelErrorSpace,plot_savefig,figuresFolder);
    end
     % Elapsed time for the computation
    Tsim = toc(Start);

    % After the double loop for spatial and time steps:
    table_header = sprintf('\nStability Condition - r - Table (Explicit Euler Method):\n');
    time_step_header = 'Spatial Step \\ Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header = [time_step_header, sprintf(' %.4f |', activeTimeSteps(j))];
    end
    
    % Separator line
    % % separator_line = repmat('-', 1, length(time_step_header) + 5);
     table_body = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data = [row_data, sprintf(' %.4f |', r(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body = [table_body, row_data];
    end
    
    % Combine header, separator, and body to form the complete table
    stability_table = [table_header, time_step_header, table_body, '\n'];
    stability_table=strjoin(stability_table, '\n');
    stability_tab= sprintf(stability_table);

    elapsedTime = sprintf('                 ⚡ Total Time of Simulations: %.2f seconds \n\n', Tsim);
    % Append the formatted table and the time of simulation to result_text
    result_text = [result_text,stability_tab,elapsedTime];
    
    
    % result_text = [result_text , elapsedTime];
    uitext_results.Value = "Simulation Complete";
    drawnow;
    result_text==strjoin(result_text, '\n');
end 



        


