function [J, dJ]=jacobian(th,dth)

[n dof type alp a b thh bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs(); 

% %Hoken's mechanism
% % thf1=0;  % angle with fixed link
% a1=0.025; a2=0.0625; a3=0.125;a31=0.0625; 
% % a12=0.050; a32=0.0625; 
% %Pantograph
% a4=0.200; a5=0.075;  a7=0.150;
% a45=0.050; a67=0.075;
% % a6=0.300; a14=sqrt(.07*.07+.03*.03); 
% % thf4=-atan2(30,70);   %angle of fixed link

%Hoken's mechanism
a1=al(1); a2=al(2);a3=al(3); a31=a3/2;
%Pantograph
a4=al(4); a5=al(5);a7=al(7); 
a45=a(5); a67=a(7);

%Hoken's mechanism
alp1=th(1);
alp2=th(2);
alp3=th(2)+th(3)-2*pi;
% Pantograph
%th4 and th5
alp4=th(4)+pi;
alp5=th(4)+th(5)+pi;
%th6 and th7
alp6=th(4)+th(6)+pi;
alp7=th(4)+th(6)+th(7)+pi;

% Velocities_dtheta
J11=[ a1*sin(alp1)
     -a1*cos(alp1)
     -a1*sin(alp1)
      a1*cos(alp1)
     -a1*sin(alp1)
      a1*cos(alp1)];
J121= [-a2*sin(alp2)-a31*sin(alp3)
        a2*cos(alp2)+a31*cos(alp3)
         a3*sin(alp3)
        -a3*cos(alp3)
         a3*sin(alp3)
        -a3*cos(alp3)];
J122= [-a31*sin(alp3)
        a31*cos(alp3)
        a3*sin(alp3)
       -a3*cos(alp3)
        a3*sin(alp3)
       -a3*cos(alp3)];    
J123= [0
       0
      -a45*sin(alp4)-a5*sin(alp5)
       a45*cos(alp4)+a5*cos(alp5)
      -a4*sin(alp4)-a67*sin(alp6)-a7*sin(alp7)
       a4*cos(alp4)+a67*cos(alp6)+a7*cos(alp7)]; 
J124= [0
       0
      -a5*sin(alp5)
       a5*cos(alp5)
       0
       0];
J125= [0
       0
       0
       0
      -a67*sin(alp6)-a7*sin(alp7)
       a67*cos(alp6)+a7*cos(alp7)];  
J126= [0
       0
       0
       0
      -a7*sin(alp7)
       a7*cos(alp7)];
J12=[J121 J122 J123 J124 J125 J126];
J=[J11 J12];
% Acceleration_ddtheta 
dalp1=dth(1);
dalp2=dth(2);
dalp3=dth(2)+dth(3);
dalp4=dth(4);
dalp5=dth(4)+dth(5);
dalp6=dth(4)+dth(6);
dalp7=dth(4)+dth(6)+dth(7);
dJ11=[a1*cos(alp1)*dalp1
      a1*sin(alp1)*dalp1
     -a1*cos(alp1)*dalp1
     -a1*sin(alp1)*dalp1
     -a1*cos(alp1)*dalp1
     -a1*sin(alp1)*dalp1];
dJ121= [-a2*cos(alp2)*dalp2-a31*cos(alp3)*dalp3
        -a2*sin(alp2)*dalp2-a31*sin(alp3)*dalp3
         a3*cos(alp3)*dalp3
         a3*sin(alp3)*dalp3
         a3*cos(alp3)*dalp3
         a3*sin(alp3)*dalp3];
dJ122= [-a31*cos(alp3)*dalp3
        -a31*sin(alp3)*dalp3
         a3*cos(alp3)*dalp3
         a3*sin(alp3)*dalp3
         a3*cos(alp3)*dalp3
         a3*sin(alp3)*dalp3];    
dJ123= [0
        0
       -a45*cos(alp4)*dalp4-a5*cos(alp5)*dalp5
       -a45*sin(alp4)*dalp4-a5*sin(alp5)*dalp5
       -a4*cos(alp4)*dalp4-a67*cos(alp6)*dalp6-a7*cos(alp7)*dalp7
       -a4*sin(alp4)*dalp4-a67*sin(alp6)*dalp6-a7*sin(alp7)*dalp7];    
dJ124= [0
        0
       -a5*cos(alp5)*dalp5
       -a5*sin(alp5)*dalp5
        0
        0];
dJ125= [0
        0
        0
        0
       -a67*cos(alp6)*dalp6-a7*cos(alp7)*dalp7
       -a67*sin(alp6)*dalp6-a7*sin(alp7)*dalp7];   
dJ126= [0
        0
        0
        0
       -a7*cos(alp7)*dalp7
       -a7*sin(alp7)*dalp7];
dJ12=[dJ121 dJ122 dJ123 dJ124 dJ125 dJ126];
dJ=[dJ11 dJ12];