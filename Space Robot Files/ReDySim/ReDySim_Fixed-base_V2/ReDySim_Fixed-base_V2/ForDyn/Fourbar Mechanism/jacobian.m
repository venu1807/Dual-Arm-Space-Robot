function [J, dJ]=jacobian(q,dq)

% 4-bar mechanism mechanism
qf1=0;  % angle with fixed link
% a1=0.038; a2=0.1152; a3=0.2304;
% a12=0.0895; a32=0.1152; a31=0.1152;

[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al ]=inputs(); 
a1=al(1); a2=al(2);a31=al(3);a12=al(4);

%Jacobian J: I*dqh+C*dq=tau+J'*lamda
alp1=q(1);
alp2=q(2);
alp3=q(2)+q(3);


J11=[ a1*sin(alp1)
     -a1*cos(alp1)];
J121= [-a2*sin(alp2)-a31*sin(alp3)
        a2*cos(alp2)+a31*cos(alp3) ];
J122= [-a31*sin(alp3)
        a31*cos(alp3)];   
J12=[J121 J122];
J=[J11 J12];


% Acceleration_ddtheta 
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

dJ=[dJ11 dJ12];