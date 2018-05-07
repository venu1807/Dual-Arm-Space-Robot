% ReDySim inv_kine module. This module perform inverse kinematics of the
% 3-RRR parallel robot mechanism only
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi


function [th, dth, ddth, J] = inv_kine(thi, dthi, ddthi)
%Inverse kinematics of 3-RRR planar manipulator
%Dimention of equilateral outer triangle form by the base.
bb=1; hh=bb*sin(pi/3);
%Dimention of equilateral triangle form the end effector.
b=0.4;h=b*sin(pi/3);hc=2/3*h;
%Link lenghts
a1=0.4;b1=0.6;

x0=thi(1); y0=thi(2); alp=thi(3);
dx0=dthi(1); dy0=dthi(2); dalp=dthi(3);
ddx0=ddthi(1); ddy0=ddthi(2); ddalp=ddthi(3);


%Position, velocity and acceleration of the vertices of platform
%Position
x1=x0+hc*cos(7*pi/6+alp);   y1=y0+hc*sin(7*pi/6+alp);
x2=x0+hc*cos(11*pi/6+alp);  y2=y0+hc*sin(11*pi/6+alp);
x3=x0+hc*cos(pi/2+alp);     y3=y0+hc*sin(pi/2+alp);
%Velocity
dx1=dx0-hc*sin(7*pi/6+alp)*dalp;   dy1=dy0+hc*cos(7*pi/6+alp)*dalp;
dx2=dx0-hc*sin(11*pi/6+alp)*dalp;  dy2=dy0+hc*cos(11*pi/6+alp)*dalp;
dx3=dx0-hc*sin(pi/2+alp)*dalp;     dy3=dy0+hc*cos(pi/2+alp)*dalp;
%Aceeleration
ddx1=ddx0-hc*sin(7*pi/6+alp)*ddalp-hc*cos(7*pi/6+alp)*dalp*dalp;      ddy1=ddy0+hc*cos(7*pi/6+alp)*ddalp-hc*sin(7*pi/6+alp)*dalp*dalp;
ddx2=ddx0-hc*sin(11*pi/6+alp)*ddalp-hc*cos(11*pi/6+alp)*dalp*dalp;    ddy2=ddy0+hc*cos(11*pi/6+alp)*ddalp-hc*sin(11*pi/6+alp)*dalp*dalp;
ddx3=ddx0-hc*sin(pi/2+alp)*ddalp-hc*cos(pi/2+alp)*dalp*dalp;          ddy3=ddy0+hc*cos(pi/2+alp)*ddalp-hc*sin(pi/2+alp)*dalp*dalp;

%Loaction of the origins forming outer triangles
ox1=0;oy1=0;ox2=1;oy2=0;ox3=bb/2;oy3=hh;
%leg1
%Joint Position
wx1=-(ox1-x1);wy1=-(oy1-y1);
c2=(wx1*wx1+wy1*wy1-a1*a1-b1*b1)/(2*a1*b1);
s2=-sqrt(1-c2*c2);
th2=atan2(s2,c2);
del1=a1*a1+b1*b1+2*a1*b1*c2;
s1=((a1+b1*c2)*wy1-b1*s2*wx1)/del1;
c1=((a1+b1*c2)*wx1+b1*s2*wy1)/del1;
th1=atan2(s1,c1);
x4=ox1+a1*cos(th1);
y4=oy1+a1*sin(th1);
x5=x4+b1*cos(th1+th2);
y5=y4+b1*sin(th1+th2);
%Joint Velocity
J1=[-a1*sin(th1)-b1*sin(th1+th2) -b1*sin(th1+th2)
    a1*cos(th1)+b1*cos(th1+th2)  b1*cos(th1+th2)];
ve1=[dx1;dy1];
jv1=J1\ve1;
dth1=jv1(1);
dth2=jv1(2);
%Joint Acceleration
dJ1=[-a1*cos(th1)*dth1-b1*cos(th1+th2)*(dth1+dth2) -b1*cos(th1+th2)*(dth1+dth2)
    -a1*sin(th1)*dth1-b1*sin(th1+th2)*(dth1+dth2) -b1*sin(th1+th2)*(dth1+dth2)];
ae1=[ddx1;ddy1];
ja1=J1\(ae1-dJ1*jv1);
ddth1=ja1(1);
ddth2=ja1(2);

%leg2
%Joint Position
wx2=-(ox2-x2);wy2=-(oy2-y2);
c4=(wx2*wx2+wy2*wy2-a1*a1-b1*b1)/(2*a1*b1);
s4=-sqrt(1-c4*c4);
th5=atan2(s4,c4);
del2=a1*a1+b1*b1+2*a1*b1*c4;
s3=((a1+b1*c4)*wy2-b1*s4*wx2)/del2;
c3=((a1+b1*c4)*wx2+b1*s4*wy2)/del2;
th4=atan2(s3,c3);
x6=ox2+a1*cos(th4);
y6=oy2+a1*sin(th4);
x7=x6+b1*cos(th4+th5);
y7=y6+b1*sin(th4+th5);
%Joint Velocity
J2=[-a1*sin(th4)-b1*sin(th4+th5) -b1*sin(th4+th5)
    a1*cos(th4)+b1*cos(th4+th5)  b1*cos(th4+th5)];
ve2=[dx2;dy2];
jv2=J2\ve2;
dth4=jv2(1);
dth5=jv2(2);
%Joint Acceleration
dJ2=[-a1*cos(th4)*dth4-b1*cos(th4+th5)*(dth4+dth5) -b1*cos(th4+th5)*(dth4+dth5)
    -a1*sin(th4)*dth4-b1*sin(th4+th5)*(dth4+dth5) -b1*sin(th4+th5)*(dth4+dth5)];
ae2=[ddx2;ddy2];
ja2=J2\(ae2-dJ2*jv2);
ddth4=ja2(1);
ddth5=ja2(2);

%leg3
%Joint Position
wx3=-(ox3-x3);wy3=-(oy3-y3);
c6=(wx3*wx3+wy3*wy3-a1*a1-b1*b1)/(2*a1*b1);
s6=-sqrt(1-c6*c6);
th7=atan2(s6,c6);
del3=a1*a1+b1*b1+2*a1*b1*c6;
s5=((a1+b1*c6)*wy3-b1*s6*wx3)/del3;
c5=((a1+b1*c6)*wx3+b1*s6*wy3)/del3;
th6=atan2(s5,c5);
x8=ox3+a1*cos(th6);
y8=oy3+a1*sin(th6);
x9=x8+b1*cos(th6+th7);
y9=y8+b1*sin(th6+th7);
%Joint Velocity
J3=[-a1*sin(th6)-b1*sin(th6+th7) -b1*sin(th6+th7)
    a1*cos(th6)+b1*cos(th6+th7)  b1*cos(th6+th7)];
ve3=[dx3;dy3];
jv3=J3\ve3;
dth6=jv3(1);
dth7=jv3(2);
%Joint Acceleration
dJ3=[-a1*cos(th6)*dth6-b1*cos(th6+th7)*(dth6+dth7) -b1*cos(th6+th7)*(dth6+dth7)
    -a1*sin(th6)*dth6-b1*sin(th6+th7)*(dth6+dth7) -b1*sin(th6+th7)*(dth6+dth7)];
ae3=[ddx3;ddy3];
ja3=J3\(ae3-dJ3*jv3);
ddth6=ja3(1);
ddth7=ja3(2);

%Base realtive motoins
th3=(alp-th1-th2);
dth3=(dalp-dth1-dth2);
ddth3=(ddalp-ddth1-ddth2);

th5d=pi+th4+th5-th1-th2-th3;
dth5d=dth4+dth5-dth1-dth2-dth3;
ddth5d=ddth4+ddth5-ddth1-ddth2-ddth3;
th7d=pi+th6+th7-th1-th2-th3;
dth7d=dth6+dth7-dth1-dth2-dth3;
ddth7d=ddth6+ddth7-ddth1-ddth2-ddth3;

th=[th1; th2; th3; th4; th5; th6; th7];
dth=[dth1; dth2; dth3; dth4; dth5; dth6; dth7];
ddth=[ddth1; ddth2; ddth3; ddth4; ddth5; ddth6; ddth7];

% %Plotting the configuration
% xxo=[ox1,ox2,ox3,ox1];
% yyo=[oy1,oy2,oy3,oy1];
% xxe=[x0,x1,x2,x3,x1];
% yye=[y0,y1,y2,y3,y1];
% xx1=[x1,x5,x4,ox1];
% yy1=[y1,y5,y4,oy1];
% xx2=[x2,x7,x6,ox2];
% yy2=[y2,y7,y6,oy2];
% xx3=[x3,x9,x8,ox3];
% yy3=[y3,y9,y8,oy3];
% set(0,'DefaultLineLineWidth',1.5)
% fh1=figure(1);
% set(fh1, 'color', 'white'); % sets the color to white
% plot(xxo,yyo,xxe,yye,xx1,yy1,xx2,yy2,xx3,yy3)
% % title(t,'fontweight','bold','fontsize',12);
% axis([-0.5 1.5 -0.5 1.5])


% 3-DOF
% Link lengths
% Subsystem I
a1=0.4; b1=0.6; d1=0.4;
% Subsystem II
a2=0.4; b2=0.6;
% Subsystem III
a3=0.4; b3=0.6;
d3=0.4;


alp1 = th(1);
alp4 = th(1) + th(2);
alp7 = th(1) + th(2) + th(3);

alp2 = th(4);
alp5 = th(4) + th(5);

alp3 = th(6);
alp6 = th(6) + th(7);



%----------------%
J_1 = [-a1*sin(alp1)-b1*sin(alp4)-d1*sin(alp7)  -b1*sin(alp4)-d1*sin(alp7) -d1*sin(alp7)
        a1*cos(alp1)+b1*cos(alp4)+d1*cos(alp7)   b1*cos(alp4)+d1*cos(alp7)  d1*cos(alp7)];

J_2 = [ b2*sin(alp5)+a2*sin(alp2)  b2*sin(alp5)
       -b2*cos(alp5)-a2*cos(alp2) -b2*cos(alp5)];

J_3 = zeros(2,2);

J_4 = [-a1*sin(alp1)-b1*sin(alp4)-d3*sin(alp7+pi/3)  -b1*sin(alp4)-d3*sin(alp7+pi/3) -d3*sin(alp7+pi/3)
        a1*cos(alp1)+b1*cos(alp4)+d3*cos(alp7+pi/3)   b1*cos(alp4)+d3*cos(alp7+pi/3)  d3*cos(alp7+pi/3)];

J_5 = zeros(2,2);

J_6 = [ b3*sin(alp6)+a3*sin(alp3)  b3*sin(alp6)
       -b3*cos(alp6)-a3*cos(alp3) -b3*cos(alp6)];
J_mat = [J_1    J_2     J_3
         J_4    J_5     J_6];
     
J = J_mat;