function Fig3d=plot3D_solution(sol_explicit,sol_implicit,sol_crank,dx,dt,tubeLength, simTime, r)
 % Initialize figures
 Fig3d=figure('Name', '3D Solutions', WindowState='maximized');
 %variable for modifies the title properties of the figure.
 title_name=sprintf("Plot for spatial step size = %.3f, temporal step size %.3f, variable r=%.3f",dx,dt,r); 
 
 subplot(1,3,1);
 plot3D(sol_explicit, tubeLength, simTime, 'Explicit Euler',r);
 hold on;
 subplot(1,3,2);
 plot3D(sol_implicit, tubeLength, simTime, 'Implicit Euler');
 subplot(1,3,3);
 plot3D(sol_crank, tubeLength, simTime, 'Crank-Nicolson');
 sgtitle(title_name);
 hold off
 clear title_name;
 % % % if plot_savefig
 % % %     file_name = sprintf("Fig\ 3D Solutions_spatial step size = %.3f, temporal step size %.3f, variable r=%.3f.png",dx,dt,r);
 % % %     saveas(Fig3d,file_name,'png');
 % % % end
end

% Plot 3D solution
function plot3D(sol, tubeLength, simTime, method,r)


    Nx = size(sol, 2) - 1;
    Nt = size(sol, 1) - 1;

    x = linspace(0, tubeLength, Nx+1);
    t = linspace(0, simTime, Nt+1);

    [X, T] = meshgrid(x, t);
    mesh(X, T, sol,FaceColor="interp",FaceAlpha='0.5');
    switch nargin
        case 5
            if r >= 0.6 
            xlabel('Space (x) [cm]');
            ylabel('Time (t) [s]');
            zlabel('Concentration (Normalized)');
            title([method '3D Solution (Normalized Inf-Norm )'])
            
            else 
                xlabel('Space (x) [cm]');
                ylabel('Time (t) [s]');
                zlabel('Concentration [%]');
                title([method '3D Solution']);
                
            end
        otherwise
        xlabel('Space (x) [cm]');
        ylabel('Time (t) [s]');
        zlabel('Concentration [%]');
        title([method '3D Solution']);
        
    end
end