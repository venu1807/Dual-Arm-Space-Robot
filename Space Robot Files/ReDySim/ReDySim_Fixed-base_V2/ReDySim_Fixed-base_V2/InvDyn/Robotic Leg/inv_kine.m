function [th dth ddth J]=inv_kine(th1, dth1, ddth1)
[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al Tp steps ]=inputs(); 

%Hoken's mechanism
% a1=0.025; a2=0.0625; a3=0.125;
% a32=0.0625; a31=0.0625; 
% %Pantograph
% a4=0.200; a5=0.075; a6=0.300; a7=0.150;

thf1=0;  % angle with fixed link
thf4=-atan2(30,70);   %angle of fixed link
a12=0.050; % lenght of fixed link 1
a14=sqrt(.070*.070+.030*.030); % lenght of fixed link 2

% a45=0.050; a67=0.075;


%Hoken's mechanism
a1=al(1); a2=al(2);a3=al(3); a31=a3/2;
%Pantograph
a4=al(4); a5=al(5);a7=al(7); 
a45=a(5); a67=a(7);


% dth(1)=trj(1);
% ddth(1)=trj(2);
% th(1)=trj(3);
dth(1)=dth1;
ddth(1)=ddth1;
th(1)=th1;


% FINDING THE ALPHA FOR SCRAPPING MECHANISM USING LOOP CLOSURE EQUATION
%Hoken's mechanism
alp1=th(1);
p1=a1*cos(alp1)-a12*cos(thf1);
q1=a1*sin(alp1)-a12*sin(thf1);
x1=(q1/a1);
y1=(p1/a1);
z11=(p1*p1+q1*q1+a31*a31-a2*a2)/(2*a31*a1);
alp3=2*atan2(x1-sqrt(x1*x1+y1*y1-z11*z11),y1+z11);
z12=(p1*p1+q1*q1+a2*a2-a31*a31)/(2*a2*a1);
alp2=2*atan2(x1+sqrt(x1*x1+y1*y1-z12*z12),y1+z12);
th(2)=alp2;
th(3)=(2*pi+alp3)-th(2);

% Pantograph
%th4 and th5
p2=a14*cos(thf4)-a1*cos(alp1)+a3*cos(alp3);
q2=a14*sin(thf4)-a1*sin(alp1)+a3*sin(alp3);
x2=(q2/a1);
y2=(p2/a1);
z21=(p2*p2+q2*q2+a45*a45-a5*a5)/(2*a45*a1);
alp4=2*atan2(x2+sqrt(x2*x2+y2*y2-z21*z21),y2+z21);
th(4)=(alp4-pi);
z22=(p2*p2+q2*q2+a5*a5-a45*a45)/(2*a5*a1);
alp5=2*atan2(x2-sqrt(x2*x2+y2*y2-z22*z22),y2+z22);
th(5)=(alp5-pi)-th(4);

%th6 and th7
p3=a14*cos(thf4)-a1*cos(alp1)+a3*cos(alp3)-a4*cos(alp4);
q3=a14*sin(thf4)-a1*sin(alp1)+a3*sin(alp3)-a4*sin(alp4);
x3=(q3/a1);
y3=(p3/a1);
z31=(p3*p3+q3*q3+a67*a67-a7*a7)/(2*a67*a1);
alp6=2*atan2(x3+sqrt(x3*x3+y3*y3-z31*z31),y3+z31);
th(6)=(alp6-pi)-th(4);
z32=(p3*p3+q3*q3+a7*a7-a67*a67)/(2*a7*a1);
alp7=2*atan2(x3-sqrt(x3*x3+y3*y3-z32*z32),y3+z32);
th(7)=(alp7-pi)-th(4)-th(6);
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
c1=J12\J11;
dthd=-c1*dth(1);
dth=[dth(1)
     dthd];
JJ=[1
   -c1 ];

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
c2=-dJ11*dth(1)-dJ12*dthd-J11*ddth(1);
ddthd=J12\c2;
ddth=[ddth(1)
      ddthd];

end

