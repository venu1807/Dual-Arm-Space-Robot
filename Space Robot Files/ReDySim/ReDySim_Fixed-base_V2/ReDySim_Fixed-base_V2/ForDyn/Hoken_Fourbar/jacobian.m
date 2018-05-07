function [J, dJ]=jacobian(th,dth)

[n dof type alp a b thh bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();

% %Hoken's mechanism
% thf1=pi;  % angle with fixed link
% a3=0.2304; a12=0.0895; a32=0.1152;  
% a1=0.038; a2=0.1152; a31=0.1152;

a1=al(1); a2=al(2);a31=al(3);

%Hoken's mechanism
alp1=th(1);
alp2=th(2);
alp3=th(2)+th(3)-2*pi;

% Velocities_dtheta
J11=[ a1*sin(alp1)
     -a1*cos(alp1)
     ];
J121= [-a2*sin(alp2)-a31*sin(alp3)
        a2*cos(alp2)+a31*cos(alp3)
        ];
J122= [-a31*sin(alp3)
        a31*cos(alp3)
        ];    

J12=[J121 J122];
J=[J11 J12];
% Acceleration_ddtheta 
dalp1=dth(1);
dalp2=dth(2);
dalp3=dth(2)+dth(3);

dJ11=[a1*cos(alp1)*dalp1
      a1*sin(alp1)*dalp1
     ];
dJ121= [-a2*cos(alp2)*dalp2-a31*cos(alp3)*dalp3
        -a2*sin(alp2)*dalp2-a31*sin(alp3)*dalp3
         ];
dJ122= [-a31*cos(alp3)*dalp3
        -a31*sin(alp3)*dalp3
         ];    

dJ12=[dJ121 dJ122 ];
dJ=[dJ11 dJ12];