function [thp] = Torque12(t,x)

ti=0;
tf=30;
thin_0=0;
thin_1=0.3803;
thin_2=-0.6198;
thf_0=pi/2;
thf_1=-pi/2;
thf_2=-pi/2;
dthf_0=0;
dthf_1=0;
dthf_2=0;
Tp=tf;

thin=[0.3803;   -0.6198];
thf=[-pi/2; -pi/2];
ti=0;
tf=30;
n=3;
Tp=tf;
index=0;
A=zeros(1,2);
B=zeros(1,2);
C=zeros(1,2);
H=zeros(tf,6);
t=linspace(0,tf,100);
for t=linspace(0,tf,100)
    index=index+1;
       for i=1:2
       th(i)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
       dth(i)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
       ddth(i)=(2*pi*(thf(i)-thin(i))/(Tp*Tp))*sin((2*pi/Tp)*t);
       A(i)=th(i);
       B(i)=dth(i);
       C(i)=ddth(i);
       H(index,:)=[A B C];
       end
    time(index)=t;
end 

Q=time;
I=H(:,1:2);
J=H(:,3:4);
K=H(:,5:6);
M=[I,J,K];
T=table(I(:,1),I(:,2),J(:,1),J(:,2),K(:,1),K(:,2),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'});

x=zeros(length(t),20);

x(:,1)=0;
x(:,2)=0;
x(:,3)=0;
x(:,4)=0;
x(:,5)=0;
x(:,6)=0;
x(:,7)=I(:,1);
x(:,8)= J(:,1);

x(:,9)= I(:,2);
x(:,10)=J(:,2);

x(:,17)=x(:,8);
x(:,18)=K(:,1);

x(:,19)=x(:,10);
x(:,20)=K(:,2);


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


M11=(m(1)+m(2)+m(3));

M12=0;

M13= - a(3)*m(3)*sin(x(5) + x(7)) - dx(2)*m(2)*sin(x(5) + x(7)) - (a(2)*m(2)*sin(x(5)))- (a(2)*m(3)*sin(x(5)))- dx(3)*m(3)*sin( x(5) + x(7)+ x(9));

M14= - a(3)*m(3)*sin(x(5) + x(7))- dx(2)*m(2)*sin(x(5) + x(7))- dx(3)*m(3)*sin(x(5) + x(7)+ x(9));

M15= - dx(3)*m(3)*sin(x(5) + x(7)+ x(9));

C11=0;

C12=0;

C13= - dx(3)*x(6)^2*m(3)*cos(x(5) + x(7)+ x(9)) - a(3)*x(6)^2*m(3)*cos(x(5)+x(7)) - dx(2)*x(6)^2*m(2)*cos(x(5)+x(7))- (a(2)*x(6)^2*m(2)*cos(x(5))) - (a(2)*x(6)^2*m(3)*cos(x(5)))- 2*dx(3)*x(6)*x(10)*m(3)*cos(x(5) + x(7)+ x(9));

C14=- dx(3)*x(8)^2*m(3)*cos(x(5) + x(7)+ x(9))- a(3)*x(8)^2*m(3)*cos(x(6)+x(7))- dx(2)*x(8)^2*m(2)*cos(x(5)+x(7)) - 2*dx(3)*x(6)*x(8)*m(3)*cos(x(5) + x(7)+ x(9))- 2*a(3)*x(6)*x(8)*m(3)*cos(x(5)+x(7)) - 2*dx(2)*x(6)*x(8)*m(2)*cos(x(5)+x(7));

C15=- dx(3)*x(10)^2*m(3)*cos(x(5) + x(7)+ x(9))- 2*dx(3)*x(8)*x(10)*m(3)*cos(x(5) + x(7) + x(9));

M21=0;

M22=(m(1)+m(2)+m(3));

M23= a(3)*m(3)*cos(x(5) + x(7))+ dx(2)*m(2)*cos(x(5)+ x(7))+ (a(2)*m(2)*cos(x(5))) +(a(2)*m(3)*cos(x(5)))+ dx(3)*m(3)*cos(x(5) + x(7) + x(9));

M24= a(3)*m(3)*cos(x(5) + x(7))+ dx(2)*m(2)*cos(x(5)+ x(7))+ dx(3)*m(3)*cos(x(5) + x(7) + x(9));

M25= dx(3)*m(3)*cos(x(5) + x(7) + x(9));

C21=0;

C22=0;

C23=- dx(3)*x(6)^2*m(3)*sin(x(5) + x(7) + x(9))- a(3)*x(6)^2*m(3)*sin(x(5) + x(7))- dx(2)*x(6)^2*m(2)*sin(x(5) + x(7))- (a(2)*x(6)^2*m(2)*sin(x(5))) - (a(2)*x(6)^2*m(3)*sin(x(5))) - 2*dx(3)*x(6)*x(10)*m(3)*sin(x(5)+x(7)+x(9));

C24=- dx(3)*x(8)^2*m(3)*sin(x(5) + x(7) + x(9))- a(3)*x(8)^2*m(3)*sin(x(5) + x(7)) - dx(2)*x(8)^2*m(2)*sin(x(5) + x(7))- 2*dx(3)*x(6)*x(8)*m(3)*sin(x(5) + x(7) + x(9))- 2*a(3)*x(6)*x(8)*m(3)*sin(x(5)+x(7)) - 2*dx(2)*x(6)*x(8)*m(2)*sin(x(5) + x(7));

C25=- dx(3)*x(10)^2*m(3)*sin(x(5)+x(7)+x(9))- 2*dx(3)*x(8)*x(10)*m(3)*sin(x(5)+x(7)+x(9));

M31=- a(3)*m(3)*sin(x(5) + x(7)) - dx(2)*m(2)*sin(x(5) + x(7)) - (a(2)*m(2)*sin(x(5))) - (a(2)*m(3)*sin(x(5)))- dx(3)*m(3)*sin(x(5)+x(7)+x(9));

M32=  a(3)*m(3)*cos(x(5) + x(7)) + dx(2)*m(2)*cos(x(5) + x(7)) + (a(2)*m(2)*cos(x(5))) + (a(2)*m(3)*cos(x(5)))+ dx(3)*m(3)*cos(x(5)+x(7)+x(9));

M33=(Iczz(1)+Iczz(2)+Iczz(3))+ (a(2)^2*m(2))  + (a(2)^2*m(3))+ a(3)^2*m(3)+ dx(2)^2*m(2) + dx(3)^2*m(3) + 2*a(2)*dx(3)*m(3)*cos(x(7) + x(9))+ 2*a(2)*a(3)*m(3)*cos(x(7))+ 2*a(2)*dx(2)*m(2)*cos(x(7))+ 2*a(3)*dx(3)*m(3)*cos(x(9));

M34=(Iczz(2)+Iczz(3))+ a(3)^2*m(3)+ dx(2)^2*m(2) + dx(3)^2*m(3) + (a(2)*dx(3)*m(3)*cos(x(7)+x(9)))+ (a(2)*a(3)*m(3)*cos(x(7))) + (a(2)*dx(2)*m(2)*cos(x(7)))+ 2*a(3)*dx(3)*m(3)*cos(x(9));

M35=(Iczz(3))++ dx(3)^2*m(3)+ (a(2)*dx(3)*m(3)*cos(x(7) + x(9)))+ a(3)*dx(3)*m(3)*cos(x(9));

C31=0;

C32=0;

C33=- 2*a(2)*dx(3)*x(6)*x(10)*m(3)*sin(x(7) + x(9))- 2*a(3)*dx(3)*x(6)*x(10)*m(3)*sin(x(9));

C34= -(a(2)*dx(3)*x(8)^2*m(3)*sin(x(7) + x(9)))- (a(2)*a(3)*x(8)^2*m(3)*sin(x(7))) - (a(2)*dx(2)*x(8)^2*m(2)*sin(x(7))) - 2*a(2)*dx(3)*x(6)*x(8)*m(3)*sin(x(7) + x(9)) - 2*a(2)*a(3)*x(6)*x(8)*m(3)*sin(x(7)) - 2*a(2)*dx(2)*x(6)*x(8)*m(2)*sin(x(7));

C35=- (a(2)*dx(3)*x(10)^2*m(3)*sin(x(7) + x(9)))-a(3)*dx(3)*x(10)^2*m(3)*sin(x(9))- 2*a(2)*dx(3)*x(8)*x(10)*m(3)*sin(x(7) + x(9))-2*a(3)*dx(3)*x(8)*x(10)*m(3)*sin(x(9));
        

M42= a(3)*m(3)*cos(x(5)+x(7)) + dx(2)*m(2)*cos(x(5)+x(7))+ dx(3)*m(3)*cos(x(5)+x(7)+x(9));

M41= - a(3)*m(3)*sin(x(5)+x(7)) - dx(2)*m(2)*sin(x(5)+x(7))- dx(3)*m(3)*sin(x(5)+x(7)+x(9));

M43=Iczz(2) + Iczz(3)+ a(3)^2*m(3) + dx(2)^2*m(2) + dx(3)^2*m(3) + (a(2)*dx(3)*m(3)*cos(x(7)+x(9))) + (a(2)*a(3)*m(3)*cos(x(7))) + (a(2)*dx(2)*m(2)*cos(x(7))) + 2*a(3)*dx(3)*m(3)*cos(x(7));

M44=Iczz(2)+ Iczz(3)+ a(3)^2*m(3) + 2*a(3)*dx(3)*m(3)*cos(x(7))+ dx(2)^2*m(2) + dx(3)^2*m(3);

M45=Iczz(3) + dx(3)^2*m(3) + a(3)*dx(3)*m(3)*cos(x(9));

C41=0;
        
C42=0;
        
C43=(a(2)*dx(3)*x(6)^2*m(3)*sin(x(7)+x(9))) + (a(2)*a(3)*x(6)^2*m(3)*sin(x(7))) + (a(2)*dx(2)*x(6)^2*m(2)*sin(x(7)));
       
C44=- 2*a(3)*dx(3)*x(8)*x(10)*m(3)*sin(x(9));
       
C45=- a(3)*dx(3)*x(10)^2*m(3)*sin(x(9))- 2*a(3)*dx(3)*x(6)*x(10)*m(3)*sin(x(9)) ;
        


M51=-dx(3)*m(3)*sin(x(5)+x(7)+x(9));

M52=dx(3)*m(3)*cos(x(5)+x(7)+x(9));

M53=Iczz(3) + dx(3)^2*m(3) +(a(2)*dx(3)*m(3)*cos(x(7)+x(9))) + a(3)*dx(3)*m(3)*cos(x(9));

M54=Iczz(3) + dx(3)^2*m(3)+ a(3)*dx(3)*m(3)*cos(x(9));

M55=Iczz(3) + dx(3)^2*m(3);

C51=0;

C52=0;

C53=(a(2)*dx(3)*x(6)^2*m(3)*sin(x(7) + x(9))) + a(3)*dx(3)*x(6)^2*m(3)*sin(x(9))+ 2*a(3)*dx(3)*x(6)*x(8)*m(3)*sin(x(9));

C54= a(3)*dx(3)*x(8)^2*m(3)*sin(x(9));

C55=0;

Hb=[M11 M12 M13;M21 M22 M23;M31 M32 M33];
Hbm=[M14 M15;M24 M25;M34 M35];
HbmT=[M41 M42 M43;M51 M52 M53];
Hm=[M44 M45;M54 M55];
Cb=[C11+C12+C13+C14+C15;C21+C22+C23+C24+C25;C31+C32+C33+C34+C35];
Cm=[C41+C42+C43+C44+C45;C51+C52+C53+C54+C55];
% ddXb=[ddx0;ddy0; ddth0];
ddPHI=[K(:,1) ;K(:,2)];
Fb=[0; 0; 0];
% Tau_m=[Tau1;Tau2]
ddXb=(inv(Hb))*(-(Hbm*ddPHI)-Cb);
Tau_m =(HbmT*ddXb)+(Hm*ddPHI)+Cm;