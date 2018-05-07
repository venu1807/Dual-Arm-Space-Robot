% ReDySim animate module. This module animates the system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
function [] = animate(tskip)
disp('------------------------------------------------------------------');
disp('Animating the simulation data');

load timevar.dat;
load statevar.dat;
T=timevar;
Y=statevar;
s=0;
j=1;
[n nq alp a b bt dx dy dz al alt]=inputs();
for i=2:length(T)
    if T(i)>s
        time(j)=T(i);
        q=Y(i,1:6);
        th=Y(i,6:6+n-1);
        nqn=6+n;
        dq=Y(i,nqn:nqn+6-1)';
        dth=Y(i,nqn+6-1:2*(n+6-1))';
        [tt vc  scf vcf sof stf sbf vtf ttf]=for_kine(q,th, dq, dth, n, alp, a, b, bt, dx, dy, dz, al, alt);

        BX(j,:)=[sof(1,1) stf(1,1) ];
        BY(j,:)=[sof(2,1) stf(2,1) ];
        BZ(j,:)=[sof(3,1) stf(3,1) ];
        L1X(j,:)=[sof(1,2) stf(1,2) sof(1,3) stf(1,3) sof(1,4) stf(1,4)];
        L1Y(j,:)=[sof(2,2) stf(2,2) sof(2,3) stf(2,3) sof(2,4) stf(2,4)];
        L1Z(j,:)=[sof(3,2) stf(3,2) sof(3,3) stf(3,3) sof(3,4) stf(3,4)];
        L2X(j,:)=[sof(1,5) stf(1,5) sof(1,6) stf(1,6) sof(1,7) stf(1,7)];
        L2Y(j,:)=[sof(2,5) stf(2,5) sof(2,6) stf(2,6) sof(2,7) stf(2,7)];
        L2Z(j,:)=[sof(3,5) stf(3,5) sof(3,6) stf(3,6) sof(3,7) stf(3,7)];
        
        
        j=j+1;
        s=s+tskip;
    else
        continue
    end
end
nst=2;
[qq]=initials();

xmin=qq(1)-1;
xmax=qq(1)+2.5;
ymin=0;
ymax=qq(2)+1*nst;
zmin=qq(3)-nst/0.25;
zmax=qq(3)+nst/0.25;
% xmin=q(1)-nst/3;
% xmax=q(1)+nst/3;
% ymin=0;
% ymax=q(2)+.5*nst;
% zmin=q(3)-1;
% zmax=q(3)+.5*nst;
% GX=[xmin xmin xmax xmin xmin];
% GY=[0 0 0 0 ymax];
% GZ=[zmin zmax zmax zmax zmax];

for i=1:length(time)
    figure(7);
    %     hold on;
    t=time(i);
    t=num2str(t);
    %     plot3(GZ,-GX,GY,'k',L1Z(i,:),-L1X(i,:),L1Y(i,:),'r',L2Z(i,:),-L2X(i,:),L2Y(i,:),'b',L3Z(i,:),-L3X(i,:),L3Y(i,:),'b',L4Z(i,:),-L4X(i,:),L4Y(i,:),'r','linewidth',4);
    plot3(L1Z(i,:),-L1X(i,:),L1Y(i,:),'r',L2Z(i,:),-L2X(i,:),L2Y(i,:),'b','linewidth',3);

    %     plot3(GZ,-GX,GY,'k',BZ(i,:),-BX(i,:),BY(i,:),'k',L1Z(i,:),-L1X(i,:),L1Y(i,:),'r',L2Z(i,:),-L2X(i,:),L2Y(i,:),'b',L3Z(i,:),-L3X(i,:),L3Y(i,:),'b',L4Z(i,:),-L4X(i,:),L4Y(i,:),'r','linewidth',4);
    %     h1=plot3(BZ(i,:),-BX(i,:),BY(i,:),L1Z(i,:),-L1X(i,:),L1Y(i,:),L2Z(i,:),-L2X(i,:),L2Y(i,:),'k');
    hold on;
    fill3(BZ(i,:),-BX(i,:),BY(i,:),[1 1 ],'linewidth',2.5)
    axis([zmin zmax -xmax -xmin ymin ymax]);
    set(gca,'fontsize',12,'fontweight','bold','fontname','timesnewroman','linewidth',1.5)
    xlabel('z (m)','fontweight','bold','fontsize',14);
    ylabel('x (m)','fontweight','bold','fontsize',14);
    zlabel('y (m)','fontweight','bold','fontsize',14);
    title(t,'fontweight','bold','fontsize',12)
%     view(90,0)
    hold off
    grid on;
    drawnow;
%     pause(0.05)
end

