function Plot_stability = test_stability(diffCoeff)
%% This function provides the values ​​of space and time (between 0 and 1) in which the stability limit is obtained r = 0.5
%  r = diffCoeff * dt / dx^2;  --> Stability parameter 
%  stable_dt = (dx^2 / (2 * diffCoeff)); --> time step for have r = 0.5
%  with a given spatial step

space = linspace(0,1);
time = linspace(0,1);
r_stable_time = zeros(1,length(time));
r_stable_time = zeros(1,length(space));

for i=1:length(time)
    r_stable_time(i) = (space(i)^2 / (2 * diffCoeff));
end

for i=1:length(space)
    r_stable_space(i) = sqrt((time(i)* (2 * diffCoeff))) ;
end
Plot_stability=figure("Name","Stability limit");
plot(space,r_stable_space,'b',time,r_stable_time,'r');
legend("Stability in space", "Stability in time");
end
