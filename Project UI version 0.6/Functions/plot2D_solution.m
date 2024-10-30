

function fig2D=plot2D_solution(sol_explicit,sol_implicit,sol_crank,dx,dt,tubeLength, simTime, r)
 % Initialize figures
 fig2D=figure('Name', '2D Solutions (Space/Concentration)', WindowState='maximized');
 % Lock the rotation
 rotate3d(fig2D,'off');
 sgt=sgtitle(sprintf("Plot for spatial step size = %.3f, temporal step size = %.3f, variable r=%.3f",dx,dt,r));
 %variable for modifies the title properties of the figure.
 % title_name=sprintf("Plot for spatial step size = %.3f, temporal step size %.3f, variable r=%.3f",dx,dt,r); 
 
 subplot(3,1,1);
 plot2D(sol_explicit, tubeLength, simTime, 'Explicit Euler',r);
 hold on;
 subplot(3,1,2);
 plot2D(sol_implicit, tubeLength, simTime, 'Implicit Euler');
 subplot(3,1,3);
 plot2D(sol_crank, tubeLength, simTime, 'Crank-Nicolson');
 % % % sgtitle(sprintf("Plot for spatial step size = %.3f, temporal step size = %.3f, variable r=%.3f",dx,dt,r));
 % sgtitle(title_name);
 hold off
 % clear title_name;
 clear sgt
 % % %  if plot_savefig
 % % %     file_name = sprintf("2D Solutions_spatial step size = %.3f, temporal step size %.3f, variable r=%.3f.png",dx,dt,r);
 % % %     saveas(fig2D,file_name,'png');
 % % % end
end

% Plot 2D solution
function plot2D(sol, tubeLength, simTime, method,r)


    Nx = size(sol, 2) - 1;
    Nt = size(sol, 1) - 1;

    x = linspace(0, tubeLength, Nx+1);
    t = linspace(0, simTime, Nt+1);

    [X, T] = meshgrid(x, t);
    mesh(X, T, sol,EdgeColor='flat',FaceColor="none",LineWidth=0.001,LineStyle=":");
    hidden off
    view(0, 0);
    switch nargin
        case 7
            if r >= 0.6 
            xlabel('Space (x) [cm]');
            ylabel('Time (t) [s]');
            zlabel('Concentration (Normalized Inf-Norm) ');
            title([method '3D Solution (Normalized)'])
            
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
