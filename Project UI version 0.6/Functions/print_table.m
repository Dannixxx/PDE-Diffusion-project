function print_tab=print_table(lengthTime,activeTimeSteps,lengthSpace,activeSpatialSteps,r,LTE_EE,GTE_EE,RTE_EE,LTE_IE,GTE_IE,RTE_IE,LTE_CN,GTE_CN,RTE_CN,cond_numEE,cond_numIE,cond_numCN)
%%% This function is used for build the tables in the result area
%% Stability Condition - r - Table (Explicit Euler Method)
% After the double loop for spatial and time steps:
    table_header_stab = sprintf('\n\n 🔶🔶🔶🔶 Stability Condition - r - Table (Explicit Euler Method):🔶🔶🔶🔶\n');
    time_step_header_stab = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_stab = [time_step_header_stab, sprintf(' %.4f |', activeTimeSteps(j))];
    end

     table_body_stab = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_stab = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_stab = [row_data_stab, sprintf(' %.4f |', r(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_stab = [table_body_stab, row_data_stab];
    end
    
    % Combine header, separator, and body to form the complete table
    stability_table = [table_header_stab, time_step_header_stab, table_body_stab, '\n'];
    stability_table=strjoin(stability_table, '\n');
    stability_tab= sprintf(stability_table);


%% Condition Number (Explicit Euler Method)
% After the double loop for spatial and time steps:
    table_header_condEE = sprintf('\n\n 🔶🔶🔶🔶 Condition Number (Explicit Euler Method):🔶🔶🔶🔶\n');
    time_step_header_condEE = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_condEE = [time_step_header_condEE, sprintf(' %.4f |', activeTimeSteps(j))];
    end

     table_body_condEE = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_condEE = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_condEE = [row_data_condEE, sprintf(' %.4f |', cond_numEE(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_condEE = [table_body_condEE, row_data_condEE];
    end
    
    % Combine header, separator, and body to form the complete table
    condEE_table = [table_header_condEE, time_step_header_condEE, table_body_condEE, '\n'];
    condEE_table=strjoin(condEE_table, '\n');
    condEE_tab= sprintf(condEE_table);

%% Condition Number (Implicit Euler Method)
% After the double loop for spatial and time steps:
    table_header_condIE = sprintf('\n\n 🔶🔶🔶🔶 Condition Number (Implicit Euler Method):🔶🔶🔶🔶\n');
    time_step_header_condIE = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_condIE = [time_step_header_condIE, sprintf(' %.4f |', activeTimeSteps(j))];
    end

     table_body_condIE = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_condIE = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_condIE = [row_data_condIE, sprintf(' %.4f |', cond_numIE(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_condIE = [table_body_condIE, row_data_condIE];
    end
    
    % Combine header, separator, and body to form the complete table
    condIE_table = [table_header_condIE, time_step_header_condIE, table_body_condIE, '\n'];
    condIE_table=strjoin(condIE_table, '\n');
    condIE_tab= sprintf(condIE_table);

%% Condition Number (Crank-Nicolson Method)
% After the double loop for spatial and time steps:
    table_header_condCN = sprintf('\n\n 🔶🔶🔶🔶 Condition Number (Crank-Nicolson Method):🔶🔶🔶🔶\n');
    time_step_header_condCN = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_condCN = [time_step_header_condCN, sprintf(' %.4f |', activeTimeSteps(j))];
    end

     table_body_condCN = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_condCN = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_condCN = [row_data_condCN, sprintf(' %.4f |', cond_numCN(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_condCN = [table_body_condCN, row_data_condCN];
    end
    
    % Combine header, separator, and body to form the complete table
    condCN_table = [table_header_condCN, time_step_header_condCN, table_body_condCN, '\n'];
    condCN_table=strjoin(condCN_table, '\n');
    condCN_tab= sprintf(condCN_table);  
   

%% Local Truncation Error Table (Explicit Euler Method)
    table_header_LTE_EE = sprintf('\n🔶🔶🔶🔶 Local Truncation Error Table (Explicit Euler Method):🔶🔶🔶🔶\n');
    time_step_header_LTE_EE = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_LTE_EE = [time_step_header_LTE_EE, sprintf(' %.4f |', activeTimeSteps(j))];
    end
    
     table_body_LTE_EE = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_LTE_EE = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            if LTE_EE(i, j) >10
               single_LTE_EE = sprintf(' %e |',LTE_EE(i, j));
            else 
                single_LTE_EE = sprintf(' %.4f |',LTE_EE(i, j));
            end
            row_data_LTE_EE = [row_data_LTE_EE, single_LTE_EE];
        end
        
        % Append the formatted row to the table body
        table_body_LTE_EE = [table_body_LTE_EE, row_data_LTE_EE];
    end
    
    % Combine header, separator, and body to form the complete table
    LTE_EE_table = [table_header_LTE_EE, time_step_header_LTE_EE, table_body_LTE_EE, '\n'];
    LTE_EE_table=strjoin(LTE_EE_table, '\n');
    LTE_EE_tab= sprintf(LTE_EE_table);

%% Local Truncation Error Table (Implicit Euler Method)
    table_header_LTE_IE = sprintf('\n🔶🔶🔶🔶 Local Truncation Error Table (Implicit Euler Method): 🔶🔶🔶🔶\n');
    time_step_header_LTE_IE = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_LTE_IE = [time_step_header_LTE_IE, sprintf(' %.4f |', activeTimeSteps(j))];
    end

     table_body_LTE_IE = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_LTE_IE = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_LTE_IE = [row_data_LTE_IE, sprintf(' %.4f |', LTE_IE(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_LTE_IE = [table_body_LTE_IE, row_data_LTE_IE];
    end
    
    % Combine header, separator, and body to form the complete table
    LTE_IE_table = [table_header_LTE_IE, time_step_header_LTE_IE, table_body_LTE_IE, '\n'];
    LTE_IE_table=strjoin(LTE_IE_table, '\n');
    LTE_IE_tab= sprintf(LTE_IE_table);

%% Local Truncation Error Table (Crank-Nicolson Method)
    table_header_LTE_CN = sprintf('\n 🔶🔶🔶🔶 Local Truncation Error Table (Crank-Nicolson Method): 🔶🔶🔶🔶\n');
    time_step_header_LTE_CN = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_LTE_CN = [time_step_header_LTE_CN, sprintf(' %.4f |', activeTimeSteps(j))];
    end

     table_body_LTE_CN = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_LTE_CN = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_LTE_CN = [row_data_LTE_CN, sprintf(' %.4f |', LTE_CN(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_LTE_CN = [table_body_LTE_CN, row_data_LTE_CN];
    end
    
    % Combine header, separator, and body to form the complete table
    LTE_CN_table = [table_header_LTE_CN, time_step_header_LTE_CN, table_body_LTE_CN, '\n'];
    LTE_CN_table=strjoin(LTE_CN_table, '\n');
    LTE_CN_tab= sprintf(LTE_CN_table);

    %% Global Truncation Error Table (Explicit Euler Method)
    table_header_GTE_EE = sprintf('\n 🔶🔶🔶🔶 Global Truncation Error Table (Explicit Euler Method): 🔶🔶🔶🔶\n');
    time_step_header_GTE_EE = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_GTE_EE = [time_step_header_GTE_EE, sprintf(' %.4f |', activeTimeSteps(j))];
    end
    
     table_body_GTE_EE = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_GTE_EE = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            if GTE_EE(i, j) >10
               single_GTE_EE = sprintf(' %e |',GTE_EE(i, j));
            else 
                single_GTE_EE = sprintf(' %.4f |',GTE_EE(i, j));
            end
            row_data_GTE_EE = [row_data_GTE_EE, single_GTE_EE];
        end
        
        % Append the formatted row to the table body
        table_body_GTE_EE = [table_body_GTE_EE, row_data_GTE_EE];
    end
    
    % Combine header, separator, and body to form the complete table
    GTE_EE_table = [table_header_GTE_EE, time_step_header_GTE_EE, table_body_GTE_EE, '\n'];
    GTE_EE_table=strjoin(GTE_EE_table, '\n');
    GTE_EE_tab= sprintf(GTE_EE_table);

%% Global Truncation Error Table (Implicit Euler Method)
    table_header_GTE_IE = sprintf('\n 🔶🔶🔶🔶 Global Truncation Error Table (Implicit Euler Method): 🔶🔶🔶🔶\n');
    time_step_header_GTE_IE = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_GTE_IE = [time_step_header_GTE_IE, sprintf(' %.4f |', activeTimeSteps(j))];
    end
  
     table_body_GTE_IE = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_GTE_IE = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_GTE_IE = [row_data_GTE_IE, sprintf(' %.4f |', GTE_IE(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_GTE_IE = [table_body_GTE_IE, row_data_GTE_IE];
    end
    
    % Combine header, separator, and body to form the complete table
    GTE_IE_table = [table_header_GTE_IE, time_step_header_GTE_IE, table_body_GTE_IE, '\n'];
    GTE_IE_table=strjoin(GTE_IE_table, '\n');
    GTE_IE_tab= sprintf(GTE_IE_table);

%% Global Truncation Error Table (Crank-Nicolson Method)
    table_header_GTE_CN = sprintf('\n 🔶🔶🔶🔶 Global Truncation Error Table (Crank-Nicolson Method): 🔶🔶🔶🔶 \n');
    time_step_header_GTE_CN = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_GTE_CN = [time_step_header_GTE_CN, sprintf(' %.4f |', activeTimeSteps(j))];
    end
    
     table_body_GTE_CN = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_GTE_CN = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_GTE_CN = [row_data_GTE_CN, sprintf(' %.4f |', GTE_CN(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_GTE_CN = [table_body_GTE_CN, row_data_GTE_CN];
    end
    
    % Combine header, separator, and body to form the complete table
    GTE_CN_table = [table_header_GTE_CN, time_step_header_GTE_CN, table_body_GTE_CN, '\n'];
    GTE_CN_table=strjoin(GTE_CN_table, '\n');
    GTE_CN_tab= sprintf(GTE_CN_table);

 %% Relative Truncation Error Table (Explicit Euler Method)
    table_header_RTE_EE = sprintf('\n 🔶🔶🔶🔶 Relative Truncation Error Table (Explicit Euler Method): 🔶🔶🔶🔶\n');
    time_step_header_RTE_EE = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_RTE_EE = [time_step_header_RTE_EE, sprintf(' %.4f |', activeTimeSteps(j))];
    end
    
     table_body_RTE_EE = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_RTE_EE = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            if RTE_EE(i, j) >10
               single_RTE_EE = sprintf(' %e |',RTE_EE(i, j));
            else 
                single_RTE_EE = sprintf(' %.4f |',RTE_EE(i, j));
            end
            row_data_RTE_EE = [row_data_RTE_EE, single_RTE_EE];
        end
        
        % Append the formatted row to the table body
        table_body_RTE_EE = [table_body_RTE_EE, row_data_RTE_EE];
    end
    
    % Combine header, separator, and body to form the complete table
    RTE_EE_table = [table_header_RTE_EE, time_step_header_RTE_EE, table_body_RTE_EE, '\n'];
    RTE_EE_table=strjoin(RTE_EE_table, '\n');
    RTE_EE_tab= sprintf(RTE_EE_table);

%% Relative Truncation Error Table (Implicit Euler Method)
    table_header_RTE_IE = sprintf('\n 🔶🔶🔶🔶 Relative Truncation Error Table (Implicit Euler Method): 🔶🔶🔶🔶\n');
    time_step_header_RTE_IE = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_RTE_IE = [time_step_header_RTE_IE, sprintf(' %.4f |', activeTimeSteps(j))];
    end
  
     table_body_RTE_IE = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_RTE_IE = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_RTE_IE = [row_data_RTE_IE, sprintf(' %.4f |', RTE_IE(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_RTE_IE = [table_body_RTE_IE, row_data_RTE_IE];
    end
    
    % Combine header, separator, and body to form the complete table
    RTE_IE_table = [table_header_RTE_IE, time_step_header_RTE_IE, table_body_RTE_IE, '\n'];
    RTE_IE_table=strjoin(RTE_IE_table, '\n');
    RTE_IE_tab= sprintf(RTE_IE_table);

%% Relative Truncation Error Table (Crank-Nicolson Method)
    table_header_RTE_CN = sprintf('\n 🔶🔶🔶🔶 Relative Truncation Error Table (Crank-Nicolson Method): 🔶🔶🔶🔶 \n');
    time_step_header_RTE_CN = 'Spatial Step / Time Step | ';  % Column header
    
    % Add each time step to the header
    for j = 1:lengthTime
        time_step_header_RTE_CN = [time_step_header_RTE_CN, sprintf(' %.4f |', activeTimeSteps(j))];
    end
    
     table_body_RTE_CN = "";  % Initialize an empty table body string
    
    % Loop through each spatial step to add rows
    for i = 1:lengthSpace
        row_data_RTE_CN = sprintf('      %.4f                       |', activeSpatialSteps(i));
        
        % Add each stability condition value for the current spatial step
        for j = 1:lengthTime
            row_data_RTE_CN = [row_data_RTE_CN, sprintf(' %.4f |', RTE_CN(i, j))];
        end
        
        % Append the formatted row to the table body
        table_body_RTE_CN = [table_body_RTE_CN, row_data_RTE_CN];
    end
    
    % Combine header, separator, and body to form the complete table
    RTE_CN_table = [table_header_RTE_CN, time_step_header_RTE_CN, table_body_RTE_CN, '\n'];
    RTE_CN_table=strjoin(RTE_CN_table, '\n');
    RTE_CN_tab= sprintf(RTE_CN_table);
  
    print_table=  strcat(stability_tab, '\n',condEE_tab, '\n',condIE_tab, '\n',condCN_tab, '\n' ,LTE_EE_tab, '\n',LTE_IE_tab, '\n',LTE_CN_tab, '\n',GTE_EE_tab, '\n',GTE_IE_tab, '\n',GTE_CN_tab, RTE_EE_tab, '\n',RTE_IE_tab, '\n',RTE_CN_tab, '\n');
    print_tab=sprintf(print_table);
    
end