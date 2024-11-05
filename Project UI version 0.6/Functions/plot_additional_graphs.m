

% Compute and plot condition numbers and errors
function plot_additional_graphs(cond_numEE,cond_numIE,cond_numCN,LTE_EE,GTE_EE,RTE_EE,LTE_IE,GTE_IE,RTE_IE,LTE_CN,GTE_CN,RTE_CN, activeSpatialSteps, activeTimeSteps, plotCondTime, plotCondSpace, plotTruncErrorTime, plotTruncErrorSpace, plotRelErrorTime, plotRelErrorSpace,plot_savefig,figuresFolder)
    
    % % % xmesh = linspace(0, 1,1000);
    % % % tmesh = linspace(0, 1,1000);

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
        LTE_Time=plot_truncation_error_vs_time(LTE_EE, LTE_IE, LTE_CN, activeSpatialSteps, activeTimeSteps);
        if plot_savefig
                file_nameLTE_Time= fullfile(figuresFolder, sprintf("Local Truncation Error vs Time Step.png"));
             saveas(LTE_Time,file_nameLTE_Time,'png')
        end
    end
    if plotTruncErrorSpace
        LTE_Space=plot_truncation_error_vs_space(LTE_EE, LTE_IE, LTE_CN, activeSpatialSteps, activeTimeSteps);
        if plot_savefig
                file_nameLTE_Space= fullfile(figuresFolder, sprintf("Local Truncation Error vs Space Step.png"));
             saveas(LTE_Space,file_nameLTE_Space,'png')
        end
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
        plot(activeSpatialSteps, cond_numEE(:,i), '-or', activeSpatialSteps, cond_numIE(:,i), '-og', activeSpatialSteps, cond_numCN(:,i), '-ob');
        title(sprintf('Condition Number vs Spatial Step (Time Step = %.3f)', activeTimeSteps(i)));
        legend('Explicit Euler','Implicit Euler',  'Crank-Nicolson');
        xlabel('Spatial Step Size');
        ylabel('Condition Number');
        grid on;

    end
    
end


function condSpace=plot_condition_number_vs_space(cond_numEE, cond_numIE, cond_numCN, activeSpatialSteps, activeTimeSteps)
    condSpace=figure('Name', 'Condition Number vs Spatial Step'); 

    % Loop over each spatial step
    for i = 1:length(activeSpatialSteps)
        subplot(length(activeSpatialSteps), 1, i);
        plot(activeTimeSteps, cond_numEE(i,:), '-or', activeTimeSteps, cond_numIE(i,:), '-og', activeTimeSteps, cond_numCN(i,:), '-ob');
        title(sprintf('Condition Number vs Time Step (Spatial Step = %.3f)', activeSpatialSteps(i)));
        legend('Explicit Euler','Implicit Euler','Crank-Nicolson');
        xlabel('Time Step Size');
        ylabel('Condition Number');
        grid on;
    end
end

function LTE_Time=plot_truncation_error_vs_time(LTE_EE, LTE_IE, LTE_CN, activeSpatialSteps, activeTimeSteps)
    LTE_Time=figure('Name', 'LTE (Local Truncation Error) vs Time Step'); 
    
    % Loop over each time step
    for i = 1:length(activeTimeSteps)
        subplot(length(activeTimeSteps), 1, i);
        plot(activeSpatialSteps, LTE_EE(:,i), '-or', activeSpatialSteps, LTE_IE(:,i), '-og', activeSpatialSteps, LTE_CN(:,i), '-ob');
        title(sprintf('LTE vs Spatial Step (Time Step = %.3f)', activeTimeSteps(i)));
        legend('Explicit Euler','Implicit Euler','Crank-Nicolson');
        xlabel('Spatial Step Size');
        ylabel('LTE');
        ylim([0 5]);
        grid on;

    end
    
end

function LTE_Space=plot_truncation_error_vs_space(LTE_EE, LTE_IE, LTE_CN, activeSpatialSteps, activeTimeSteps)
    LTE_Space=figure('Name', 'LTE (Local Truncation Error) vs Space Step'); 
    
    % Loop over each spatial step
    for i = 1:length(activeSpatialSteps)
        subplot(length(activeSpatialSteps), 1, i);
        plot(activeTimeSteps, LTE_EE(i,:), '-or', activeTimeSteps, LTE_IE(i,:), '-og', activeTimeSteps, LTE_CN(i,:), '-ob');
        title(sprintf('LTE vs Time Step (Spatial Step = %.3f)', activeSpatialSteps(i)));
        legend('Explicit Euler','Implicit Euler','Crank-Nicolson');
        xlabel('Time Step Size');
        ylabel('LTE');
        ylim([0 5]);
        grid on;

    end
    
end