% ReDySim animate module. This module animates the system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
function [] = animate()
tskip=0.05;
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
        [tt vc  scf vcf sof stf sbf]=for_kine(q,th, dq, dth, n, alp, a, b, bt, dx, dy, dz, al, alt);
        BX(j,:)=[sbf(1,1:8) sbf(1,1)];
        BY(j,:)=[sbf(2,1:8) sbf(2,1)];
        BZ(j,:)=[sbf(3,1:8) sbf(2,1)];
        L1X(j,:)=[sof(1,2:4) stf(1,4)];
        L1Y(j,:)=[sof(2,2:4) stf(2,4)];
        L1Z(j,:)=[sof(3,2:4) stf(3,4)];
        L2X(j,:)=[sof(1,5:7) stf(1,7)];
        L2Y(j,:)=[sof(2,5:7) stf(2,7)];
        L2Z(j,:)=[sof(3,5:7) stf(3,7)];
        j=j+1;
        s=s+tskip;
    else
        continue
    end
end
nst=sum(al)- al(1);
[qq]=initials();

xmin=qq(1)-1*nst;
xmax=qq(1)+1*nst;
ymin=qq(2)-1*nst;
ymax=qq(2)+1*nst;
zmin=qq(3)-1*nst;
zmax=qq(3)+1*nst;

figure('Name','Animation Window','NumberTitle','off');
for i=1:length(time)
    t=time(i);
    t=num2str(t);
    plot3(L1X(i,:),L1Y(i,:),L1Z(i,:),'.-',L2X(i,:),L2Y(i,:),L2Z(i,:),'.-','Color',[0.15 0.32 0.26],'MarkerSize',30,'linewidth',4);
    hold on;
%     fill3(BX(i,1:4),BY(i,1:4),BZ(i,1:4),[4 4 4 4],BX(i,5:8),BY(i,5:8),BZ(i,5:8),[4 4 4 4],BX(i,[2,3,6,7]),BY(i,[2,3,6,7]),BZ(i,[2,3,6,7]),[4 4 4 4],BX(i,[1,4,5,8]),BY(i,[1,4,5,8]),BZ(i,[1,4,5,8]),[4 4 4 4],BX(i,[1,2,7,8]),BY(i,[1,2,7,8]),BZ(i,[1,2,7,8]),[4 4 4 4],BX(i,[3,4,5,6]),BY(i,[3,4,5,6]),BZ(i,[3,4,5,6]),[4 4 4 4]);
  
    fill3(BX(i,1:4),BY(i,1:4),BZ(i,1:4),[0.5 1 1 0.5],BX(i,5:8),BY(i,5:8),BZ(i,5:8),[0.5 1 1 0.5],BX(i,[2,3,6,7]),BY(i,[2,3,6,7]),BZ(i,[2,3,6,7]),[1 0.5 0.5 0.1667],BX(i,[1,4,5,8]),BY(i,[1,4,5,8]),BZ(i,[1,4,5,8]),[1 0.5 0.5 0.1667],BX(i,[1,2,7,8]),BY(i,[1,2,7,8]),BZ(i,[1,2,7,8]),[0.333 0.333 0.5 0.5],BX(i,[3,4,5,6]),BY(i,[3,4,5,6]),BZ(i,[3,4,5,6]),[0.333 0.333 0.5 0.5]);

    axis([xmin xmax ymin ymax zmin zmax ]);
    set (gca,'fontsize',10,'fontweight','normal','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
    xlabel('X (m)','fontweight','n','fontsize',10);
    ylabel('Y (m)','fontweight','n','fontsize',10);
    zlabel('Z (m)','fontweight','n','fontsize',10);
    title(['Current time t=',t],'fontweight','normal','fontsize',10);
    if nq==0
    view(3)
    end
    hold off
    grid on;
    drawnow;
end

