%% Initialization script for Simulink model simpleModelMC.mdl
% * Author : Mathieu Cuenant (mathieu.cuenant@mathworks.fr)
% * Date : 13-Mar-2014 18:41:32

%% Clean up
clear;clc;

%% User parameters
mdl_name = 'SimulationModel_Mathieu'; % Name of Simulink model
Fs = 20; % Sampling frequency (Hz)

%% Model parameters
Ts = 1/Fs; % Sampling period (s)

%% Robot parameters
tauMotor = 0.1; %3e-3; % motor time constant [s]
alphaMotor = 5; % relative motor gain dispersion [%] (between left and right motor)
encoderPrecision = 360/(12*53)*pi/180; % encoder quantification [rad] (360/(12*53)*pi/180 or 360/(6*53)*pi/180)
wheelRadius = 6.65e-2; % wheel radius [m]
wheelDistance = 16.5e-2; % distance between wheels [m]
wheelGain = 0.23; % conversion from absolute command [-100 100] to speed demand in rad/s
deadZoneLow = -25; % beginning of dead zone (within [-100 100])
deadZoneUp = 20; % end of dead zone (within [-100 100])


%% Controller parameters
% Estimator
cutoffDerivative = 1; % cutoff frequency for filtered derivative
xiLowPass = 1; % damping (for 2nd order low pass filter)
filteredDerivativeContinuous = tf([1 0],[1/(2*pi*cutoffDerivative)^2 2*xiLowPass/(2*pi*cutoffDerivative) 1]); % tf([1 0],[1/(2*pi*cutoffDerivative) 1])
filteredDerivativeDiscrete = c2d(filteredDerivativeContinuous,Ts,'foh');
[Nfd,Dfd] = tfdata(filteredDerivativeDiscrete,'v');

% Feedback controller
controllerType = 0; % 0 for basic controller, 1 for decoupling controller
variantBasic = Simulink.Variant('controllerType == 0');
variantDecoupling = Simulink.Variant('controllerType == 1');




