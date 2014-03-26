
root_dir = fileparts(mfilename('fullpath'));

rmpath(fullfile(root_dir,'data'))
rmpath(fullfile(root_dir,'matlab'))
rmpath(fullfile(root_dir,'matlab','trackingApp'))
rmpath(fullfile(root_dir,'matlab','utilities'))
rmpath(fullfile(root_dir,'model'))
rmpath(fullfile(root_dir,'work'))
%Simulink.fileGenControl('reset')

clear root_dir

