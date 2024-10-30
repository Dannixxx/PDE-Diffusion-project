

% Compute and plot condition numbers and errors
function plot_additional_graphs(cond_numEE,cond_numIE,cond_numCN, activeSpatialSteps, activeTimeSteps, plotCondTime, plotCondSpace, plotTruncErrorTime, plotTruncErrorSpace, plotRelErrorTime, plotRelErrorSpace,plot_savefig,figuresFolder)
    
    xcond = linspace(0, 1,1000);
    tcond = linspace(0, 1,1000);

    if plotCondTime
        
        condTime=plot_condition_number_vs_time(cond_numEE, cond_numIE, cond_numCN, activeSpatialSteps, activeTimeSteps);
          if plot_savefig
              file_namecondTime= fullfile(figuresFolder, sprintf("Condition Number vs Time Step.png"));
             saveas(condTime,file_namecondTime,'png');
         end
    end
    if plotCondSpace
        
        condSpace = plot_condition_number_vs_space(cond_numEE, cond_numIE, cond_numCN, activeSpatialSteps, activeTimeSteps);
        if plot_savefig
                file_namecondSpace= fullfile(figuresFolder, sprintf("Condition Number vs Space Step.png"));
             saveas(condSpace,file_namecondSpace,'png')
        end
    end

    if plotTruncErrorTime
        figureTruncErrorTime = figure('Name', 'Global Truncation Error vs Time Step');
        plot_truncation_error_vs_time(activeSpatialSteps, activeTimeSteps);
    end
    if plotTruncErrorSpace
        figureTruncErrorSpace = figure('Name', 'Global Truncation Error vs Spatial Step');
        plot_truncation_error_vs_space(activeSpatialSteps, activeTimeSteps);
    end
    if plotRelErrorTime
        figureRelErrorTime = figure('Name', 'Relative Error vs Time Step');
        plot_relative_error_vs_time(activeSpatialSteps, activeTimeSteps);
    end
    if plotRelErrorSpace
        figureRelErrorSpace = figure('Name', 'Relative Error vs Spatial Step');
        plot_relative_error_vs_space(activeSpatialSteps, activeTimeSteps);
    end
end



function condTime=plot_condition_number_vs_time(cond_numEE, cond_numIE, cond_numCN, activeSpatialSteps, activeTimeSteps)
    condTime=figure('Name', 'Condition Number vs Time Step'); 
    
    % Loop over each time step
    for i = 1:length(activeTimeSteps)
        subplot(length(activeTimeSteps), 1, i);
        plot(activeSpatialSteps, cond_numIE(:,i), '-or', activeSpatialSteps, cond_numEE(:,i), '-og', activeSpatialSteps, cond_numCN(:,i), '-ob');
        title(sprintf('Condition Number vs Spatial Step (Time Step = %.3f)', activeTimeSteps(i)));
        legend('Implicit Euler', 'Explicit Euler', 'Crank-Nicolson');
        xlabel('Spatial Step Size');
        ylabel('Condition Number');
        % sgtitle(fig_name);
        grid on;

    end
    
end


function condSpace=plot_condition_number_vs_space(cond_numEE, cond_numIE, cond_numCN, activeSpatialSteps, activeTimeSteps)
    condSpace=figure('Name', 'Condition Number vs Spatial Step'); 

    % Loop over each spatial step
    for i = 1:length(activeSpatialSteps)
        subplot(length(activeSpatialSteps), 1, i);
        plot(activeTimeSteps, cond_numIE(i,:), '-or', ...
             activeTimeSteps, cond_numEE(i,:), '-og', ...
             activeTimeSteps, cond_numCN(i,:), '-ob');
        title(sprintf('Condition Number vs Time Step (Spatial Step = %.3f)', activeSpatialSteps(i)));
        legend('Implicit Euler', 'Explicit Euler', 'Crank-Nicolson');
        xlabel('Time Step Size');
        ylabel('Condition Number');
        grid on;
    end
end
