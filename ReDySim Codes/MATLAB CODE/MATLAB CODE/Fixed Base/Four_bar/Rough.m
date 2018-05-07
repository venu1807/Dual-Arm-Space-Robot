clc;
clear all;

% Link lengths
l1=1%0.05; %crank
l2=2%0.13; %output link 
l3=sqrt(10)%0.1; %connecting link
l0=3%0.15;%fixed base


th1=pi/2;
th2=pi/2;
th3=100*pi/180;


J =[l1*sin(th1), - l3*sin(th2 + th3) - l2*sin(th2),              -l3*sin(th2 + th3)
-l1*cos(th1),   l3*cos(th2 + th3) + l2*cos(th2), l3*cos(th2 + th3) ]

J1=J(:,1)
J2=J(:,2:3)

y(7:8)=(pinv(J2)*J1)*[1]
