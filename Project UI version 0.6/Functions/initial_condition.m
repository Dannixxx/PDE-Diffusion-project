

% Initial condition function for the entire tube
function u0 = initial_condition(x)
    u0 = 2.0 * ones(size(x));  % Initial concentration is 2.0 throughout the tube
end