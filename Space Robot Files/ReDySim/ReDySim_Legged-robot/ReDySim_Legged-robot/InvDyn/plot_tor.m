% ReDySim plot_tor module. This module plots the generalized forces
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function[]=plot_tor()
disp('------------------------------------------------------------------');
disp('Generating plots for joint torques');
%Plots
[n]=inputs();

load tor.dat;
load timevar.dat;
S=timevar;
tau=tor;
clear tor;
clear timevar;

set(0,'DefaultLineLineWidth',1.5)
% set(0,'DefaultLineLineWidth',1.5,'DefaultAxesColorOrder',[0 0 0],...
%    'DefaultAxesLineStyleOrder','-|--|:|-.', 'DefaultLineMarkerSize',1.5)
% whitebg('w') %create a figure with a white color scheme


if n-1 <= 6
    fh1=figure(5);
    set(fh1, 'color', 'white'); % sets the color to white
    plot(S,tau)
    set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    hl=legend('\tau_1','\tau_2','\tau_3','\tau_4','\tau_5','\tau_6','\tau_7');
    set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','south','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
    xlabel('time(s)','FontSize',10);
    ylabel('Joint torque (Nm)','FontSize',10);
else
    fh1=figure(5);
    subplot(1,2,1)
    set(fh1, 'color', 'white'); % sets the color to white
    plot(S,tau(:,1:6))
    set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    hl=legend('\tau_1','\tau_2','\tau_3','\tau_4','\tau_5','\tau_6');
    set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','south','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
    xlabel('time(s)','FontSize',10);
    ylabel('Joint torque (Nm)','FontSize',10);
    
    subplot(1,2,2)
    set(fh1, 'color', 'white'); % sets the color to white
    plot(S,tau(:,7:n-1))
    set (gca,'fontsize',10,'fontweight','n','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    hl=legend('\tau_7','\tau_8','\tau_9','\tau_1_0','\tau_1_1','\tau_1_2','\tau_1_3');
    set(hl,'Orientation','h','Color', 'none','Box', 'off','Location','south','FontAngle','italic','fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5)
    xlabel('time(s)','FontSize',10);
    ylabel('Joint torque (Nm)','FontSize',10);    
end
