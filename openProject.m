

root_dir = fileparts(mfilename('fullpath'));

addpath(fullfile(root_dir,'data'))
addpath(fullfile(root_dir,'data','imav'))
addpath(fullfile(root_dir,'data','imav','texture'))
addpath(fullfile(root_dir,'Drivers'))
addpath(fullfile(root_dir,'matlab'))
addpath(fullfile(root_dir,'matlab','trackingApp'))
addpath(fullfile(root_dir,'matlab','utilities'))
addpath(fullfile(root_dir,'model'))

if ~isdir(fullfile(root_dir,'work'))
    mkdir(fullfile(root_dir,'work'));
end

addpath(fullfile(root_dir,'work'))
%Simulink.fileGenControl('set','CacheFolder',fullfile(root_dir,'work'),'CodeGenFolder',fullfile(root_dir,'work'))
Simulink.fileGenControl('reset')
cd(fullfile(root_dir,'work'))

listModel = dir(fullfile(root_dir,'model','SimulationModel*.slx'));
listModel = {listModel.name};
height = 15*numel(listModel);
[oneModel,isValid] = listdlg('PromptString','Select a model:',...
                'SelectionMode','single','ListString',listModel,...
                'CancelString','Don''t Open anything','OKString','Open Model',...
                'ListSize',[250 height]);
if isValid
    open_system(listModel{oneModel});
else
    disp('You can open the model for simulation by running command: SimulationModel')
end
            
clear root_dir listModel isValid oneModel height


