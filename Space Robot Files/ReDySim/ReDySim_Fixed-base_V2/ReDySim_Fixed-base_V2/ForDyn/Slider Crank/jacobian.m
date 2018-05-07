function [J, dJ]=jacobian(th,dth)

[n dof type alp a b thh bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();

a1=al(1); a2=al(2);

%Slider crank mechanism
alp1=pi/2+th(1);
alp2=pi/2+th(1)+th(2);
% Velocities_dtheta

Jc1= [-a1*sin(alp1)-a2*sin(alp2)
        a1*cos(alp1)+a2*cos(alp2)];
Jc2= [-a2*sin(alp2)
        a2*cos(alp2)];   
Jc3=[ -1
     0];

J=[Jc1 Jc2 Jc3];

% Acceleration_ddtheta 
dalp1=dth(1);
dalp2=dth(1)+dth(2);

dJc1= [-a1*cos(alp1)*dalp1-a2*cos(alp2)*dalp2
        -a1*sin(alp1)*dalp1-a2*sin(alp2)*dalp2];
dJc2= [-a2*cos(alp2)*dalp2
        -a2*sin(alp2)*dalp2];    
dJc3=[0
      0];
    
dJ=[dJc1 dJc2 dJc3];