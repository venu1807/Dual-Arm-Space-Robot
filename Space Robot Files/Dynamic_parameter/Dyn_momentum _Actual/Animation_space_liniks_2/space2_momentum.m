t=linspace(0,30,100);
[T,Y]=ode45(@space_links_2,t,[0,0,0,0,0,0]);

H=table(Y(:,1),Y(:,2),Y(:,3),Y(:,4),Y(:,5),Y(:,6),'VariableNames',{'x0' 'dx0' 'y0' 'dy0' 'th0' 'dth0'})

[M]=Space_link_Traj();
[f,g]=size(M(:,1));
q1=[M(:,1),M(:,2)];
dq1=[M(:,3),M(:,4)];
ddq1=[M(:,5),M(:,6)];
disp('-----Joint angle 1&2 and their rates for simulation time period-----');
% K=table(M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),M(:,6),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'})

ang2= M(:,1:2)*180/pi;
ang1= Y(:,5:6)*180/pi;

n=3;
nq=0;%1 for spatial and 0 for planar
% ENTER DH PARAMETER HERE   
% dh=[alt b alp th];
alp=[0; 0; 0];
a=[0; 0.5; 1];
b=[0; 0; 0];
% Parent array bt and corrosponding vectors
bt=[0 1 2 ];

% Link Length
al=[1; 1; 1];
%Distance from origin to link tip in term of link length
alt=[0.5; 1; 1];

% ENTER VECTOR dm
dx=[  0    al(2)/2  al(3)/2  ];
dy=[  0       0       0      ];
dz=[  0       0       0      ];



%MASS
m=[500; 10; 10];
% g=[0 ; -9.81; 0];
 g=[0 ; 0; 0];

%MOMENT OF INERTIA
Icxx=zeros(n,1);Icyy=zeros(n,1);Iczz=zeros(n,1); % Initialization 
Icxy=zeros(n,1);Icyz=zeros(n,1);Iczx=zeros(n,1); % Initialization 
% Icxx(1)=(1/12)*0.01*0.01;   Icyy(1)=(1/12)*m(1)*(al(1)*al(1)+0.1*0.1);  Iczz(1)=(1/12)*m(1)*al(1)*al(1);
% Icxx(2)=(1/12)*0.01*0.01;   Icyy(2)=(1/12)*m(2)*al(2)*al(2);  Iczz(2)=(1/12)*m(2)*al(2)*al(2);
% Icxx(3)=(1/12)*0.01*0.01;   Icyy(3)=(1/12)*m(3)*al(3)*al(3);  Iczz(3)=(1/12)*m(3)*al(3)*al(3);
% Icxx(4)=(1/12)*0.01*0.01;   Icyy(4)=(1/12)*m(4)*al(4)*al(4);  Iczz(4)=(1/12)*m(4)*al(4)*al(4);

Icxx(1)=83.61;  Icyy(1)=83.61; Iczz(1)=83.61;
Icxx(2)=0.01;   Icyy(2)=1.05;  Iczz(2)=1.05;
Icxx(3)=0.01;   Icyy(3)=1.05;  Iczz(3)=1.05;
Icxx(4)=0.01;   Icyy(4)=1.05;  Iczz(4)=1.05;

index1=0;
Z=zeros(f,3);
Z1=zeros(f,1);
Z2=zeros(f,1);
Z3=zeros(f,1);
L1=[0;0;0];
P1=[0;0;0];
for id = 1:f
    index1=index1+1;
    M1=m(1)+m(2)+m(3);
    I=[1 0 0;0 1 0;0 0 1];
    vb=[Y(id,2),Y(id,4),0]';
    rbg=[(m(2)/M1)*(a(2))*cos(Y(id,5)) + (m(2)/M1)*(dx(2))*cos(Y(id,5)+M(id,1)) + (m(3)/M1)*(a(2))*cos(Y(id,5)) + (m(3)/M1)*a(3)*cos(Y(id,5)+M(id,1)) + (m(3)/M1)*(dx(3))*cos(Y(id,5)+M(id,1)+M(id,2))
         (m(2)/M1)*(a(2))*sin(Y(id,5)) + (m(2)/M1)*(dx(2))*sin(Y(id,5)+M(id,1)) + (m(3)/M1)*(a(2))*sin(Y(id,5)) + (m(3)/M1)*a(3)*sin(Y(id,5)+M(id,1)) + (m(3)/M1)*(dx(3))*sin(Y(id,5)+M(id,1)+M(id,2))
         0];
%     rbg=[(m(2)/M1)*(a(2))*cos(Y(id,5)*180/pi) + (m(2)/M1)*(dx(2))*cos((Y(id,5)+M(id,1))*180/pi) + (m(3)/M1)*(a(2))*cos(Y(id,5)*180/pi) + (m(3)/M1)*a(3)*cos((Y(id,5)+M(id,1))*180/pi) + (m(3)/M1)*(dx(3))*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)
%      (m(2)/M1)*(a(2))*sin(Y(id,5)*180/pi) + (m(2)/M1)*(dx(2))*sin((Y(id,5)+M(id,1))*180/pi) + (m(3)/M1)*(a(2))*sin(Y(id,5)*180/pi) + (m(3)/M1)*a(3)*sin((Y(id,5)+M(id,1))*180/pi) + (m(3)/M1)*(dx(3))*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)
%      0];

    wb=[0; 0 ;Y(id,6)];
    dph=[M(id,3); M(id,4)];

    Jtg=[-(m(2)*dx(2))*sin(Y(id,5)+M(id,1))-m(3)*a(3)*sin(Y(id,5)+M(id,1))-(m(3)*dx(3))*sin(Y(id,5)+M(id,1)+M(id,2)) -(m(3)*dx(3))*sin(Y(id,5)+M(id,1)+M(id,2));
          (m(2)*dx(2))*cos(Y(id,5)+M(id,1))+m(3)*a(3)*cos(Y(id,5)+M(id,1))+(m(3)*dx(3))*cos(Y(id,5)+M(id,1)+M(id,2))  (m(3)*dx(3))*cos(Y(id,5)+M(id,1)+M(id,2));
          0 0];
    %     Jtg=[-(m(2)*dx(2))*sin((Y(id,5)+M(id,1))*180/pi)-m(3)*a(3)*sin((Y(id,5)+M(id,1))*180/pi)-(m(3)*dx(3))*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)  -(m(3)*dx(3))*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi);
    %       (m(2)*dx(2))*cos((Y(id,5)+M(id,1))*180/pi)+m(3)*a(3)*cos((Y(id,5)+M(id,1))*180/pi)+(m(3)*dx(3))*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)   (m(3)*dx(3))*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi);
    %       0 0];

    P=(M1*vb) + (M1*cross(wb,rbg)) + (Jtg*dph)
    Z(index1,:)=P;
    PP=[P1,P];
    P1=PP

end

Z
Z1;
Z2;
Z3;
% P1(1,:)
% P1(2,:)'
% P1(3,:)'
figure
hold on
plot(t,Z(:,1))
% axis([0,30,-15,15])
% figure
 hold on
% % plot(t,Z1)
plot(t,Z(:,2))
% axis([0,30,-15,15])
% hold on
% 
% % figure
% % plot(t,Z2)
%  plot(t,Z(:,2))
% % figure
% plot(t,Z3)













