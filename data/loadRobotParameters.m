%% loadRobotParameters.m
% This MATLAB script populates the workspace with parameters related to the
% simulation of the LEGO robot. It specifies plant model parameters to
% characterise the motors and motion of the LEGO robot.

%% Robot Geometry
AxleLength = 16; %Distance between centre-line of driving wheels is 160mm [cm]
WheelRadius = 6.65/2; %Driving wheel diameter is 66.5mm [cm]

%% Initial Conditions for Robot Position
theta0 = 0; %Initial Robot Angle relative to positive x-axis [deg]
x0 = 50;   %Initial Robot x-position [cm]
y0 = 50;   %Initial Robot y-position [cm]

%% Plant Model Motor Parameters:
motorBiasRight = -72;   %Bias for right motor to convert from demand to deg/s
motorBiasLeft  = -68;   %Bias for left motor to convert from demand to deg/s
motorGainRight = 8.1;   %Scaling for right motor to convert from demand to deg/s
motorGainLeft = 8.4;    %Scaling for left motor to convert from demand to deg/s
motorDeadZoneFwd = 20;  %Demand in forward direction below which motor doesn't turn
motorDeadZoneRev = -20; %Demand in reverse direction below which motor doesn't turn
EncR_init = 0;          %Right encoder initialisation value
EncL_init = 0;          %Left encoder initialisation value
EncRes = 636;
WheelCoefRight = 0.99;
WheelCoefLeft = 1;

%% Simulation Parameters
deltaT = 0.01; %Step size for plant model
dT = 0.1; %Step size for sensors and algorithm
Ts = 0.2;  % Step size for referee/scoring model

%% Default Target Positions
if ~exist('TargetPositions','var') || all(TargetPositions(:) == 0)
    %TargetPositions = single([1.5 0.5; 1.5 1.5; 0.5 1.5; 0.6 0.6; 0.7 1.7; 1.7 0.7; 1.7 1.7; 0.9 0.9; 1.0 0.2]); %[m]
    %     TargetPositions = single(...
    %     [100    112.50;    37.50    187.50;    112.50    262.50;...
    %     262.50    187.50;    187.50    37.50;    37.50    37.50]); % [cm]
    Positions;
end
