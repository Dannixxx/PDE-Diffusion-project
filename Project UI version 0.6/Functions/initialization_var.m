function [cond_numEE,cond_numIE,cond_numCN,LTE_EE,GTE_EE,RTE_EE,LTE_IE,GTE_IE,RTE_IE,LTE_CN,GTE_CN,RTE_CN,result_text,lengthSpace,lengthTime,r] = initialization_var(activeSpatialSteps,activeTimeSteps)

    cond_numEE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    cond_numIE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    cond_numCN = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));

    LTE_EE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    GTE_EE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    RTE_EE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    LTE_IE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    GTE_IE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    RTE_IE = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    LTE_CN = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    GTE_CN = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
    RTE_CN = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));

    result_text=[];
    lengthSpace = length(activeSpatialSteps);
    lengthTime = length(activeTimeSteps);

    r = zeros (size(activeSpatialSteps,2),size(activeTimeSteps,2));
end