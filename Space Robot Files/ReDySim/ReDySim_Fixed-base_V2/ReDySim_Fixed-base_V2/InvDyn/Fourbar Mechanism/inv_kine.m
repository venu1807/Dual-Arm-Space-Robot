% ReDySim inv_kine module. This module perform inverse kinematics of the
% 4-bar mechanism only
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [q dq ddq J]=inv_kine(qi, dqi, ddqi)

% 4-bar mechanism mechanism
qf1=0;  % angle with fixed link
% a1=0.038; a2=0.1152; a3=0.2304;
% a12=0.0895; a32=0.1152; a31=0.1152;

[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps ]=inputs(); 
a1=al(1); a2=al(2);a31=al(3);a12=al(4);

dq(1)=dqi;
ddq(1)=ddqi;
q(1,1)=qi;


%Hoken's mechanism
alp1=q(1);
p1=a1*cos(alp1)-a12*cos(qf1);
q1=a1*sin(alp1)-a12*sin(qf1);
x1=(q1/a1);
y1=(p1/a1);
z11=(p1*p1+q1*q1+a31*a31-a2*a2)/(2*a31*a1);
alp3=2*atan2(x1+sqrt(x1*x1+y1*y1-z11*z11),y1+z11);
z12=(p1*p1+q1*q1+a2*a2-a31*a31)/(2*a2*a1);
alp2=2*atan2(x1-sqrt(x1*x1+y1*y1-z12*z12),y1+z12);
q(2,1)=alp2;
q(3,1)=(2*pi+alp3)-q(2);

%Jacobian J: I*dqh+C*dq=tau+J'*lamda

J11=[ a1*sin(alp1)
     -a1*cos(alp1)];
J121= [-a2*sin(alp2)-a31*sin(alp3)
        a2*cos(alp2)+a31*cos(alp3) ];
J122= [-a31*sin(alp3)
        a31*cos(alp3)];    

J12=[J121 J122 ];
J=[J11 J12];

% Velocities_dtheta
c1=J12\J11;
dqd=-c1*dq(1);
dq=[dq(1)
     dqd];
 
% Jacobian JJ: JJ'(I*dqh+C*dq=tau)
JJ=[1
   -c1];

% Acceleration_ddqeta 
dalp1=dq(1);
dalp2=dq(2);
dalp3=dq(2)+dq(3);

dJ11=[a1*cos(alp1)*dalp1
      a1*sin(alp1)*dalp1];
dJ121= [-a2*cos(alp2)*dalp2-a31*cos(alp3)*dalp3
        -a2*sin(alp2)*dalp2-a31*sin(alp3)*dalp3 ];
dJ122= [-a31*cos(alp3)*dalp3
        -a31*sin(alp3)*dalp3];    

dJ12=[dJ121 dJ122];
c2=-dJ11*dq(1)-dJ12*dqd-J11*ddq(1);
ddqd=J12\c2;
ddq=[ddq(1)
      ddqd];

q=q';dq=dq';ddq=ddq';