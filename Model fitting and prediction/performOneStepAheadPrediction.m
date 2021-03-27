% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright (c) 2021 University of Southern California
%   See full notice in LICENSE.md
%   Yuxiao Yang, Maryam Shanechi
%   Shanechi Lab, University of Southern California
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [y_predict] = performOneStepAheadPrediction(y,u,LSSM)
% This function uses the fitted LSSM to one-step-ahead predict the outputin test
% data
%   Detailed explanation goes here
% Input: 
% 1. y, time by dimension vector representing the output in test data 
% 2. u, time by dimension vector representing the input in test data
% 3. LSSM, fitted LSSM in training data
% order selection
% Output:
% 1. y_predict, time by dimension vector representing the forward-predicted
% output

%%%%%% organize input and output into system identification datastructure
TestData = iddata(y,u,1); % 1 represent discrete-time system

%%%%% one step ahead prediction, use past input and past output to predict current output 
opt = compareOptions;
opt.InitialCondition = 'zero'; % zero initialization 
prediction_step_ahead = 1; % 1 step ahead prediction
[PredictData,~,~] = compare(TestData, LSSM, prediction_step_ahead, opt);
% NOTE: here we do provide "prediction_step_ahead" of 1 to the 
% compare function to perform one-step ahead prediction.
y_predict = PredictData.y;

end
