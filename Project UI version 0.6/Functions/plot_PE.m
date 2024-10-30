function [Plot_PDEfig,k] =plot_PE (pde_sol,dx, dt, tubeLength, simTime,k,SpatialSteps,TimeSteps,plotPDEPE,Plot_PDEfig)
   
            if plotPDEPE 
                Nx = size(pde_sol, 2) - 1;
                Nt = size(pde_sol, 1) - 1;
            
                x = linspace(0, tubeLength, Nx+1);
                t = linspace(0, simTime, Nt+1);
                title_name=sprintf("spatial step size = %.3f, temporal step size %.3f",dx,dt);
                [X, T] = meshgrid(x, t);
                axes = subplot(SpatialSteps,TimeSteps,k,'Parent',Plot_PDEfig);
                
                mesh(axes,X, T, pde_sol,FaceColor="interp",FaceAlpha='0.5');
                 xlabel(axes,'Space (x) [cm]');
                 ylabel(axes,'Time (t) [s]');
                 zlabel(axes,'Concentration [%]');
                 title(axes,title_name);
                 
                 hold off
            end
 % % %    if chk_savefig
 % % %        file_name = sprintf("Fig\ 3D Solutions_spatial step size = %.3f, temporal step size %.3f, variable r=%.3f.png",dx,dt,r);
 % % %     saveas(Plot_PDEfig,file_name,'png');
 % % % end
end