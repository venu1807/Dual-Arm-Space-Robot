clear all;
clc;

t=linspace(0,30,1000);
[T,Y]=ode45(@space_links_2,t,[0,0,0,0,0,0]);

H=table(Y(:,1),Y(:,2),Y(:,3),Y(:,4),Y(:,5),Y(:,6),'VariableNames',{'x0' 'dx0' 'y0' 'dy0' 'th0' 'dth0'})

[M]=Space_link_Traj();
[f,g]=size(M(:,1));
q1=[M(:,1),M(:,2)]; 
dq1=[M(:,3),M(:,4)];
ddq1=[M(:,5),M(:,6)];
disp('-----Joint angle 1&2 and their rates for simulation time period-----');
K=table(M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),M(:,6),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'})


% Parameters and initial conditions
%   mass, link length, initial angles, simulation time
% m = 1;
L = 3;
L1 =1;
L2 =1;


% x1 = [L1*cos(M(:,1)+Y(:,5)),   L1*cos(M(:,1)+Y(:,5))+L2*cos(M(:,1)+M(:,2)+Y(:,5))];
% y1 = [L1*sin(M(:,1)+Y(:,5)),   L1*sin(M(:,1)+Y(:,5))+L2*sin(M(:,1)+M(:,2)+Y(:,5))];

% x1 = [L1*cos(M(:,1)+(Y(:,5))),   L1*cos(M(:,1)+Y(:,5))+L2*cos(M(:,1)+M(:,2)+Y(:,5))];
% y1 = [L1*sin(M(:,1)+(Y(:,5))),   L1*sin(M(:,1)+Y(:,5))+L2*sin(M(:,1)+M(:,2)+Y(:,5))];



ang2= M(:,1:2)*180/pi;
ang1= Y(:,5:6)*180/pi;

% x1 = [L1*cos(ang(:,1)+ang1(:,1)),   L1*cos(ang(:,1)+ang1(:,1))+L2*cos(ang(:,1)+ang(:,2)+ang1(:,1))];
% y1 = [L1*sin(ang(:,1)+ang1(:,1)),   L1*sin(ang(:,1)+ang1(:,1))+L2*sin(ang(:,1)+ang(:,2)+ang1(:,1))];

% Convert radians to degrees

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
for id = 1:length(T)
    index1=index1+1;
%     Px=(m(1)*Y(id,2))+ (m(2)*Y(id,2))- (m(2)*( a(2)*sin(Y(id,5))+ dx(2)*sin(Y(id,5)+M(id,1)) )*Y(id,6)) - (m(2)*dx(2)*sin(Y(id,5)+M(id,1))*M(id,3)) + (m(3)*Y(id,2)) - (m(3)*(a(2)*sin(Y(id,5))+dx(2)*sin(Y(id,5)+M(id,1)))*Y(id,6)) - (m(3)*( a(2)*sin(Y(id,5))+ a(3)*sin(Y(id,5)+M(id,1)) +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2)) )*(Y(id,6)+M(id,3))) - (m(3)*(dx(2)*sin(Y(id,5)+M(id,1)))*M(id,3)) - (m(3)* (a(3)*sin(Y(id,5)+M(id,1))+dx(3)*(sin(Y(id,5)+M(id,1)+M(id,2)))*M(id,3)) - (m(3)*(dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))))*M(id,4));
%     Z1(index1)=Px;
%     
%     Py=(m(1)*Y(id,4))+ (m(2)*Y(id,4))+ (m(2)*( a(2)*cos(Y(id,5))+ dx(2)*cos(Y(id,5)+M(id,1)) )*Y(id,6)) + (m(2)*dx(2)*cos(Y(id,5)+M(id,1))*M(id,3)) + (m(3)*Y(id,4)) + (m(3)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1)))*Y(id,6)) + (m(3)*( a(2)*cos(Y(id,5))+ a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) )*(Y(id,6)+M(id,3))) + (m(3)*(dx(2)*cos(Y(id,5)+M(id,1)))*M(id,3)) + (m(3)* (a(3)*cos(Y(id,5)+M(id,1))+dx(3)*(cos(Y(id,5)+M(id,1)+M(id,2)))*M(id,3)) + (m(3)*(dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*M(id,4));
%     Z2(index1)=Py;
%     
%     Lz=  Iczz(2)*Y(id,6) +  m(2)*( a(2)^2 +dx(2)^2 + 2*a(2)*dx(2)*cos(M(id,1)) )*Y(id,6) + Iczz(3)* (Y(id,6)+M(id,3)) + m(3)*( a(2)^2  +a(3)^2  +dx(3)^2 + 2*a(2)*a(3)*cos(M(id,1)) +2*a(3)*dx(3)*cos(M(id,2))+  2*a(2)*dx(3)*cos(M(id,1)+M(id,2)) ) *(Y(id,6)+M(id,3))  + Iczz(2)*M(id,3) + m(2)*( dx(2)^2 + a(2)*dx(2)*cos(M(id,1)) ) *M(id,3) + Iczz(3)*M(id,4) + m(3)*( dx(3)^2 + dx(3)*a(2)*cos(M(id,1)+M(id,2)) + dx(3)*a(3)*cos(M(id,2)) ) *M(id,4) + m(2)* Y(id,4)* ( a(2)*cos(Y(id,5)) +dx(2)*cos(Y(id,5)+M(id,1)) ) + m(2) *Y(id,2)* ( a(2)*sin(Y(id,5))+ dx(2)*sin(Y(id,5)+M(id,1)) ) +( m(3)*( Y(id,4)+ ( a(2)*cos(Y(id,5)) +dx(2)*cos(Y(id,5)+M(id,1)) )*Y(id,6) +( dx(2)*cos(Y(id,5)+M(id,1))*M(id,3)) ) *( a(2)*cos(Y(id,5)) +a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) ) )+( m(3)*( Y(id,2)- ( a(2)*sin(Y(id,5)) +dx(2)*sin(Y(id,5)+M(id,1)) )*Y(id,6) - (dx(2)*sin(Y(id,5)+Y(id,6))*M(id,3)) )*( a(2)*sin(Y(id,5)) + a(3)*sin(Y(id,5)+M(id,1)) +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2)) ));
%     Z3(index1)=Lz;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Px=(m(1)*Y(id,2))+ (m(2)*Y(id,2))- (m(2)*( a(2)*sin(Y(id,5)*180/pi)+ dx(2)*sin((Y(id,5)+M(id,1))*180/pi) )*Y(id,6)) - (m(2)*dx(2)*sin((Y(id,5)+M(id,1))*180/pi)*M(id,3)) + (m(3)*Y(id,2)) - (m(3)*(a(2)*sin(Y(id,5)*180/pi)+dx(2)*sin((Y(id,5)+M(id,1))*180/pi))*Y(id,6)) - (m(3)*( a(2)*sin(Y(id,5)*180/pi)+ a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi) )*(Y(id,6)+M(id,3))) - (m(3)*(dx(2)*sin((Y(id,5)+M(id,1))*180/pi))*M(id,3)) - (m(3)* (a(3)*sin((Y(id,5)+M(id,1))*180/pi)+dx(3)*(sin((Y(id,5)+M(id,1)+M(id,2))*180/pi))*M(id,3)) - (m(3)*(dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*M(id,4));
%     Z1(index1)=Px;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Px=(m(1)*Y(id,2))+ (m(2)*Y(id,2))- (m(2)*( a(2)*sin(Y(id,5)*180/pi)+ dx(2)*sin((Y(id,5)+M(id,1))*180/pi) )*Y(id,6)) - (m(2)*dx(2)*sin((Y(id,5)+M(id,1))*180/pi)*M(id,3)) + (m(3)*Y(id,2)) - (m(3)*(a(2)*sin(Y(id,5)*180/pi)+dx(2)*sin((Y(id,5)+M(id,1))*180/pi))*Y(id,6)) - (m(3)*( a(2)*sin(Y(id,5)*180/pi)+ a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi) )*(Y(id,6)+M(id,3))) - (m(3)*(dx(2)*sin((Y(id,5)+M(id,1))*180/pi))*M(id,3)) - (m(3)* (a(3)*sin((Y(id,5)+M(id,1))*180/pi)+dx(3)*(sin((Y(id,5)+M(id,1)+M(id,2))*180/pi))*M(id,3)) - (m(3)*(dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*M(id,4));
%     Z1(index1)=Px;
%     
%     Py=(m(1)*Y(id,4))+ (m(2)*Y(id,4))+ (m(2)*( a(2)*cos(Y(id,5)*180/pi)+ dx(2)*cos((Y(id,5)+M(id,1))*180/pi) )*Y(id,6)) + (m(2)*dx(2)*cos((Y(id,5)+M(id,1))*180/pi)*M(id,3)) + (m(3)*Y(id,4)) + (m(3)*(a(2)*cos(Y(id,5)*180/pi)+dx(2)*cos((Y(id,5)+M(id,1))*180/pi))*Y(id,6)) + (m(3)*( a(2)*cos(Y(id,5)*180/pi)+ a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) )*(Y(id,6)+M(id,3))) + (m(3)*(dx(2)*cos((Y(id,5)+M(id,1))*180/pi))*M(id,3)) + (m(3)* (a(3)*cos((Y(id,5)+M(id,1))*180/pi)+dx(3)*(cos((Y(id,5)+M(id,1)+M(id,2))*180/pi))*M(id,3)) + (m(3)*(dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*M(id,4));
%     Z2(index1)=Py;
%     
%     Lz=  Iczz(2)*Y(id,6) +  m(2)*( a(2)^2 +dx(2)^2 + 2*a(2)*dx(2)*cos(M(id,1)*180/pi) )*Y(id,6) + Iczz(3)* (Y(id,6)+M(id,3)) + m(3)*( a(2)^2  +a(3)^2  +dx(3)^2 + 2*a(2)*a(3)*cos(M(id,1)*180/pi) +2*a(3)*dx(3)*cos(M(id,2)*180/pi)+  2*a(2)*dx(3)*cos((M(id,1)+M(id,2))*180/pi) ) *(Y(id,6)+M(id,3))  + Iczz(2)*M(id,3) + m(2)*( dx(2)^2 + a(2)*dx(2)*cos(M(id,1)*180/pi) ) *M(id,3) + Iczz(3)*M(id,4) + m(3)*( dx(3)^2 + dx(3)*a(2)*cos((M(id,1)+M(id,2))*180/pi) + dx(3)*a(3)*cos(M(id,2)*180/pi) ) *M(id,4) + m(2)* Y(id,4)* ( a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi) ) + m(2) *Y(id,2)* ( a(2)*sin((Y(id,5))*180/pi)+ dx(2)*sin((Y(id,5)+M(id,1))*180/pi) ) +( m(3)*( Y(id,4)+ ( a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi) )*Y(id,6) +( dx(2)*cos((Y(id,5)+M(id,1))*180/pi)*M(id,3)) ) *( a(2)*cos(Y(id,5)) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) ) )+( m(3)*( Y(id,2)- ( a(2)*sin((Y(id,5))*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi) )*Y(id,6) - (dx(2)*sin((Y(id,5)+Y(id,6))*180/pi)*M(id,3)) )*( a(2)*sin(Y(id,5)) + a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi) ));
%     Z3(index1)=Lz;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% r1x=a(2)*cos(Y(id,5)) +dx(2)*cos(Y(id,5)+M(id,1)) ; r1y=a(2)*sin(Y(id,5)) +dx(2)*sin(Y(id,5)+M(id,1));
% 
% r2x=a(2)*cos(Y(id,5)) +a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) ; r2y=a(2)*sin(Y(id,5)) +a(3)*sin(Y(id,5)+M(id,1)) +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2));
% 
% Px=(m(1)+m(2)+m(3))*Y(id,2) -(m(2)*r1y +m(3)*(r1y+r2y))*Y(id,6) - m(3)*r2y *M(id,3) -(m(2)*dx(2)*sin(Y(id,5)+M(id,1))*M(id,3) +m(3)*(dx(2)*sin(Y(id,5)+M(id,1))*M(id,3) +  dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))*M(id,4)));
% Z1(index1)=Px;
% 
% Py=(m(1)+m(2)+m(3))*Y(id,4) +(m(2)*r1x +m(3)*(r1x+r2x))*Y(id,6) + m(3)*r2x *M(id,3) +(m(2)*dx(2)*cos(Y(id,5)+M(id,1))*M(id,3) +m(3)*(dx(2)*cos(Y(id,5)+M(id,1))*M(id,3) +  dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))*M(id,4)));
% Z2(index1)=Py;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% r1x=a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi) ; r1y=a(2)*sin(Y(id,5)*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi);
% 
% r2x=a(2)*cos(Y(id,5)*180/pi) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) ; r2y=a(2)*sin(Y(id,5)*180/pi) +a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi);
% 
%  Px=(m(1)+m(2)+m(3))*Y(id,2) -(m(2)*r1y +m(3)*(r1y+r2y))*Y(id,6) - m(3)*r2y *M(id,3) -(m(2)*dx(2)*sin((Y(id,5)+M(id,1))*180/pi)*M(id,3) +m(3)*(dx(2)*sin((Y(id,5)+M(id,1))*180/pi)*M(id,3) +  dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)*M(id,4)));
% 
% Z1(index1)=Px;
% 
% Py=(m(1)+m(2)+m(3))*Y(id,4) +(m(2)*r1x +m(3)*(r1x+r2x))*Y(id,6) + m(3)*r2x *M(id,3) +(m(2)*dx(2)*cos((Y(id,5)+M(id,1))*180/pi)*M(id,3) +m(3)*(dx(2)*cos((Y(id,5)+M(id,1))*180/pi)*M(id,3) +  dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)*M(id,4)));
% Z2(index1)=Py;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% r1x=a(2)*cos(Y(id,5)) +dx(2)*cos(Y(id,5)+M(id,1)) ; r1y=a(2)*sin(Y(id,5)) +dx(2)*sin(Y(id,5)+M(id,1));
% 
% r2x=a(2)*cos(Y(id,5)) +a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) ; r2y=a(2)*sin(Y(id,5)) +a(3)*sin(Y(id,5)+M(id,1)) +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2));
% 
% Px=(m(1)+m(2)+m(3))*Y(id,2) -(m(2)*r1y +m(3)*(r1y+r2y))*Y(id,6)  -(m(2)*dx(2)*sin(Y(id,5)+M(id,1))*M(id,3) +m(3)*( a(3)*sin(Y(id,5)+M(id,1)) +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2)) +dx(2)*sin(Y(id,5)+M(id,1)) )*M(id,3) +  dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))*M(id,4));
% Z1(index1)=Px;
% 
% Py=(m(1)+m(2)+m(3))*Y(id,4) +(m(2)*r1x +m(3)*(r1x+r2x))*Y(id,6)  +(m(2)*dx(2)*cos(Y(id,5)+M(id,1))*M(id,3) +m(3)*( a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) +dx(2)*cos(Y(id,5)+M(id,1)) )*M(id,3) +  dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))*M(id,4));
% Z2(index1)=Py;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Px=(m(1)+m(2)+m(3))*Y(id,2) -( m(2)*(a(2)*sin(Y(id,5)*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi)) +m(3)*(2*a(2)*sin(Y(id,5)*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*Y(id,6) -( m(2)*(dx(2)*sin((Y(id,5)+M(id,1))*180/pi))+ m(3)*(a(2)*sin(Y(id,5)*180/pi)+dx(2)*sin((Y(id,5)+M(id,1))*180/pi)+dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*M(id,3) - m(3)*(dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)*M(id,4))
% Z1(index1)=Px;
% 
% Py=(m(1)+m(2)+m(3))*Y(id,4) +( m(2)*(a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi)) +m(3)*(2*a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*Y(id,6) +( m(2)*(dx(2)*cos((Y(id,5)+M(id,1))*180/pi))+ m(3)*(a(2)*cos(Y(id,5)*180/pi)+dx(2)*cos((Y(id,5)+M(id,1))*180/pi)+dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*M(id,3) + m(3)*(dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)*M(id,4))
% Z2(index1)=Py;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Px=(m(1)+m(2)+m(3))*Y(id,2)-(m(2)*(a(2)*sin(Y(id,5))+dx(2)*sin(Y(id,5)+M(id,1))) +m(3)*(2*a(2)*sin(Y(id,5)) +dx(2)*sin(Y(id,5)+M(id,1))+a(3)*sin(Y(id,5)+M(id,1))  +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))))*Y(id,6) -( m(2)*(dx(2)*sin(Y(id,5)+M(id,1)))+ m(3)*(a(3)*sin(Y(id,5)+M(id,1)) +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2)) +dx(2)*sin(Y(id,5)+M(id,1)))     + m(3)*(a(2)*sin(Y(id,5))+dx(2)*sin(Y(id,5)+M(id,1))+dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))))*M(id,3) - m(3)*(dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))*M(id,4));
% Z1(index1)=Px;
% 
% Py=(m(1)+m(2)+m(3))*Y(id,4)+(m(2)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1))) +m(3)*(2*a(2)*cos(Y(id,5)) +dx(2)*cos(Y(id,5)+M(id,1))+a(3)*cos(Y(id,5)+M(id,1))  +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*Y(id,6) +( m(2)*(dx(2)*cos(Y(id,5)+M(id,1)))+ m(3)*(a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) +dx(2)*cos(Y(id,5)+M(id,1)))     + m(3)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1))+dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*M(id,3) + m(3)*(dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))*M(id,4));
% Z2(index1)=Py;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Px=(m(1)+m(2)+m(3))*Y(id,2)-(m(2)*(a(2)*sin(Y(id,5)*180/pi)+dx(2)*sin((Y(id,5)+M(id,1))*180/pi)) +m(3)*(2*a(2)*sin(Y(id,5)*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi)+a(3)*sin((Y(id,5)+M(id,1))*180/pi)  +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*Y(id,6) -( m(2)*(dx(2)*sin((Y(id,5)+M(id,1))*180/pi))+ m(3)*(a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi))     + m(3)*(a(2)*sin(Y(id,5)*180/pi)+dx(2)*sin((Y(id,5)+M(id,1))*180/pi)+dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*M(id,3) - m(3)*(dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)*M(id,4));
% Z1(index1)=Px;
% 
% Py=(m(1)+m(2)+m(3))*Y(id,4)+(m(2)*(a(2)*cos(Y(id,5)*180/pi)+dx(2)*cos((Y(id,5)+M(id,1))*180/pi)) +m(3)*(2*a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi)+a(3)*cos((Y(id,5)+M(id,1))*180/pi)  +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*Y(id,6) +( m(2)*(dx(2)*cos((Y(id,5)+M(id,1))*180/pi))+ m(3)*(a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi))     + m(3)*(a(2)*cos(Y(id,5)*180/pi)+dx(2)*cos((Y(id,5)+M(id,1))*180/pi)+dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)))*M(id,3) + m(3)*(dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)*M(id,4));
% Z2(index1)=Py;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Px=(m(1)+m(2)+m(3))*Y(id,2)-(m(2)*(a(2)*sin(Y(id,5))+dx(2)*sin(Y(id,5)+M(id,1))) +m(3)*(2*a(2)*sin(Y(id,5)) +dx(2)*sin(Y(id,5)+M(id,1))+a(3)*sin(Y(id,5)+M(id,1))  +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))))*Y(id,6) -( m(2)*(dx(2)*sin(Y(id,5)+M(id,1)))+ m(3)*(a(3)*sin(Y(id,5)+M(id,1)) +dx(3)*sin(Y(id,5)+M(id,1)+M(id,2)) +dx(2)*sin(Y(id,5)+M(id,1)))     + m(3)*(a(2)*sin(Y(id,5))+dx(2)*sin(Y(id,5)+M(id,1))+dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))))*M(id,3) - m(3)*(dx(3)*sin(Y(id,5)+M(id,1)+M(id,2))*M(id,4));
% Px=(m(1)+m(2)+m(3))*Y(id,2) -( (m(2)+m(3))*(a(2)*sin(Y(id,5)*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*sin(Y(id,5)*180/pi) +a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi) ) )*Y(id,6)-( (m(2)+m(3))*(dx(2)*sin((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*sin(Y(id,5)*180/pi) +a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)) )*M(id,3) - m(3)*dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)*M(id,4)
% 
% Z1(index1)=Px;
% % 
% % % Py=(m(1)+m(2)+m(3))*Y(id,4)+(m(2)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1))) +m(3)*(2*a(2)*cos(Y(id,5)) +dx(2)*cos(Y(id,5)+M(id,1))+a(3)*cos(Y(id,5)+M(id,1))  +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*Y(id,6) +( m(2)*(dx(2)*cos(Y(id,5)+M(id,1)))+ m(3)*(a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) +dx(2)*cos(Y(id,5)+M(id,1)))     + m(3)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1))+dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*M(id,3) + m(3)*(dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))*M(id,4));
% Py=(m(1)+m(2)+m(3))*Y(id,4) +( (m(2)+m(3))*(a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*cos(Y(id,5)*180/pi) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) ) )*Y(id,6)+( (m(2)+m(3))*(dx(2)*cos((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*cos(Y(id,5)*180/pi) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)) )*M(id,3) + m(3)*dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)*M(id,4)
% 
% Z2(index1)=Py;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Px=(m(1)+m(2)+m(3))*Y(id,2) -( (m(2)+m(3))*(a(2)*sin(Y(id,5)*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*sin(Y(id,5)*180/pi) +a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi) ) )*Y(id,6)-( (m(2)+m(3))*(dx(2)*sin((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*sin(Y(id,5)*180/pi) +a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)) )*M(id,3) - m(3)*( dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)+ a(3)*sin((Y(id,5)+M(id,1))*180/pi) )*M(id,4)
% 
% Z1(index1)=Px;
% % 
% % Py=(m(1)+m(2)+m(3))*Y(id,4)+(m(2)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1))) +m(3)*(2*a(2)*cos(Y(id,5)) +dx(2)*cos(Y(id,5)+M(id,1))+a(3)*cos(Y(id,5)+M(id,1))  +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*Y(id,6) +( m(2)*(dx(2)*cos(Y(id,5)+M(id,1)))+ m(3)*(a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) +dx(2)*cos(Y(id,5)+M(id,1)))     + m(3)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1))+dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*M(id,3) + m(3)*(dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))*M(id,4));
% Py=(m(1)+m(2)+m(3))*Y(id,4) +( (m(2)+m(3))*(a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*cos(Y(id,5)*180/pi) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) ) )*Y(id,6)+( (m(2)+m(3))*(dx(2)*cos((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*cos(Y(id,5)*180/pi) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)) )*M(id,3) + m(3)*( dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) + a(3)*cos((Y(id,5)+M(id,1))*180/pi))*M(id,4)
% 
%  Z2(index1)=Py;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Px=(m(1)+m(2)+m(3))*Y(id,2) -( (m(2)+m(3))*(a(2)*sin(ang1(id,1)) +dx(2)*sin(ang1(id,1)+ang2(id,1))) + m(3)*( a(2)*sin(ang1(id,1)) +a(3)*sin(ang1(id,1)+ang2(id,1)) +dx(3)*sin(ang1(id,1)+ang2(id,1)+ang2(id,2)) ) )*Y(id,6)-( (m(2)+m(3))*(dx(2)*sin(ang1(id,1)+ang2(id,1))) + m(3)*( a(2)*sin(ang1(id,1)) +a(3)*sin(ang1(id,1)+ang2(id,1)) +dx(3)*sin(ang1(id,1)+ang2(id,1)+ang2(id,2))) )*M(id,3) - m(3)*( dx(3)*sin(ang1(id,1)+ang2(id,1)+ang2(id,2))+ a(3)*sin(ang1(id,1)+ang2(id,1)) )*M(id,4)
% 
% Z1(index1)=Px;

% Py=(m(1)+m(2)+m(3))*Y(id,4)+(m(2)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1))) +m(3)*(2*a(2)*cos(Y(id,5)) +dx(2)*cos(Y(id,5)+M(id,1))+a(3)*cos(Y(id,5)+M(id,1))  +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*Y(id,6) +( m(2)*(dx(2)*cos(Y(id,5)+M(id,1)))+ m(3)*(a(3)*cos(Y(id,5)+M(id,1)) +dx(3)*cos(Y(id,5)+M(id,1)+M(id,2)) +dx(2)*cos(Y(id,5)+M(id,1)))     + m(3)*(a(2)*cos(Y(id,5))+dx(2)*cos(Y(id,5)+M(id,1))+dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))))*M(id,3) + m(3)*(dx(3)*cos(Y(id,5)+M(id,1)+M(id,2))*M(id,4));
% Py=(m(1)+m(2)+m(3))*Y(id,4) +( (m(2)+m(3))*(a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*cos(Y(id,5)*180/pi) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) ) )*Y(id,6)+( (m(2)+m(3))*(dx(2)*cos((Y(id,5)+M(id,1))*180/pi)) + m(3)*( a(2)*cos(Y(id,5)*180/pi) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)) )*M(id,3) + m(3)*( dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) + a(3)*cos((Y(id,5)+M(id,1)))*180/pi)*M(id,4)

% Z2(index1)=Py;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% W=m(1)+m(2)+m(3);
% I=[1 0 0;0 1 0;0 0 1];
% V0=[Y(id,2);Y(id,4);0];
% %[r1x r1y 0]=[a0/2*cos(th0)+a1/2*cos(th0+th1) a0/2*sin(th0)+a1/2*sin(th0+th1) 0];
% 
% %r1x=a(2)*cos(Y(id,5)*180/pi)+dx(2)*cos(th0+th1)
% r1x=a(2)*cos(Y(id,5)*180/pi) +dx(2)*cos((Y(id,5)+M(id,1))*180/pi) ;
% 
% %r1y=a(2)*sin(th0)+dx(2)*sin(th0+th1)
% r1y=a(2)*sin(Y(id,5)*180/pi) +dx(2)*sin((Y(id,5)+M(id,1))*180/pi);

% %r2x=a(2)*cos(th0)+a(3)*cos(th0+th1)+dx(3)*cos(th0+th1+th2)
% r2x=a(2)*cos(Y(id,5)*180/pi) +a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi) ;
% 
% %r2y=a(2)*sin(th0)+a(3)*sin(th0+th1)+dx(3)*sin(th0+th1+th2)
% r2y=a(2)*sin(Y(id,5)*180/pi) +a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi);
% 
% rog=[0 0 m(2)*r1y+m(3)*r2y;0 0 -(m(2)*r1x+m(3)*r2x);-(m(2)*r1y+m(3)*r2y) m(2)*r1x+m(3)*r2x 0];
% 
% w0=[0;0;Y(id,6)];
% 
% dphi=[M(id,5);M(id,6)];
% 
% Jtg=[-m(2)* (dx(2)*sin((Y(id,5)+M(id,1))*180/pi))-m(3)*( a(3)*sin((Y(id,5)+M(id,1))*180/pi) +dx(3)*sin( (Y(id,5)+M(id,1)+M(id,2))*180/pi) ) -m(3)*dx(3)*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi);m(2)*(dx(2)*cos((Y(id,5)+M(id,1))*180/pi))+m(3)*(a(3)*cos((Y(id,5)+M(id,1))*180/pi) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)) m(3)*dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi);0 0];
% 
% P=((W*I*V0) + (rog')*w0 + ((Jtg*dphi)))';
% Z(index1,:)=P;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M1=m(1)+m(2)+m(3);
I=[1 0 0;0 1 0;0 0 1];
vb=[Y(id,2),Y(id,4),0]';
% rbg=[(m(2)/M1)*(a(2))*cos(Y(id,5)) + (m(2)/M1)*(dx(2))*cos(Y(id,5)+M(id,1)) + (m(3)/M1)*(a(2))*cos(Y(id,5)) + (m(3)/M1)*a(3)*cos(Y(id,5)+M(id,1)) + (m(3)/M1)*(dx(3))*cos(Y(id,5)+M(id,1)+M(id,2))
%      (m(2)/M1)*(a(2))*sin(Y(id,5)) + (m(2)/M1)*(dx(2))*sin(Y(id,5)+M(id,1)) + (m(3)/M1)*(a(2))*sin(Y(id,5)) + (m(3)/M1)*a(3)*sin(Y(id,5)+M(id,1)) + (m(3)/M1)*(dx(3))*sin(Y(id,5)+M(id,1)+M(id,2))
%      0];
rbg=[(m(2)/M1)*(a(2))*cos(Y(id,5)*180/pi) + (m(2)/M1)*(dx(2))*cos((Y(id,5)+M(id,1))*180/pi) + (m(3)/M1)*(a(2))*cos(Y(id,5)*180/pi) + (m(3)/M1)*a(3)*cos((Y(id,5)+M(id,1))*180/pi) + (m(3)/M1)*(dx(3))*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)
     (m(2)/M1)*(a(2))*sin(Y(id,5)*180/pi) + (m(2)/M1)*(dx(2))*sin((Y(id,5)+M(id,1))*180/pi) + (m(3)/M1)*(a(2))*sin(Y(id,5)*180/pi) + (m(3)/M1)*a(3)*sin((Y(id,5)+M(id,1))*180/pi) + (m(3)/M1)*(dx(3))*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)
     0];
wb=[0; 0 ;Y(id,6)];
dph=[M(id,3); M(id,4)];

% Jtg=[-(m(2)*dx(2))*sin(Y(id,5)+M(id,1))-m(3)*a(3)*sin(Y(id,5)+M(id,1))-(m(3)*dx(3))*sin(Y(id,5)+M(id,1)+M(id,2)) -(m(3)*dx(3))*sin(Y(id,5)+M(id,1)+M(id,2));
%       (m(2)*dx(2))*cos(Y(id,5)+M(id,1))+m(3)*a(3)*cos(Y(id,5)+M(id,1))+(m(3)*dx(3))*cos(Y(id,5)+M(id,1)+M(id,2))  (m(3)*dx(3))*cos(Y(id,5)+M(id,1)+M(id,2));
%       0 0];
Jtg=[-(m(2)*dx(2))*sin((Y(id,5)+M(id,1))*180/pi)-m(3)*a(3)*sin((Y(id,5)+M(id,1))*180/pi)-(m(3)*dx(3))*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi)  -(m(3)*dx(3))*sin((Y(id,5)+M(id,1)+M(id,2))*180/pi);
      (m(2)*dx(2))*cos((Y(id,5)+M(id,1))*180/pi)+m(3)*a(3)*cos((Y(id,5)+M(id,1))*180/pi)+(m(3)*dx(3))*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi)   (m(3)*dx(3))*cos((Y(id,5)+M(id,1)+M(id,2))*180/pi);
      0 0];
P=(M1*vb + M1*cross(wb,rbg) + Jtg*dph);
Z(index1,:)=P;
PP=[P1,P];
P1=PP




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % W=m(1)+m(2)+m(3);
% % I=[1 0 0;0 1 0;0 0 1];
% % V0=[Y(id,2);Y(id,4);0];
% % [r1x r1y 0]=[a0/2*cos(th0)+a1/2*cos(th0+th1) a0/2*sin(th0)+a1/2*sin(th0+th1) 0];
% % 
% % r1x=a(2)*cos(Y(id,5)*180/pi)+dx(2)*cos(th0+th1)
% % r1x=a(2)*cos(Y(id,5)) +dx(2)*cos((Y(id,5)+M(id,1))) ;
% % 
% % r1y=a(2)*sin(th0)+dx(2)*sin(th0+th1)
% % r1y=a(2)*sin(Y(id,5)) +dx(2)*sin((Y(id,5)+M(id,1)));
% % 
%r2x=a(2)*cos(th0)+a(3)*cos(th0+th1)+dx(3)*cos(th0+th1+th2)
% r2x=a(2)*cos(Y(id,5)) +a(3)*cos((Y(id,5)+M(id,1))) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2))) ;
% 
% %r2y=a(2)*sin(th0)+a(3)*sin(th0+th1)+dx(3)*sin(th0+th1+th2)
% r2y=a(2)*sin(Y(id,5)) +a(3)*sin((Y(id,5)+M(id,1))) +dx(3)*sin((Y(id,5)+M(id,1)+M(id,2)));
% 
% rog=[0 0 m(2)*r1y+m(3)*r2y;0 0 -(m(2)*r1x+m(3)*r2x);-(m(2)*r1y+m(3)*r2y) m(2)*r1x+m(3)*r2x 0];
% 
% w0=[0;0;Y(id,6)];
% 
% dphi=[M(id,5);M(id,6)];
% 
% Jtg=[-m(2)* (dx(2)*sin((Y(id,5)+M(id,1))))-m(3)*( a(3)*sin((Y(id,5)+M(id,1))) +dx(3)*sin( (Y(id,5)+M(id,1)+M(id,2))) ) -m(3)*dx(3)*sin((Y(id,5)+M(id,1)+M(id,2)));m(2)*(dx(2)*cos((Y(id,5)+M(id,1))))+m(3)*(a(3)*cos((Y(id,5)+M(id,1))) +dx(3)*cos((Y(id,5)+M(id,1)+M(id,2)))) m(3)*dx(3)*cos((Y(id,5)+M(id,1)+M(id,2)));0 0];
% 
% P=((W*I*V0) + (rog')*w0 + ((Jtg*dphi)))';
% Z(index1,:)=P;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
% KU=table(Z1,Z2,Z3,'VariableNames',{'Px' 'Py' 'Lz'})

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

% index=0;
% 
% % Animating using Loops (Smart updating)
% figure;
% 
% tic;    % start timing
% for id = 1:length(T)
%    index=index+1;
%    % The top plot shows a time series of link angles
%    x0=[ 0.5;0.5;-0.5;-0.5; 0.5];
%    y0=[-0.5;0.5; 0.5;-0.5;-0.5];
%    B=[x0 y0];
% %    R=[cos(ang1(id,1)) -sin(ang1(id,1));sin(ang1(id,1)) cos(ang1(id,1))]';
%     R=[cos(Y(id,5)) -sin(Y(id,5));sin(Y(id,5)) cos(Y(id,5))]';
%     V=B*R;
% 
%    X0(:,id)=V(:,1);
%    Y0(:,id)=V(:,2);
%    ,t,P1(2,:),t,P1(3,:))
% %    x1(id,:) = [(X0(1,id)/2)*cos(M(id,1))+L1*cos(M(id,1)+(Y(id,5))),   (X0(1,id)/2)*cos(M(id,1))+L1*cos(M(id,1)+Y(id,5))+L2*cos(M(id,1)+M(id,2)+Y(id,5))];
% %    y1(id,:) = [(Y0(1,id)/2)*cos(M(id,1))+L1*sin(M(id,1)+(Y(id,5))),   (Y0(1,id)/2)*cos(M(id,1))+L1*sin(M(id,1)+Y(id,5))+L2*sin(M(id,1)+M(id,2)+Y(id,5))];
% 
% %    x1(id,:) = [L1*cos(M(id,1)+Y(id,5)),   L1*cos(M(id,1)+Y(id,5))+L2*cos(M(id,1)+M(id,2)+Y(id,5))];
% %    y1(id,:) = [L1*sin(M(id,1)+Y(id,5)),   L1*sin(M(id,1)+Y(id,5))+L2*sin(M(id,1)+M(id,2)+Y(id,5))]; 
%    
%    x1(id,:) = L1*[cos(M(id,1)+Y(id,5)),   cos(M(id,1)+Y(id,5))+cos(M(id,1)+M(id,2)+Y(id,5))];
%    y1(id,:) = L1*[sin(M(id,1)+Y(id,5)),   sin(M(id,1)+Y(id,5))+sin(M(id,1)+M(id,2)+Y(id,5))]; 
%    
%    
%    B=[x1(id,:)' y1(id,:)'];
% %    rx(:,index)=X0(:,id);
% %    ry(:,index)=Y0(:,id);
%    
%    plot(X0(:,id),Y0(:,id))
% 
%    patch(X0(:,id),Y0(:,id),'red')
%    axis equal
%    axis([-L L -L L]);
%   
%     hold on
%    cx=(X0(1,id)+X0(2,id))/2;
%    cy=(Y0(1,id)+Y0(2,id))/2;
%    
%    plot([cx, x1(id,1)+cx;x1(id,1)+cx, x1(id,2)+cx], [cy, y1(id,1)+cy;y1(id,1)+cy, y1(id,2)+cy],'.-','Color',[0.15 0.32 0.26], 'MarkerSize', 20, 'LineWidth', 2)
% %    plot([0, x1(id,1);x1(id,1), x1(id,2)], [0, y1(id,1);y1(id,1), y1(id,2)],'.-','Color',[0.15 0.32 0.26], 'MarkerSize', 20, 'LineWidth', 2)
% %     plot([(rx(1,index)+rx(2,index))/2, x1(id,1);x1(id,1), x1(id,2)], [(ry(1,index)+ry(2,index))/2, y1(id,1);y1(id,1), y1(id,2)],'.-','LineWidth', 2)
%    axis equal; 
%   
%    axis([-L L -L L]);
%    
%    title(sprintf('Time: %0.2f sec', T(id)));
% %    xlabel('XY-Plane[ $$$ 2-Link space robot ANIMATION  $$$ ]','FontSize',12,'FontWeight','bold','Color','k');
%    xlabel(sprintf('Angle(th1): %0.2f degrees',ang(id,1)),'FontSize',12,'FontWeight','bold','Color','m');
%    ylabel(sprintf('Angle(th2): %0.2f degrees',ang(id,2)),'FontSize',12,'FontWeight','bold','Color','r');
% 
%    drawnow;
%    hold off
% end
% fprintf('Animation (Regular): %0.2f sec\n', toc)
% 
% 
% figure
% hold on
% title('Base position(x0,y0)(m) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('Base position(x0,y0)(m)')
% plot(t,Y(:,1),'c-o','DisplayName','x0')
% 
% hold on
% plot(t,Y(:,3),'m*','DisplayName','y0');
% legend('show')
% 
% figure
% hold on
% title('Base velocities(dx0,dy0)(m/s) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('Base velocities(dx0,dy0)(m/s)')
% plot(t,Y(:,2),'m-o','DisplayName','dx0')
% 
% hold on
% plot(t,Y(:,4),'b*','DisplayName','dy0');
% legend('show')
% 
% figure
% hold on
% title('Base rotation(th0)(rad) vs Time(s) Graph');
% xlabel('Time(sec)')
% ylabel('Base rotation(th0)(rad)')
% plot(t,Y(:,5),'b*')
% 
% figure
% hold on
% title('Rate of Base rotation(dth0)(rad/s) vs Time(s) Graph');
% xlabel('Time(sec)')
% ylabel('Rate of Base rotation(dth0)(rad/s)')
% plot(t,Y(:,6),'co')
% 
% 
% figure
% hold on
% title('(JOINT ANGLEs)(rad) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(JOINT ANGLEs)(rad)')
% plot(t,M(:,1),'g-o','DisplayName','th1')
% 
% hold on
% plot(t,M(:,2),'r*','DisplayName','th2');
% legend('show')
% 
% figure
% hold on
% title('(Rate of JOINT ANGLEs)(rad/s) vs Time(sec) Graph')
% xlabel('Time(sec)')
% ylabel('(Rate of JOINT ANGLEs)(rad/s)')
% plot(t,M(:,3),'g-o','DisplayName','dth1')
% 
% hold on
% plot(t,M(:,4),'r*','DisplayName','dth2')
% legend('show')
% 
% % clc;
% 



