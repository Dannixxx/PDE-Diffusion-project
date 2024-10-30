

% Boundary condition function
function u_bc = boundary_condition(x,tubeLength,t)
    if x == 0
        u_bc = 10*ones(1,length(t));  % At x=0, concentration is 10 (Evaporation)
    elseif x == tubeLength
        u_bc = zeros(1,length(t));  % At x=L, concentration is 0 (Disperses into air)
    % % else
    % %     u_bc = NaN;  % For intermediate points
    end
end