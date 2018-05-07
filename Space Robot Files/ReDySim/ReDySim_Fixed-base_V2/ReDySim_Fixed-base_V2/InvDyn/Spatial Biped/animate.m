% ReDySim animate module. This module animates the system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
function [] = animate()
tic
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al ]=inputs();
len_sum=sum(al);
xmin=-len_sum*(1/3);
xmax=len_sum*(2/3);
ymin=-len_sum/2;
ymax=len_sum/3;
zmin=-len_sum/3;
zmax=len_sum/1;
figure('Name','Animation Window','NumberTitle','off');
for i=1:length(T)
    q=Y(i,1:n);
    dq=Y(i,n+1:2*n)';
    [so sc vc tt st ]=for_kine(q, dq,n, alp, a, b, th, bt, r, dx, dy, dz);
    L1X=[so(1,1:4)];
    L1Y=[so(2,1:4)];
    L1Z=[so(3,1:4)];
    BX=[so(1,4:9)];
    BY=[so(2,4:9)];
    BZ=[so(3,4:9)];
    L2X=[so(1,9:n), st(1,n)];
    L2Y=[so(2,9:n), st(2,n)];
    L2Z=[so(3,9:n), st(3,n)];

    t=T(i);
    t=num2str(t);
    
    plot3(BZ,BY,BX,L1Z,L1Y,L1X,L2Z,L2Y,L2X,'linewidth',3);
    axis([ xmin xmax  ymin ymax zmin zmax]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','normal','fontsize',10);
    ylabel('Y (m)','fontweight','normal','fontsize',10);
    zlabel('Z (m)','fontweight','normal','fontsize',10);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    %view(0,0);
    grid on; 
    drawnow;
end

toc