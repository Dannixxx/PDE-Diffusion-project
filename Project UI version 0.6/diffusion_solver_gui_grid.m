
function diffusion_solver_gui_grid()
    %% Create main GUI window using uifigure
    hFig = uifigure('Name','PDE Diffusion Solver','Position',[40 40 800 700]);  % Adjusted height of the figure


    % Create a grid layout with 3 rows for the main layout
    mainGrid = uigridlayout(hFig, [3, 3]);
    mainGrid.RowHeight = {'fit', 'fit', '1x'};  % The last row for results will take remaining space
    mainGrid.ColumnWidth = {'2x', 'fit', '2x'}; % Columns: parameters (left), solve button (middle), plots (right)

    %% Parameters Section (Left Portion)
    paramGrid = uigridlayout(mainGrid, [13, 3]); % Increased rows to include Time of Simulation
    paramGrid.Layout.Row = 1;
    paramGrid.Layout.Column = 1;
    paramGrid.RowHeight = repmat({'fit'}, 1, 13); % Equal row heights for uniformity
    paramGrid.ColumnWidth = {'fit', '1x', 'fit'}; % Three columns: labels, value boxes, checkboxes

    % Title for Parameter Options
    uilabel(paramGrid,'Text','Parameter Options','FontWeight','bold','HorizontalAlignment','center');
    uilabel(paramGrid,'Text',''); % Blank for spacing
    uilabel(paramGrid,'Text',''); % Blank for spacing

    % Spatial Step Sizes
    uilabel(paramGrid,'Text','Spatial Step Size 1 (dx1):','HorizontalAlignment','left');
    hSpatialStep1 = uieditfield(paramGrid,'numeric','Value',0.05,'Editable','on','ValueDisplayFormat','%.4f cm','Limits', [0 1]);
    chk_dx1 = uicheckbox(paramGrid, 'Text', '','Value',0); % Checkbox for dx1

    uilabel(paramGrid,'Text','Spatial Step Size 2 (dx2):','HorizontalAlignment','left');
    hSpatialStep2 = uieditfield(paramGrid,'numeric','Value',0.02,'Editable','on','ValueDisplayFormat','%.4f cm','Limits', [0 1]);
    chk_dx2 = uicheckbox(paramGrid, 'Text', ''); % Checkbox for dx2

    uilabel(paramGrid,'Text','Spatial Step Size 3 (dx3):','HorizontalAlignment','left');
    hSpatialStep3 = uieditfield(paramGrid,'numeric','Value',0.01,'Editable','on','ValueDisplayFormat','%.4f cm','Limits', [0 1]);
    chk_dx3 = uicheckbox(paramGrid, 'Text', ''); % Checkbox for dx3

    % Time Step Sizes
    uilabel(paramGrid,'Text','Time Step Size 1 (dt1):','HorizontalAlignment','left');
    hTimeStep1 = uieditfield(paramGrid,'numeric','Value',0.01,'Editable','on','ValueDisplayFormat','%.4f s','Limits', [0 1]);
    chk_dt1 = uicheckbox(paramGrid, 'Text', '','Value',0); % Checkbox for dt1

    uilabel(paramGrid,'Text','Time Step Size 2 (dt2):','HorizontalAlignment','left');
    hTimeStep2 = uieditfield(paramGrid,'numeric','Value',0.005,'Editable','on','ValueDisplayFormat','%.4f s','Limits', [0 1]);
    chk_dt2 = uicheckbox(paramGrid, 'Text', ''); % Checkbox for dt2

    uilabel(paramGrid,'Text','Time Step Size 3 (dt3):','HorizontalAlignment','left');
    hTimeStep3 = uieditfield(paramGrid,'numeric','Value',0.001,'Editable','on','ValueDisplayFormat','%.4f s','Limits', [0 1]);
    chk_dt3 = uicheckbox(paramGrid, 'Text', ''); % Checkbox for dt3

    % Diffusion Coefficient
    uilabel(paramGrid,'Text','Diffusion Coeff (a^2):','HorizontalAlignment','left');
    hDiffCoeff = uieditfield(paramGrid,'numeric','Value',0.119,'Editable','on','ValueDisplayFormat','%.4f cm^2/s','Limits', [0 Inf]);
    uilabel(paramGrid,'Text',''); % Blank for spacing

    % Length of Tube (Properly Aligned)
    uilabel(paramGrid,'Text','Length of Tube (L):','HorizontalAlignment','left');
    hTubeLength = uieditfield(paramGrid,'numeric','Value',20,'Editable','on','ValueDisplayFormat','%.2f cm','Limits', [0 Inf]);
    uilabel(paramGrid,'Text',''); % Blank for spacing

    % Time of Simulation (New Parameter)
    uilabel(paramGrid,'Text','Time of Simulation (T):','HorizontalAlignment','left');
    hSimTime = uieditfield(paramGrid,'numeric','Value',20,'Editable','on','ValueDisplayFormat','%.2f s','Limits', [0 Inf]);  % Editable field for simulation time
    uilabel(paramGrid,'Text',''); % Blank for spacing

    % Error Tolerance for PDEPE Solver (RelTol and AbsTol)
    uilabel(paramGrid,'Text','RelTol:','HorizontalAlignment','left');
    hRelTol = uieditfield(paramGrid,'numeric','Value',1e-10,'Editable','on','Limits', [0 1]);
    uilabel(paramGrid,'Text',''); % Blank for spacing

    uilabel(paramGrid,'Text','AbsTol:','HorizontalAlignment','left');
    hAbsTol = uieditfield(paramGrid,'numeric','Value',1e-10,'Editable','on','Limits', [0 1]);
    uilabel(paramGrid,'Text',''); % Blank for spacing

    %% Plot Options Section (Right Portion)
    plotGrid = uigridlayout(mainGrid, [4, 1]); 
    plotGrid.Layout.Row = 1;
    plotGrid.Layout.Column = 3;

    uilabel(plotGrid,'Text','Plot Options','FontWeight','bold'); 
    chk_plot2d = uicheckbox(plotGrid,'Text','2D Plot (Space/Concentration)');
    chk_plot3d = uicheckbox(plotGrid,'Text','3D Plot');
    chk_plot_pdepe = uicheckbox(plotGrid,'Text','Plot PDEPE Solution');
    chk_cond_time = uicheckbox(plotGrid,'Text','Plot Condition Number (Time step)');
    chk_cond_space = uicheckbox(plotGrid,'Text','Plot Condition Number (Spatial step)');
    chk_trunc_error_time = uicheckbox(plotGrid,'Text','Plot Local Truncation Error (Time step)');
    chk_trunc_error_space = uicheckbox(plotGrid,'Text','Plot Local Truncation Error (Spatial step)');
    chk_rel_error_time = uicheckbox(plotGrid,'Text','Plot Relative Error (Time step)');
    chk_rel_error_space = uicheckbox(plotGrid,'Text','Plot Relative Error (Spatial step)');
    chk_savefig= uicheckbox(plotGrid,'Text','Save the plot as png');
    

   %% Results Section (Bottom Portion)
    panel_result = uigridlayout(mainGrid, [1, 1]); 
    panel_result.Layout.Row = 3;
    panel_result.Layout.Column = [1, 3]; % Spans all 3 columns
    panel_result.RowHeight = {'2x'};  % Compact result area height
    % Result Panel
    global uitext_results;  % Make the uitext_results accessible
    panel_result = uipanel('Parent', panel_result, 'Title', 'Result Area', 'FontSize', 12, 'BackgroundColor', 'white', 'Tag', 'panel_result');
    uitext_results = uitextarea('Parent',panel_result,'InnerPosition',[10, 10, panel_result.Position(3)+500, panel_result.Position(4)-60],'HorizontalAlignment','left', 'Editable', 'off', 'Tag', 'result_text');
    
    %uitext_results.Value = 'Results will appear here after solving...';
    warning= sprintf("                                                                                          ❌ ATTENTION ❌ \n" + ...
    "This code project can generate several plots for a complete study of the problem (high time and power consuming), in the user interface the user can choose specific extra plots. Moreover there is the possibility to save the plots in the folder 'Figures'.    \n However there will be graphs that will be shown without choice, including: \n" + ...
    "       ➜ solution in 3D, \n       ➜ for the trend of the relative error and truncation as the spatial step dx and dt increases,\n" + ...
    "       ➜ for the conditioning number \n       ➜ for the stability evaluation for the Explicit Euler method. \n \n Results will appear here after solving...");
    uitext_results.Value = warning;

    % Define the Figures folder path
    global figuresFolder
    % Define the Figures folder path
    figuresFolder = fullfile(pwd, 'Figures');  % 'pwd' returns the current working directory


    % save r values
    % Define the Results folder path
    resultFolder = fullfile(pwd, 'Results');  % 'pwd' returns the current working directory
    % Check if the Results folder exists, if not, create it
    if  ~exist(resultFolder, 'dir')
        mkdir(resultFolder);
    end

    
    %% Solve Button Section (Middle Portion)
    buttonGrid = uigridlayout(mainGrid, [1, 1]); 
    buttonGrid.Layout.Row = 2;
    buttonGrid.Layout.Column = [1, 3]; % Spans all 3 columns
   
    uibutton(buttonGrid, 'Text', 'Solve', 'ButtonPushedFcn', @(btn,event) onSolveButtonPushed());

    function onSolveButtonPushed()
    btn.Enable = 'off'
    uitext_results.Value = "Solving diffusion equation...";
    drawnow;
    close all
    clc
    
     % Check if the Figures folder exists, if not, create it
    if chk_savefig.Value && ~exist(figuresFolder, 'dir')
        mkdir(figuresFolder);
    end

    % Call the solve_problem function
    [result_text,k,lengthSpace,lengthTime,r] = solve_problem([chk_dx1.Value, chk_dx2.Value, chk_dx3.Value], ...
    [hSpatialStep1.Value, hSpatialStep2.Value, hSpatialStep3.Value], ...
    [chk_dt1.Value, chk_dt2.Value, chk_dt3.Value], ...
    [hTimeStep1.Value, hTimeStep2.Value, hTimeStep3.Value], ...
    hDiffCoeff.Value, hTubeLength.Value, hSimTime.Value, hRelTol.Value, hAbsTol.Value, ...
    chk_plot2d.Value,chk_plot3d.Value, chk_plot_pdepe.Value, chk_cond_time.Value, ...
    chk_cond_space.Value, chk_trunc_error_time.Value, chk_trunc_error_space.Value, ...
    chk_rel_error_time.Value, chk_rel_error_space.Value,chk_savefig.Value,figuresFolder);
    
        if k~=0 && lengthSpace ~=0  && lengthTime ~=0
            lenght=lengthSpace+lengthTime;
            filename = sprintf("Result_text_%d iterations_%d Parameters.txt", (k-1), lenght);
 
            file_name_results = fullfile(resultFolder,filename);

            % Open the .txt file in write mode
            fileID = fopen(file_name_results, 'w');
            
            % Write text to the file
            fprintf(fileID,'%s', result_text);
            
            % Close the file
            fclose(fileID);

            filename_r=sprintf("Result_values_r_%d iterations_%d Parameters.mat", (k-1), lenght);
            file_name_results = fullfile(resultFolder,filename_r);
            save(file_name_results,'r','-mat');
        end
    
    % Update the UI result text area with the result
    uitext_results.Value = result_text;
    drawnow;  % Forcing UI updates 
    btn.Enable = 'on';
end

    
end