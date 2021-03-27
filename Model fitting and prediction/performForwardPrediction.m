% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright (c) 2021 University of Southern California
%   See full notice in LICENSE.md
%   Yuxiao Yang, Maryam Shanechi
%   Shanechi Lab, University of Southern California
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [y_predict] = performForwardPrediction(u,LSSM)
% This function uses the fitted LSSM to forward predict the outputin test
% data
%   Detailed explanation goes here
% Input: 
% 1. u, time by dimension vector representing the input in test data
% 2. LSSM, fitted LSSM in training data
% order selection
% Output:
% 1. y_predict, time by dimension vector representing the forward-predicted
% output

% Disable warnings (compare throws unimportant warnings):
warningSettingBackup = warning;
warning('off');

%%%%%% organize input and output into system identification datastructure
TestData = iddata([],u,1); % 1 represent discrete-time system

%%%%% forward prediction, only use past input to predict current output 
opt = compareOptions;
opt.InitialCondition = 'zero'; % zero initialization 
[PredictData,~,~] = compare(TestData, LSSM, opt);
% NOTE: here we do not provide the "prediction_step_ahead" input to the 
% compare function to perform forward prediction.
y_predict = PredictData.y;

warning(warningSettingBackup); % Restore original warning settings
