function [] = manage_path(action)
% Add/Remove folders containing pricing functions to/from the search path
%
% In order to use the project's functions, you have to add the subfolders
% containing these functions to Matlab's search path.
% By running the function with the argument 'restore', the folders will be
% removed from Matlab search path. The search path will be restored to its
% previous state.
%
% INPUT  'set' ...... Add folders to search path
%        'restore' .. Remove folders from search path
%
% OUTPUT  void
%
% danilo.zocco@gmail.com, 2017-12-12
    
    folder_name = 'Functions';

    % Add folder and subfolders with needed functions to the search path
    if strcmp(action,'set')
        func_path = fullfile(pwd,folder_name);  % Path to functions' folder
        func_folder = genpath(func_path);       % String of folder and subfolders
        addpath(func_folder, '-begin')          % Add folders to search path
        
    % Restore the search path to the initial state
    elseif strcmp(action,'restore')
        func_path = fullfile(pwd,folder_name);  % Path to functions' folder
        func_folder = genpath(func_path);       % String of folder and subfolders
        rmpath(func_folder)                     % Remove folders from search path
    end
end