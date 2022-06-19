% This program is used for getting the frequency distribution data analysis
% window and the frequency distribution table along with additional
% features for the maximum usage performance of the program

% TOPICS COVERED: Basic Commands and Functions, Matrices, Different Types
% of Equations and Polynomials, Graphing 2D Plots

% ADDITIONAL FEATURES: inputdlg, isempty(), return statement, num2cell, 
% length(), break statement, min and max functions, questdlg, lower(), 
% preallocating arrays, uicontrol(listbox, pushbutton, edit, text), 
% Callback property(object handle and event), uifigure, uitable, 
% fopen() and fclose()



% Declaring the main function or the scriptfile name as main
function FDT  
    % Constant Values
    standard_addition = 1;
    consts_0 = 0.5;
    
    
    % While loop for the total number of elements and elements be equal in
    % length
    while true
            % Getting inputs
            prompt = ["Total Number of Elements",...
                      "Elements separated by"...
                      + " spaces in between"];
            title1 = "Input Details";
            dims = [1 25; 1 100];
    
            input_details = inputdlg(prompt, title1, dims);
    
            % condition for cancelling by user
            if isempty(input_details)
                return;
            end
    
            % Getting seperated outputs from inputs
            separate = num2cell(input_details);
            [count_elements, elements] = separate{:};
    
           
            % Converting string to num and double
            count_elements = str2double(count_elements);
            elements = sort(str2num(elements{:}));
            % NOTE: The yellow warning is not accurate and not detecting
            % the true nature of the elements, it is not a double but an
            % array so it should be converted from strings to numeric form,
            % the warning assumes that the input contains
            % only one digit which is not in this case
        
            if count_elements == length(elements)
                break
            end
    end
    
    
    % Getting the lowest and highest in the elements
    lowest = min(elements);
    highest = max(elements);
    
    
    % Getting the range using highest and lowest values
    range = highest - lowest;
    
    
    % Getting the number of rows
    quest = "Do you want to specify number of rows?";
    dlgtitle = "Input Details";
    btn1 = "Yes";
    btn2 = "No";
    defbtn = "No";
    
    % Getting the permission to specify the number of rows
    ask_specify_num_rows = questdlg(quest, dlgtitle, btn1, btn2, defbtn);
    
    
    % Conditional statements about specifying the number of rows 
    if lower(ask_specify_num_rows) == "yes"
        prompt = "Specify Number of Rows";
        title1 = "Input Details";
        dims = [1 20];
        
        input_details = inputdlg(prompt, title1, dims);
        % condition for cancelling by user
        if isempty(input_details)
            return;
        end
    
        number_rows = str2double(input_details);
    
    elseif lower(ask_specify_num_rows) == "no"
        % Standard formula in getting the number of rows
        number_rows = round(1 + (3.3 * log10(count_elements)));
    end
    
    
    % Getting the class size
    quest = "Do you want to specify class size";
    dlgtitle = "Input Details";
    btn1 = "Yes";
    btn2 = "No";
    defbtn = "No";
    
    % Getting the permission to specify the class size
    ask_specify_class_size = questdlg(quest, dlgtitle, btn1, btn2, defbtn);
    
    
    % Conditional statements about specifying the class size
    if lower(ask_specify_class_size) == "yes"
        prompt = "Specify Class size";
        title1 = "Input Details";
        dims = [1 20];
        
        input_details = inputdlg(prompt, title1, dims);
        % condition for cancelling by user
        if isempty(input_details)
            return;
        end
    
        class_size = str2double(input_details);
        
    elseif lower(ask_specify_class_size) == "no"
        % Standard formula in getting the class size
        class_size = round(range / number_rows);
    end
    
    % Calculation Phase
    
    % The zeros, ones, and eye are acting as preallocating arrays for the
    % values inside the 'for loops' for speed management and memory
    % efficiency
    
    
    % Preallocating arrays
    actual_lower_limit = zeros(1, number_rows);
    actual_upper_limit = ones(1, number_rows);
    
    
    % Calculating the initial lower and upper limits
    for i = 0:number_rows - 1
        lower_limit = lowest + (class_size * i);
        upper_limit = (lowest + (class_size * (i + standard_addition)))...
                       - standard_addition;
        actual_lower_limit(i + 1) = lower_limit;
        actual_upper_limit(i + 1) = upper_limit;
    end
    
    
    % Getting the interval between lower limit and upper limit
    interval = actual_upper_limit(1) - actual_lower_limit(1) + 1;
    
    
    % Getting the actual limits of the lower limits and upper limits
    actual_limits = zeros(number_rows, interval);
    
    
    % Getting the actual cm
    actual_cm = zeros(1, number_rows);
    
    
    % Getting the actual lower and upper class boundaries
    actual_lower_class_bound = zeros(1, number_rows);
    actual_upper_class_bound = zeros(1, number_rows);
    
    
    % Creating for loop to get limits, lower and upper class boundaries,
    % and CM
    for i = 1:1:number_rows
        % Calculating the initial limit
        limit = actual_lower_limit(i):actual_upper_limit(i);
        actual_limits(i,:) = limit;
    
        % Calculating the inital class boundaries
        lower_class_bound = actual_lower_limit(i) - consts_0;
        upper_class_bound = actual_upper_limit(i) - consts_0;
        actual_lower_class_bound(i) = lower_class_bound;
        actual_upper_class_bound(i) = upper_class_bound;
        
        % Calculating the initial cm
        cm_i = (actual_lower_limit(i) + actual_upper_limit(i)) / 2;
        cm = round(cm_i, 2);
        actual_cm(:, i) = cm;
    end
    
    
    % Getting the initial frequency (matrices)
    initial_frequency = zeros(number_rows, count_elements);
    
    
    % Creating for loop to get the initial frequency or the matrices of 0's
    % and 1's
    for i = 1:1:number_rows
        % calculating the initial frequency
        frequency = ismember(elements, actual_limits(i, :));
        initial_frequency(i, :) = frequency;
    end
    
    
    % Getting the actual frequency count (array)
    actual_frequency = zeros(1, number_rows);
    
    
    % Creating for loop in getting the actual frequency
    for i = 1:1:number_rows
        % Calculating the almost frequency
        almost_frequency = sum(initial_frequency(i, :));
        actual_frequency(1, i) = almost_frequency;
    end
    
    
    % Getting the total frequency
    total_frequency = sum(actual_frequency);
    
    
    % Getting the actual cm
    actual_fcm = zeros(1, number_rows);
    
    
    % Creating for loop to get the initial fcm
    for i = 1:1:number_rows
        % Calculating the initial fcm
        fcm = actual_frequency(i) * actual_cm(i);
        actual_fcm(1, i) = fcm;
    end
    
    
    % Getting the total fcm
    total_fcm = sum(actual_fcm);
    
    
    % Getting the actual less than cf
    actual_lessthan_cf = zeros(1, number_rows);
    
    
    % Getting the length for the for loop to get the initial less than
    % cumulative frequency
    len_f = length(actual_frequency);
    for i = 0:1:len_f - 1
        % Calculating the initial less than cf
        less_cf = sum(actual_frequency(1:i+1));
        actual_lessthan_cf(1, i + 1) = less_cf;
    end
    

    
    % Making GUI for the outputs
    
    
    % Creating the class interval and class boundaries
    class_interval = actual_lower_limit + " - " + actual_upper_limit;
    class_bound = actual_lower_class_bound + " - " +...
                  actual_upper_class_bound;
    
    % Transposing outputs to input the data inside the uitable
    trans_actual_lower_limit = actual_lower_limit';
    trans_actual_upper_limit = actual_upper_limit';
    trans_actual_frequency = actual_frequency';
    trans_actual_cm = actual_cm';
    trans_actual_fcm = actual_fcm';
    trans_actual_lessthan_cf = actual_lessthan_cf';
    
    
    % Creating the main figure
    main_figure = figure;
    main_figure.Name = "Frequency Distribution Data Analysis";
    main_figure.Units = "normalized";
    main_figure.Position = [0.05 0.25 0.9 0.5];
    set(main_figure, 'Resize', 'off')
    
    
    % Creating the listbox for the class interval
    listbox_ui = uicontrol('Parent', main_figure);
    listbox_ui.Style = 'listbox';
    listbox_ui.String = ["Class Interval" class_interval];
    listbox_ui.Position = [25 220 140 300];
    listbox_ui.FontUnits = "normalized";
    listbox_ui.FontSize = 0.05;
    listbox_ui.FontName = 'Arial';
    
    
    % Creating the listbox for the class boundaries
    listbox_2_ui = uicontrol('Parent', main_figure);
    listbox_2_ui.Style = 'listbox';
    listbox_2_ui.String = ["Class Boundaries" class_bound];
    listbox_2_ui.Position = [170 220 140 300];
    listbox_2_ui.FontUnits = "normalized";
    listbox_2_ui.FontSize = 0.05;
    listbox_2_ui.FontName = 'Arial';


    % Creating the listbox for the total frequency
    listbox_2_ui = uicontrol(main_figure);
    listbox_2_ui.Style = 'listbox';
    listbox_2_ui.String = ["Total frequency" total_frequency];
    listbox_2_ui.Position = [25 60 140 100];
    listbox_2_ui.FontUnits = "normalized";
    listbox_2_ui.FontSize = 0.15;
    listbox_2_ui.FontName = 'Arial';


    % Creating the listbox for the total fcm
    listbox_2_ui = uicontrol('Parent', main_figure);
    listbox_2_ui.Style = 'listbox';
    listbox_2_ui.String = ["Total f(CM)" total_fcm];
    listbox_2_ui.Position = [170 60 140 100];
    listbox_2_ui.FontUnits = "normalized";
    listbox_2_ui.FontSize = 0.15;
    listbox_2_ui.FontName = 'Arial';
    
    
    % Creating the axes for the bar graph of frequency, cm, fcm, <cf
    axis1 = axes('Parent', main_figure, 'Position', [0.223 .4 .35 .56]);
    set(gca, 'xticklabel', '', 'yticklabel', '');

     % Creating axes for the log data analysis
    axis2 = axes('Parent', main_figure, 'Position', [0.6 .4 .1 .56]);
    set(gca, 'xticklabel', '', 'yticklabel', '');

    axis3 = axes('Parent', main_figure, 'Position', [0.73 .4 .1 .56]);
    set(gca, 'xticklabel', '', 'yticklabel', '');

    axis4 = axes('Parent', main_figure, 'Position', [0.86 .4 .1 .56]);
    set(gca, 'xticklabel', '', 'yticklabel', '');
    
    
    % Creating a pushbutton for plotting data
    pushbutton_plot_ui = uicontrol('Parent', main_figure);
    pushbutton_plot_ui.Style = 'pushbutton';
    pushbutton_plot_ui.String = "Plot Data";
    pushbutton_plot_ui.Position = [385 130 100 30];
    pushbutton_plot_ui.Callback = @plotdata;
    
    
    % Option for removing data
    pushbutton_plot_ui = uicontrol('Parent', main_figure);
    pushbutton_plot_ui.Style = 'pushbutton';
    pushbutton_plot_ui.String = "Remove Plot Data";
    pushbutton_plot_ui.Position = [500 130 100 30];
    pushbutton_plot_ui.Callback = @removeplotdata;
    
    
    % Creating a pushbutton for showing the table
    pushbutton_table_ui = uicontrol('Parent', main_figure);
    pushbutton_table_ui.Style = 'pushbutton';
    pushbutton_table_ui.String = "Show Table";
    pushbutton_table_ui.Position = [665 130 100 30];
    pushbutton_table_ui.Callback = @showtable;

    
    % Creating a simple text editor for analyzing and jotting down notes
    % about the graph
    text_ui = uicontrol('Parent', main_figure);
    text_ui.Style = 'edit';
    text_ui.String = 'Data Analysis Notes';
    text_ui.HorizontalAlignment = 'left';
    text_ui.Max = 2;
    text_ui.Min = 0;
    text_ui.Position = [1040 20 500 150];


    % Creating a push button for the user to be able to save the txt
    text_save_ui = uicontrol('Parent', main_figure);
    text_save_ui.Style = 'pushbutton';
    text_save_ui.String = 'Save as Text File';
    text_save_ui.Position = [1560 141 100 30];
    text_save_ui.Callback = @savefile;


    % Creating a push button for the user to delete the strings in the edit
    % text box
    text_delete_ui = uicontrol('Parent', main_figure);
    text_delete_ui.Style = 'pushbutton';
    text_delete_ui.String = 'Delete';
    text_delete_ui.Position = [1560 101 100 30];
    text_delete_ui.Callback = @deletetext;


    % Creating a note for the user in saving file
    static_text = uicontrol('Parent', main_figure);
    static_text.Style = 'text';
    static_text.String = ['When "Save as Text File" is pressed, the' ...
                          ' file will be directed in the installation ' ...
                          'folder of MATLAB named "Data Analysis Notes"'];
    static_text.FontSize = 7;
    static_text.Position = [1563 9 100 80];



    % Creating callback functions
    function plotdata(~, ~)
        % Plotting the bar graph
        x = [actual_frequency; actual_cm; actual_fcm; actual_lessthan_cf];
        bar(x, 'Parent', axis1);
        title('Bar and Logarithmic Data Analysis', 'Parent', axis1)
        xlabel('Data Types', 'Parent', axis1);
        ylabel('Values', 'Parent', axis1);
        grid(axis1, 'on');
        set(axis1, 'xticklabel', ["Frequency" "CM" "f(CM)" "<cf"]);
        leg = strings(1, number_rows);
        for j = 1:1:number_rows
            leg(1, j) = j;
        end
        legend(axis1, leg)
        
        % Plotting the graphs of logarithmic analysis of frequency
        value = actual_frequency;
        t = 1:1:length(value);

        % Plotting semilogx of frequency
        semilogx(t, value, 'Parent', axis2, 'Color', 'green',...
                 'LineWidth', 1.5, 'Marker', 'o', 'MarkerEdgeColor',...
                 'red');
        grid(axis2, 'on')
        title('Semilogx of Frequency', 'Parent', axis2)
        xlabel('x-axis', 'Parent', axis2)
        ylabel('y-axis', 'Parent', axis2)

        % Plotting semilogy of frequency
        semilogy(t, value, 'Parent', axis3, 'Color',...
                 [0.9100 0.4100 0.1700], 'LineWidth', 1.5, 'Marker',...
                 'o', 'MarkerEdgeColor', 'magenta');
        grid(axis3, 'on')
        title('Semilogy of Frequency', 'Parent', axis3)
        xlabel('x-axis', 'Parent', axis3)
        ylabel('y-axis', 'Parent', axis3)

        % Plotting loglog of frequency
        loglog(t, value, 'Parent', axis4, 'Color', 'cyan',...
               'LineWidth', 1.5, 'Marker', 'o', 'MarkerEdgeColor', 'blue');
        grid(axis4, 'on')
        title('Loglog of Frequency', 'Parent', axis4)
        xlabel('x-axis', 'Parent', axis4)
        ylabel('y-axis', 'Parent', axis4)
    end
    

    % Option for the user to remove the plotted data
    function removeplotdata(~, ~)
        % Removing the axis1 graph properties and the graph itself
        y = [];
        bar(y, 'Parent', axis1)
        title('', 'Parent', axis1)
        xlabel('', 'Parent', axis1);
        ylabel('', 'Parent', axis1);
        set(axis1, 'xticklabel', '', 'yticklabel', '');

        % Removing the axis2 graph properties and the graph itself
        y = [];
        bar(y, 'Parent', axis2)
        title('', 'Parent', axis2)
        xlabel('', 'Parent', axis2);
        ylabel('', 'Parent', axis2);
        set(axis2, 'xticklabel', '', 'yticklabel', '');

        % Removing the axis3 graph properties and the graph itself
        y = [];
        bar(y, 'Parent', axis3)
        title('', 'Parent', axis3)
        xlabel('', 'Parent', axis3);
        ylabel('', 'Parent', axis3);
        set(axis3, 'xticklabel', '', 'yticklabel', '');

        % Removing the axis4 graph properties and the graph itself
        y = [];
        bar(y, 'Parent', axis4)
        title('', 'Parent', axis4)
        xlabel('', 'Parent', axis4);
        ylabel('', 'Parent', axis4);
        set(axis4, 'xticklabel', '', 'yticklabel', '');
    end
    
    
    % Creating option for the user to show the frequency distribution
    % table
    function showtable(~, ~)
        % data to input
        data = [trans_actual_lower_limit trans_actual_upper_limit...
                trans_actual_frequency trans_actual_cm trans_actual_fcm...
                trans_actual_lessthan_cf];
        
        % Field names for the data
        columnname = ["Lower limit", "Upper limit", "Frequency", "CM",...
                      "f(CM)", "<cf"];
        
        % Creating the Parent main figure
        figure2 = uifigure("Name", "Frequency Distribution Table",...
                           "WindowStyle", "alwaysontop", "Units",...
                           "normalized", "Position", [0.3 0.5 0.5 0.25]);
        
        % Creating the uitable Children for the Parent main figure
        t = uitable(figure2);
        t.Units = "normalized";
        t.Position = [0 0 1 0.92];
        t.Data = data;
        t.ColumnName = columnname;
    end


    % Creating function for the button to save
    % Unfortunately this is going to be saved in the MATLAB
    % installation folder as it is hard to pinpoint where to save the file
    % properly because computers have different names of user
    function savefile(~, ~)
        txt_file = fopen('Data Analysis Notes.txt', 'wt');
        fprintf(txt_file, '%s', get(text_ui, 'String'));
        fclose(txt_file);
    end

    
    % Creating function for the button to delete the text
    function deletetext(~, ~)
        set(text_ui, 'String', '');
    end
end