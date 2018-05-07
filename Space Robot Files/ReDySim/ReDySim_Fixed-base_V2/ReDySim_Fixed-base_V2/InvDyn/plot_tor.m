% ReDySim plot_tor module. This module plots the generalized forces
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function []=plot_tor()
disp('------------------------------------------------------------------');
disp('Generating plots for joint forces/torques');
%Loding the generalized forces
load tor.dat;
tu=tor;
clear tor;
load timevar.dat;
T=timevar;
clear timevar.dat;
[n dof]=inputs() ;
set(0,'DefaultLineLineWidth',1.5,'DefaultLineMarkerSize',3)
fh2=figure('Name','Joint Torques/Forces','NumberTitle','off');
set(fh2, 'color', 'white'); % sets the color to white
plot(T,tu(:,1:dof))
set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% title(' tau1 ');
xlabel('time (s)','fontsize',10);
ylabel(' Torque (Nm)/Force (N)','fontsize',10);
% hl=legend ('\tau_1');
% set(hl,'Orientation','v','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)

if  dof<n
    scrsz = get(0,'ScreenSize');
    % fh1=figure(2);
    fh3=figure('Name','Lagrange multipliers at cut joints','NumberTitle','off');
    set(fh3, 'color', 'white'); % sets the color to white
    plot(T,tu(:,dof+1:n))
    set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('time (s)','fontsize',10);
    ylabel(' Lagrange multipliers (Nm or N)','fontsize',10);
%     hl=legend ('\lambda_1_x','\lambda_1_y');
%     set(hl,'Orientation','v','Color', 'none','Box', 'off','Location','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
else
    disp('  ');
end