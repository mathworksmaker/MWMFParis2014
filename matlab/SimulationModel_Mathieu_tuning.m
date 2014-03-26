%% Matlab script : simpleModelMC_tuning.m
% * Author : Mathieu Cuenant (mathieu.cuenant@mathworks.fr)
% * Date : 18-Mar-2014 18:42:19
% * Object : tune all controller at once

%% Define tunable blocks
% Interface with model
if controllerType == 0
    ST0 = slTuner(mdl_name,...
        {[mdl_name '/Controller/FeedbackController/BasicController/DistanceController'],...
        [mdl_name '/Controller/FeedbackController/BasicController/AngleController']});
elseif controllerType == 1
    ST0 = slTuner(mdl_name,...
        [mdl_name '/Controller/FeedbackController/DecouplingController/DecouplingGain']);
end
% ST0.Ts = Ts;

addPoint(ST0,{'Udist','Uangle','ThetaEstimate','DistanceEstimate','ThetaRef','DistanceRef','Command'})

% Set PID type
% basicBlock = 'pi';
% setBlockParam(ST0,'AngleController',ltiblock.pid('AngleController',basicBlock));
% setBlockParam(ST0,'DistanceController',ltiblock.pid('DistanceController',basicBlock));
% showBlockValue(ST0)

%% Set requirements
% trackingReq = TuningGoal.Tracking({'ThetaRef','DistanceRef'},{'ThetaEstimate','DistanceEstimate'},0.1);
trackingReq = TuningGoal.StepResp({'ThetaRef','DistanceRef'},{'ThetaEstimate','DistanceEstimate'},0.1,0);

marginReq = TuningGoal.Margins('Command',7,50);
Wrej = 1e-3*frd(db2mag([-20 0 20 20]),[1e-3 0.01 0.1 10]*2*pi); % max gain over frequency grid 
distReq = TuningGoal.Gain('Command',{'ThetaEstimate','DistanceEstimate'},Wrej); % keep transfer between InputDist and Position below Wrej

allReq = [trackingReq, marginReq];


%% Tune controllers
ST1 = systune(ST0,allReq);
showBlockValue(ST1)
writeBlockValue(ST1)


%% Validate design
% Clear figures
close all

% Get transfers
T = getIOTransfer(ST1,{'ThetaRef','DistanceRef'},{'ThetaEstimate','DistanceEstimate'});
R = getIOTransfer(ST1,'Command',{'ThetaEstimate','DistanceEstimate'});
L = getLoopTransfer(ST1,'Command',-1);
S = getSensitivity(ST1,'Command');
[cm,dm,mm] = loopmargin(L);

% Plot reference tracking
figure,viewSpec(trackingReq,ST1)
% figure, bodemag(T)
% title('Reference tracking')

% Display MIMO stability margins
mag2db(mm.GainMargin)
mm.PhaseMargin

% Plot disturbance rejection
figure,viewSpec(distReq,ST1)
% figure, bodemag(R,Wrej*ones(2),'r:')
% title('Disturbance rejection'), legend('actual','spec')

% Plot diagonal open-loops
figure, nichols(L(1,1),L(2,2))
title('Diagonal open-loops')
