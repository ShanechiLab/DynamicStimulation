% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Copyright (c) 2021 University of Southern California
%   See full notice in LICENSE.md
%   Yuxiao Yang, Maryam Shanechi
%   Shanechi Lab, University of Southern California
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [LSSM] = fitIOModel(y,u,searchorder)
% This function fits the LSSM using training data
%   Detailed explanation goes here
% Input: 
% 1. y, time by dimension vector representing the output 
% 2. u, time by dimension vector representing the input 
% 3. searchorder, vector representing the model order to be searched during model
% order selection
% Output:
% 1. LSSM, the fitted LSSM, a data structure. See MATLAB system
% identification toolbox for the definition of this data structure

%%%%%% organize input and output into system identification datastructure
TrainingData = iddata(y,u,1); % 1 represent discrete-time system

%%%%% set model fitting setting using the system identification toolbox, please see MATLAB system identification toolbox for details 
N4SID_opt = n4sidOptions('N4Weight', 'MOESP', 'Focus', 'simulation', 'EnforceStability', true); % setting for initial subspace idetification
PEM_opt = ssestOptions('Focus', 'simulation', 'InitialState', 'zero', 'EnforceStability', true); % setting for the PEM refinement

%%%%% do order selection in the training set, either with AIC or with inner-level cross-validation; here AIC is provided as an example.
AIC_values = zeros(length(searchorder),1); 
for k = 1 : length(searchorder)
    %%% sweep model order
    modelorder_here =  searchorder(k);
    %%% use subspace identification to fit initial LSSM
    Initial_LSSM = n4sid(TrainingData, modelorder_here, 'Feedthrough', false, 'DisturbanceModel', 'estimate', N4SID_opt);
    %%% use PEM to refine the fit
    Refined_LSSM = pem(TrainingData, Initial_LSSM, PEM_opt);
    %%% get AIC of the fitted model
    AIC_values(k) = aic(Refined_LSSM, 'AICc');
end
[~, ind] = min(AIC_values); 
Selected_modelorder = searchorder(ind); 
 
%%%% fit final model with selected model order
%%% use subspace identification to fit initial LSSM
Initial_LSSM_selected = n4sid(TrainingData,Selected_modelorder, 'Feedthrough', false, 'DisturbanceModel', 'estimate', N4SID_opt);
%%% use PEM to refine the fit
LSSM = pem(TrainingData, Initial_LSSM_selected, PEM_opt);

end
