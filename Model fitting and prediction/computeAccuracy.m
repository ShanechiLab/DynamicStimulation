% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright (c) 2021 University of Southern California
%   See full notice in LICENSE.md
%   Yuxiao Yang, Maryam Shanechi
%   Shanechi Lab, University of Southern California
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [CC, EV] = computeAccuracy(y, y_predict)
% This function computes the prediction accuracy measures
% Input: 
% 1. y, true data (time by dimension vector)
% 2. y_predict, prediction of the data (time by dimension vector)
% Output:
% 1. CC: correlation coefficient between prediction and ground-truth, one
% value for each outoput dimension
% 2. EV: explained variacne between prediction and ground-truth, one
% value for each outoput dimension 

%%%%% compute CC between prediction and ground-truth 
CC = zeros(size(y,2),1);
EV = zeros(size(y,2),1);
for k = 1 : size(y,2)
    CC(k) = corr(y(:,k), y_predict(:,k)); 
    EV(k) = (1 - mean((y(:,k)-y_predict(:,k)).^2) / var(y(:,k)) )*100; 
end

end
