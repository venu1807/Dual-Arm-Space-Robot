% ReDySim plot_motion module. This module plot joint positions and velocities
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [] = plot_motion()
disp('------------------------------------------------------------------');
disp('Generating plots for joint motions');

[n ]=inputs();
load statevar.dat;
traj=statevar;
clear statevar.dat;
load timevar.dat;
T=timevar;
clear timevar.dat;


th=traj(:,1:(n));
dth=traj(:,(n+1):(2*n));
ddth=traj(:,(2*n+1):(3*n));
set(0,'DefaultLineLineWidth',1.5, 'DefaultLineMarkerSize',1.5)
%PloTng angular posiTons
fh1=figure('Name','Input Joint motions','NumberTitle','off');
set(fh1, 'color', 'white'); % sets the color to white
subplot(1,3,1)
plot(T,th);
set (gca,'fontsize',10,'fontweight','n','fontname','Tmes new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% hl=legend('\theta_1');
% set(hl,'OrientaTon','h','Color', 'none','Box', 'off','LocaTon','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','Tmes new romans','linewidth',0.5)
xlabel('Tme (s)','fontsize',10);
ylabel('Joint Positions (rad or m)','fontsize',10);
subplot(1,3,2)
plot(T,dth);
set (gca,'fontsize',10,'fontweight','n','fontname','Tmes new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% hl=legend('\theta_2','\theta_3');
% set(hl,'OrientaTon','h','Color', 'none','Box', 'off','LocaTon','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','Tmes new romans','linewidth',0.5)
xlabel('Tme (s)','fontsize',10);
ylabel('Joint Rates (rad/s or m/s)','fontsize',10);
subplot(1,3,3)
plot(T,ddth);
set (gca,'fontsize',10,'fontweight','n','fontname','Tmes new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% hl=legend('\theta_2','\theta_3');
% set(hl,'OrientaTon','h','Color', 'none','Box', 'off','LocaTon','best','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','Tmes new romans','linewidth',0.5)
xlabel('Tme (s)','fontsize',10);
ylabel('Joint Accelerations (rad/s^2 or m/s^2)','fontsize',10);
