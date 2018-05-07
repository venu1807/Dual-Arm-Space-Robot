clc;
clear all;

r=0.5;

Ti=0; Tf=30;

TiTf1=Ti:.05:Tf

yy0=[0;0;0; 0.3803; -0.6198; 1.2867;pi/8; pi-0.3803; 0.6198; -1.2867;-pi/8;0;0;0;0;0;0;0;0;0;0;0];

[T1,Y1] = ode45(@rigid_1,TiTf1,yy0);

Tii=Tf; Tff=50;

TiTf2=Tii:.05:Tff

n=length(T1)

[thdotf ttf tbf vef]=Impact_eqns()

yy00=[Y1(n,1:6).';Y1(n,8:11).';0;0;tbf;thdotf(1:3);thdotf(5:8)];

x0=yy00(1); y0=yy00(2); th0=yy00(3); th1=yy00(4); th2=yy00(5); th3=yy00(6); th4=yy00(7); th5=yy00(8); th6=yy00(9); th7=yy00(10);

th8=(th4+th5+th6+th7+pi)-(th1+th2+th3)

l0=1;l1=1;l2=1; l3=1; l4=1;l5=1;l6=1; l7=3*1; lc0=.5*l0;lc1=.5*l1;lc2=.5*l2;lc3=.5*l3; lc4=.5*l4;lc5=.5*l5;lc6=.5*l6; lc7=.5*l7; 
Izz0=83.61; Izz1=1.05; Izz2=1.05; Izz3=1.05; Izz4=1.05; Izz5=1.05; Izz6=1.05; Izz7=3*1.05;


%%End Effector 1

l71=l7/3; l72=l7-l71;

J1=[0 0;0 0]
  
J2 =[ - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - lc0*sin(th0) - l2*sin(th0 + th1 + th2) - l71*sin(th0+th1+th2+th3+th8), - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - l2*sin(th0 + th1 + th2)- l71*sin(th0+th1+th2+th3+th8), - l3*sin(th0 + th1 + th2 + th3) - l2*sin(th0 + th1 + th2)- l71*sin(th0+th1+th2+th3+th8), -l3*sin(th0 + th1 + th2 + th3)- l71*sin(th0+th1+th2+th3+th8), - l71*sin(th0+th1+th2+th3+th8)
   l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + lc0*cos(th0) + l2*cos(th0 + th1 + th2) + l71*cos(th0+th1+th2+th3+th8),   l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + l2*cos(th0 + th1 + th2)+ l71*cos(th0+th1+th2+th3+th8),   l3*cos(th0 + th1 + th2 + th3) + l2*cos(th0 + th1 + th2)+ l71*cos(th0+th1+th2+th3+th8),  l3*cos(th0 + th1 + th2 + th3)+ l71*cos(th0+th1+th2+th3+th8), l71*cos(th0+th1+th2+th3+th8)]

J3 =[ - l6*sin(th0 + th4 + th5 + th6) - l4*sin(th0 + th4) + lc0*sin(th0) - l72*sin(th0 + th4 + th5 + th6 + th7) - l5*sin(th0 + th4 + th5), - l6*sin(th0 + th4 + th5 + th6) - l4*sin(th0 + th4) - l72*sin(th0 + th4 + th5 + th6 + th7) - l5*sin(th0 + th4 + th5), - l6*sin(th0 + th4 + th5 + th6) - l72*sin(th0 + th4 + th5 + th6 + th7) - l5*sin(th0 + th4 + th5), - l6*sin(th0 + th4 + th5 + th6) - l72*sin(th0 + th4 + th5 + th6 + th7), -l72*sin(th0 + th4 + th5 + th6 + th7)
   l6*cos(th0 + th4 + th5 + th6) + l4*cos(th0 + th4) - lc0*cos(th0) + l72*cos(th0 + th4 + th5 + th6 + th7) + l5*cos(th0 + th4 + th5),   l6*cos(th0 + th4 + th5 + th6) + l4*cos(th0 + th4) + l72*cos(th0 + th4 + th5 + th6 + th7) + l5*cos(th0 + th4 + th5),   l6*cos(th0 + th4 + th5 + th6) + l72*cos(th0 + th4 + th5 + th6 + th7) + l5*cos(th0 + th4 + th5),   l6*cos(th0 + th4 + th5 + th6) + l72*cos(th0 + th4 + th5 + th6 + th7),  l72*cos(th0 + th4 + th5 + th6 + th7)]

J(1:2,1:2)=J1;
J(1:2,4:6)=-J2(:,2:4);
J(1:2,11)=-J2(:,5)
J(1:2,7:10)=J3(1:2,2:5);
J(1:2,3)=-J2(:,1)+J3(:,1);

Je1(1,1:4)=ones(1,4)
Je1(1,9)=ones(1,1)

Je1(2:3,1:4)=J2(:,1:4);
Je1(2:3,9)=J2(:,5);

Je1(4,1)=ones(1,1)
Je1(4,5:8)=ones(1,4)

Je1(5:6,1)=J3(:,1)
Je1(5:6,5:8)=J3(:,2:5)


%%End Effector 2

l71=2*l7/3; l72=l7-l71;

J1=[0 0;0 0]
  
J2 =[ - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - lc0*sin(th0) - l2*sin(th0 + th1 + th2) - l71*sin(th0+th1+th2+th3+th8), - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - l2*sin(th0 + th1 + th2)- l71*sin(th0+th1+th2+th3+th8), - l3*sin(th0 + th1 + th2 + th3) - l2*sin(th0 + th1 + th2)- l71*sin(th0+th1+th2+th3+th8), -l3*sin(th0 + th1 + th2 + th3)- l71*sin(th0+th1+th2+th3+th8), - l71*sin(th0+th1+th2+th3+th8)
   l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + lc0*cos(th0) + l2*cos(th0 + th1 + th2) + l71*cos(th0+th1+th2+th3+th8),   l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + l2*cos(th0 + th1 + th2)+ l71*cos(th0+th1+th2+th3+th8),   l3*cos(th0 + th1 + th2 + th3) + l2*cos(th0 + th1 + th2)+ l71*cos(th0+th1+th2+th3+th8),  l3*cos(th0 + th1 + th2 + th3)+ l71*cos(th0+th1+th2+th3+th8), l71*cos(th0+th1+th2+th3+th8)]

J3 =[ - l6*sin(th0 + th4 + th5 + th6) - l4*sin(th0 + th4) + lc0*sin(th0) - l72*sin(th0 + th4 + th5 + th6 + th7) - l5*sin(th0 + th4 + th5), - l6*sin(th0 + th4 + th5 + th6) - l4*sin(th0 + th4) - l72*sin(th0 + th4 + th5 + th6 + th7) - l5*sin(th0 + th4 + th5), - l6*sin(th0 + th4 + th5 + th6) - l72*sin(th0 + th4 + th5 + th6 + th7) - l5*sin(th0 + th4 + th5), - l6*sin(th0 + th4 + th5 + th6) - l72*sin(th0 + th4 + th5 + th6 + th7), -l72*sin(th0 + th4 + th5 + th6 + th7)
   l6*cos(th0 + th4 + th5 + th6) + l4*cos(th0 + th4) - lc0*cos(th0) + l72*cos(th0 + th4 + th5 + th6 + th7) + l5*cos(th0 + th4 + th5),   l6*cos(th0 + th4 + th5 + th6) + l4*cos(th0 + th4) + l72*cos(th0 + th4 + th5 + th6 + th7) + l5*cos(th0 + th4 + th5),   l6*cos(th0 + th4 + th5 + th6) + l72*cos(th0 + th4 + th5 + th6 + th7) + l5*cos(th0 + th4 + th5),   l6*cos(th0 + th4 + th5 + th6) + l72*cos(th0 + th4 + th5 + th6 + th7),  l72*cos(th0 + th4 + th5 + th6 + th7)]

J(1:2,1:2)=J1;
J(1:2,4:6)=-J2(:,2:4);
J(1:2,11)=-J2(:,5)
J(1:2,7:10)=J3(1:2,2:5);
J(1:2,3)=-J2(:,1)+J3(:,1);

Je2(1,1:4)=ones(1,4)
Je2(1,9)=ones(1,1)

Je2(2:3,1:4)=J2(:,1:4);
Je2(2:3,9)=J2(:,5);

Je2(4,1)=ones(1,1)
Je2(4,5:8)=ones(1,4)

Je2(5:6,1)=J3(:,1)
Je2(5:6,5:8)=J3(:,2:5)

Je=[Je1;Je2]

thdot=pinv(Je)*[vef(1:2);vef(3);vef(1:2);vef(3);vef(4:5);vef(6);vef(4:5);vef(6)]

yy00(15:22)=thdot(1:8)

[T2,Y2] = ode45(@rigid_2,TiTf2,yy00);

T=[T1;T2];

Y(1:n,1:22)=Y1;
Y(n+1:length(T),1:6)=Y2(:,1:6);
Y(n+1:length(T),7)=Y2(:,7)+Y2(:,8)+Y2(:,9)+Y2(:,10)+pi*ones(length(T)-n,1)-(Y2(:,4)+Y2(:,5)+Y2(:,6));         %th8=(th4+th5+th6+th7+pi)-(th1+th2+th3)
Y(n+1:length(T),8:11)=Y2(:,7:10);

Y(n+1:length(T),12:17)=Y2(:,13:18);
Y(n+1:length(T),18)=Y2(:,19)+Y2(:,20)+Y2(:,21)+Y2(:,22)-(Y2(:,16)+Y2(:,17)+Y2(:,18));         %th8=(th4+th5+th6+th7+pi)-(th1+th2+th3)
Y(n+1:length(T),19:22)=Y2(:,19:22);

set(0,'DefaultLineLineWidth',1.5)
 
 fh1=figure('Name','Motion Parameters','NumberTitle','off');
 set(fh1, 'color', 'white'); % sets the color to white 
%  
%  subplot(2,2,1)
%  plot(T,Y(:,1),'-',T,Y(:,2))
%  legend('x0', 'y0')
%  xlabel('Time')
%  ylabel('Base Displacement')
%  
% %figure(2)
 subplot(2,1,1)
 plot(T,Y(:,4),'-',T,Y(:,5),'--',T,Y(:,6),'-',T,Y(:,7),'--')%,T,Y(:,8),'-',T,Y(:,9),'-')
 legend('th1', 'th2','th3', 'th4')
 xlabel('Time')
 ylabel('Joint Angles of 1st Arm')
% 
% %figure(3)
 subplot(2,1,2)
 plot(T,Y(:,8),'-',T,Y(:,9),'--',T,Y(:,10),'-',T,Y(:,11),'--')
 legend('th5','th6','th7','th8')
 xlabel('Time')
 ylabel('Joint Angles of 2nd Arm')
% 
% %figure(4)
% subplot(2,2,4)
% plot(T,Y(:,12),'-',T,Y(:,13),'-',T,Y(:,14),'-',T,Y(:,15),'-',T,Y(:,16),'-',T,Y(:,17),'-',T,Y(:,18),'-')
% legend('dtho','dth1','dth2','dth3','dth4','dth5','dth6')
% xlabel('Time')
% ylabel('Joint velocity')

%Animation

m0=500;m1=10;m2=10;m3=10;m4=10;m5=10;m6=10;m11=10; m12=10; m13=10; m14=10; m15=10; m16=10;
l0=1;l1=1;l2=1;l3=1;l4=1;l5=1;l6=1;l11=1; l12=1; l13=1; l14=1; l15=1; l16=1 ;
lc0=.5*l0;lc1=.5*l1;lc2=.5*l2;lc3=.5*l3; lc4=.5*l4;lc5=.5*l5;lc6=.5*l6;lc11=.5*l11;lc12=.5*l12;lc13=.5*l13; lc14=.5*l14;lc15=.5*l15;lc16=.5*l16;  
Izz0=83.61; Izz1=1.05; Izz2=1.05; Izz3=1.05;Izz4=1.05; Izz5=1.05; Izz6=1.05;Izz11=1.05; Izz12=1.05; Izz13=1.05;Izz14=1.05; Izz15=1.05; Izz16=1.05;


fh2=figure('Name','Animation','NumberTitle','off');
set(fh2, 'color', 'white'); % sets the color to white 


for i=1:length(T)
    t=T(i);
if i<=n

x00=0; y00=0;
x01=Y(i,1); y01=Y(i,2);
x02=x01+lc0*cos(Y(i,3)); y02=y01+lc0*sin(Y(i,3));
x03=x02+lc0*cos(Y(i,3)+(pi/2)); y03=y02+lc0*sin(Y(i,3)+(pi/2));
x04=x03+l0*cos(Y(i,3)+(pi)); y04=y03+l0*sin(Y(i,3)+(pi));
x05=x04+l0*cos(Y(i,3)+(3*pi/2)); y05=y04+l0*sin(Y(i,3)+(3*pi/2));
x06=x05+l0*cos(Y(i,3)+(2*pi)); y06=y05+l0*sin(Y(i,3)+(2*pi));
x07=x02;y07=y02;
x11=x07+l1*cos(Y(i,3)+Y(i,4)); y11=y07+l1*sin(Y(i,3)+Y(i,4));
x12=x11+l2*cos(Y(i,3)+Y(i,4)+Y(i,5)); y12=y11+l2*sin(Y(i,3)+Y(i,4)+Y(i,5));
x13=x12+l3*cos(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)); y13=y12+l3*sin(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6));
x14=x13+l4*cos(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)+Y(i,7)); y14=y13+l4*sin(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)+Y(i,7));

x21=Y(i,1); y21=Y(i,2);
x22=x21-lc0*cos(Y(i,3)); y22=y21-lc0*sin(Y(i,3));
x23=x22+l11*cos(Y(i,3)+Y(i,8)); y23=y22+l11*sin(Y(i,3)+Y(i,8));
x24=x23+l12*cos(Y(i,3)+Y(i,8)+Y(i,9)); y24=y23+l12*sin(Y(i,3)+Y(i,8)+Y(i,9));
x25=x24+l13*cos(Y(i,3)+Y(i,8)+Y(i,9)+Y(i,10)); y25=y24+l13*sin(Y(i,3)+Y(i,8)+Y(i,9)+Y(i,10));
x26=x25+l14*cos(Y(i,3)+Y(i,8)+Y(i,9)+Y(i,10)+Y(i,11)); y26=y25+l14*sin(Y(i,3)+Y(i,8)+Y(i,9)+Y(i,10)+Y(i,11));

XX=[x02 x03 x04 x05 x06 x07 x11 x12 x13 x14 x13 x12 x11 x07 x03 x04 x21 x22 x23 x24 x25 x26];
YY=[y02 y03 y04 y05 y06 y07 y11 y12 y13 y14 y13 y12 y11 y07 y03 y04 y21 y22 y23 y24 y25 y26];

%figure(5);



fill([x02 x03 x04 x05 x06 x07],[y02 y03 y04 y05 y06 y07],'r')
hold on

plot(XX,YY,'linewidth',4);
hold on


fill([x02 x03 x04 x05 x06 x07],[y02 y03 y04 y05 y06 y07],'r')
hold on


circle = rsmak('circle');
%fnplt(circle), axis square
ell = fncmb(circle,[r 0;0 r]);

s=pi*t/20;

target=fncmb(fncmb(ell, [cos(s) -sin(s);sin(s) cos(s)]), [x01;y01+sqrt(3)] );

hold on, fnplt(target), hold off

hold off
xmin=-1*(l0+l1+l2+l3); xmax=1*(l0+l1+l2+l3); ymin=-1*(l0+l1+l2+l3); ymax=1*(l0+l1+l2+l3);
axis([xmin xmax ymin ymax])
title(['Current time t:',num2str(t)]);
grid on
pause(0.00005)

else
    
     l7=2*(1+r);
    
x00=0; y00=0;
x01=Y(i,1); y01=Y(i,2);
x02=x01+lc0*cos(Y(i,3)); y02=y01+lc0*sin(Y(i,3));
x03=x02+lc0*cos(Y(i,3)+(pi/2)); y03=y02+lc0*sin(Y(i,3)+(pi/2));
x04=x03+l0*cos(Y(i,3)+(pi)); y04=y03+l0*sin(Y(i,3)+(pi));
x05=x04+l0*cos(Y(i,3)+(3*pi/2)); y05=y04+l0*sin(Y(i,3)+(3*pi/2));
x06=x05+l0*cos(Y(i,3)+(2*pi)); y06=y05+l0*sin(Y(i,3)+(2*pi));
x07=x02;y07=y02;
x08=x07+l1*cos(Y(i,3)+Y(i,4)); y08=y07+l1*sin(Y(i,3)+Y(i,4));
x09=x08+l2*cos(Y(i,3)+Y(i,4)+Y(i,5)); y09=y08+l2*sin(Y(i,3)+Y(i,4)+Y(i,5));
x10=x09+l3*cos(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)); y10=y09+l3*sin(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6));


x11=Y(i,1); y11=Y(i,2);
x12=x11-lc0*cos(Y(i,3)); y12=y11-lc0*sin(Y(i,3));
x13=x12+l4*cos(Y(i,3)+Y(i,8)); y13=y12+l4*sin(Y(i,3)+Y(i,8));
x14=x13+l5*cos(Y(i,3)+Y(i,8)+Y(i,9)); y14=y13+l5*sin(Y(i,3)+Y(i,8)+Y(i,9));
x15=x14+l6*cos(Y(i,3)+Y(i,8)+Y(i,9)+Y(i,10)); y15=y14+l6*sin(Y(i,3)+Y(i,8)+Y(i,9)+Y(i,10));
x16=x15+l7*cos(Y(i,3)+Y(i,8)+Y(i,9)+Y(i,10)+Y(i,11)); y16=y15+l7*sin(Y(i,3)+Y(i,8)+Y(i,9)+Y(i,10)+Y(i,11));

XX=[x02 x03 x04 x05 x06 x07 x08 x09 x10 (2*x10+x15)/3 x10 x09 x08 x07 x03 x04 x12 x13 x14 x15 (2*x15+x10)/3];
YY=[y02 y03 y04 y05 y06 y07 y08 y09 y10 (2*y10+y15)/3 y10 y09 y08 y07 y03 y04 y12 y13 y14 y15 (2*y15+y10)/3];

%figure(5);


plot(XX,YY,'linewidth',4);
hold on

fill([x02 x03 x04 x05 x06 x07],[y02 y03 y04 y05 y06 y07],'r')
hold on

   circle = rsmak('circle');
%fnplt(circle), axis square
ellipse = fncmb(circle,[r 0;0 r]);
Ctx=.5*x15+.5*x16;Cty=.5*y15+.5*y16;
s=atan2((y10-y09),(x10-x09));
target=fncmb(fncmb(ellipse, [cos(s) -sin(s);sin(s) cos(s)]), [Ctx;Cty]);
hold on, fnplt(target), hold off 


%xmin=-1*(l0+l1+l2+l3); xmax=1*(l0+l1+l2+l3); ymin=-1*(l0+l1+l2+l3); ymax=1*(l0+l1+l2+l3);
axis([xmin xmax ymin ymax])
title(['Current time t:',num2str(t)]);
grid on
pause(0.05)
end
end
