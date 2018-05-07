clc;
clear all;

r=0.5;

Ti=0; Tf=40;

TiTf1=Ti:.1:Tf

yy0=[0;0;0; 0.3803; -0.6198; 1.2867;0;0; pi-0.3803; 0.6198; -1.2867;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0];

%yy0=[0;0;0; 0.698;-1.571; 1.047; 2.444 ;1.571; -1.047;0;0;0;0;0;0;0;0;0];

[T1,Y1] = ode45(@rigid_1,TiTf1,yy0);

 Tii=Tf; Tff=50;
 
 TiTf2=Tii:.1:Tff

 n=length(T1)
 
 [thdotf ttf tbf vef]=Impact_eqns()
 
 yy00=[Y1(n,1:12).';0;0;tbf;thdotf(1:9)];
 
 x0=yy00(1); y0=yy00(2); th0=yy00(3); th1=yy00(4); th2=yy00(5); th3=yy00(6); th4=yy00(7); th5=yy00(8); th6=yy00(9); th7=yy00(10);th8=yy00(11); th9=yy00(12);
 
th10=(th1+th2+th3+th4+th5)-(th6+th7+th8+th9+pi)
 

m0=500;m1=10;m2=10;m3=10;m4=10;m5=3*10;m6=10; m7=10; m8=10; m9=10; l0=1;l1=1;l2=1; l3=1;  l4=1;l5=3*1;l6=1; l7=1;l8=1; l9=1; lc0=.5*l0;lc1=.5*l1;lc2=.5*l2;lc3=.5*l3; lc4=.5*l4;lc5=.5*l5;lc6=.5*l6; lc7=.5*l7; lc8=.5*l8; lc9=.5*l9; 
Izz0=83.61; Izz1=1.05; Izz2=1.05; Izz3=1.05; Izz4=1.05; Izz5=3*1.05; Izz6=1.05; Izz7=3*1.05;Izz8=1.05; Izz9=1.05;

 l51=l5/3; l52=l5-l51;
 
 
 J1=[0 0;0 0]
   
 J2 =[ - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - lc0*sin(th0) - l4*sin(th0 + th1 + th2 + th3 + th4) - l2*sin(th0 + th1 + th2), - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - l4*sin(th0 + th1 + th2 + th3 + th4) - l2*sin(th0 + th1 + th2), - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l3*sin(th0 + th1 + th2 + th3) - l4*sin(th0 + th1 + th2 + th3 + th4) - l2*sin(th0 + th1 + th2), - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l3*sin(th0 + th1 + th2 + th3) - l4*sin(th0 + th1 + th2 + th3 + th4), - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l4*sin(th0 + th1 + th2 + th3 + th4), -l51*sin(th0 + th1 + th2 + th3 + th4 + th5)
   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + lc0*cos(th0) + l4*cos(th0 + th1 + th2 + th3 + th4) + l2*cos(th0 + th1 + th2),   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + l4*cos(th0 + th1 + th2 + th3 + th4) + l2*cos(th0 + th1 + th2),   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l3*cos(th0 + th1 + th2 + th3) + l4*cos(th0 + th1 + th2 + th3 + th4) + l2*cos(th0 + th1 + th2),   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l3*cos(th0 + th1 + th2 + th3) + l4*cos(th0 + th1 + th2 + th3 + th4),   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l4*cos(th0 + th1 + th2 + th3 + th4),  l51*cos(th0 + th1 + th2 + th3 + th4 + th5)]
 
 
J3=[ lc0*sin(th0) - l8*sin(th0 + th6 + th7 + th8) - l6*sin(th0 + th6) - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l9*sin(th0 + th6 + th7 + th8 + th9) - l7*sin(th0 + th6 + th7), - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l8*sin(th0 + th6 + th7 + th8) - l6*sin(th0 + th6) - l9*sin(th0 + th6 + th7 + th8 + th9) - l7*sin(th0 + th6 + th7), - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l8*sin(th0 + th6 + th7 + th8) - l9*sin(th0 + th6 + th7 + th8 + th9) - l7*sin(th0 + th6 + th7), - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l8*sin(th0 + th6 + th7 + th8) - l9*sin(th0 + th6 + th7 + th8 + th9), - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l9*sin(th0 + th6 + th7 + th8 + th9), -l52*sin(th0 + th10 + th6 + th7 + th8 + th9)
 l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l8*cos(th0 + th6 + th7 + th8) + l6*cos(th0 + th6) - lc0*cos(th0) + l9*cos(th0 + th6 + th7 + th8 + th9) + l7*cos(th0 + th6 + th7),   l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l8*cos(th0 + th6 + th7 + th8) + l6*cos(th0 + th6) + l9*cos(th0 + th6 + th7 + th8 + th9) + l7*cos(th0 + th6 + th7),   l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l8*cos(th0 + th6 + th7 + th8) + l9*cos(th0 + th6 + th7 + th8 + th9) + l7*cos(th0 + th6 + th7),   l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l8*cos(th0 + th6 + th7 + th8) + l9*cos(th0 + th6 + th7 + th8 + th9),   l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l9*cos(th0 + th6 + th7 + th8 + th9),  l52*cos(th0 + th10 + th6 + th7 + th8 + th9)]
 
 J(1:2,1:2)=J1;
 J(1:2,4:8)=-J2(:,2:6);
 J(1:2,9:13)=J3(1:2,2:6);
 J(1:2,3)=-J2(:,1)+J3(:,1);
 

Je1(2:3,1:6)=J2(:,1:6);
 Je1(1,1:6)=ones(1,6);

 Je1(4,1)=ones(1,1)
 Je1(4,7:11)=ones(1,5)
 Je1(5:6,1)=J3(:,1)
 Je1(5:6,7:11)=J3(:,2:6)
% 
 l51=2*l5/3; l52=l5-l51;

 J1=[0 0;0 0]
   
 J2 =[ - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - lc0*sin(th0) - l4*sin(th0 + th1 + th2 + th3 + th4) - l2*sin(th0 + th1 + th2), - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l3*sin(th0 + th1 + th2 + th3) - l1*sin(th0 + th1) - l4*sin(th0 + th1 + th2 + th3 + th4) - l2*sin(th0 + th1 + th2), - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l3*sin(th0 + th1 + th2 + th3) - l4*sin(th0 + th1 + th2 + th3 + th4) - l2*sin(th0 + th1 + th2), - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l3*sin(th0 + th1 + th2 + th3) - l4*sin(th0 + th1 + th2 + th3 + th4), - l51*sin(th0 + th1 + th2 + th3 + th4 + th5) - l4*sin(th0 + th1 + th2 + th3 + th4), -l51*sin(th0 + th1 + th2 + th3 + th4 + th5)
   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + lc0*cos(th0) + l4*cos(th0 + th1 + th2 + th3 + th4) + l2*cos(th0 + th1 + th2),   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l3*cos(th0 + th1 + th2 + th3) + l1*cos(th0 + th1) + l4*cos(th0 + th1 + th2 + th3 + th4) + l2*cos(th0 + th1 + th2),   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l3*cos(th0 + th1 + th2 + th3) + l4*cos(th0 + th1 + th2 + th3 + th4) + l2*cos(th0 + th1 + th2),   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l3*cos(th0 + th1 + th2 + th3) + l4*cos(th0 + th1 + th2 + th3 + th4),   l51*cos(th0 + th1 + th2 + th3 + th4 + th5) + l4*cos(th0 + th1 + th2 + th3 + th4),  l51*cos(th0 + th1 + th2 + th3 + th4 + th5)]
 
 
J3=[ lc0*sin(th0) - l8*sin(th0 + th6 + th7 + th8) - l6*sin(th0 + th6) - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l9*sin(th0 + th6 + th7 + th8 + th9) - l7*sin(th0 + th6 + th7), - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l8*sin(th0 + th6 + th7 + th8) - l6*sin(th0 + th6) - l9*sin(th0 + th6 + th7 + th8 + th9) - l7*sin(th0 + th6 + th7), - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l8*sin(th0 + th6 + th7 + th8) - l9*sin(th0 + th6 + th7 + th8 + th9) - l7*sin(th0 + th6 + th7), - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l8*sin(th0 + th6 + th7 + th8) - l9*sin(th0 + th6 + th7 + th8 + th9), - l52*sin(th0 + th10 + th6 + th7 + th8 + th9) - l9*sin(th0 + th6 + th7 + th8 + th9), -l52*sin(th0 + th10 + th6 + th7 + th8 + th9)
 l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l8*cos(th0 + th6 + th7 + th8) + l6*cos(th0 + th6) - lc0*cos(th0) + l9*cos(th0 + th6 + th7 + th8 + th9) + l7*cos(th0 + th6 + th7),   l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l8*cos(th0 + th6 + th7 + th8) + l6*cos(th0 + th6) + l9*cos(th0 + th6 + th7 + th8 + th9) + l7*cos(th0 + th6 + th7),   l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l8*cos(th0 + th6 + th7 + th8) + l9*cos(th0 + th6 + th7 + th8 + th9) + l7*cos(th0 + th6 + th7),   l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l8*cos(th0 + th6 + th7 + th8) + l9*cos(th0 + th6 + th7 + th8 + th9),   l52*cos(th0 + th10 + th6 + th7 + th8 + th9) + l9*cos(th0 + th6 + th7 + th8 + th9),  l52*cos(th0 + th10 + th6 + th7 + th8 + th9)]
 
 J(1:2,1:2)=J1;
 J(1:2,4:8)=-J2(:,2:6);
 J(1:2,9:13)=J3(1:2,2:6);
 J(1:2,3)=-J2(:,1)+J3(:,1);
 

Je2(1,1:6)=ones(1,6);
Je2(2:3,1:6)=J2(:,1:6);

Je2(4,1)=ones(1,1)
Je2(4,7:11)=ones(1,5)
Je2(5:6,1)=J3(:,1)
Je2(5:6,7:11)=J3(:,2:6)

Jee=Je1-Je2
 Je=[Je1;Je2(3,:);Je2(6,:)]

% Je(13,:)=[Je2(3,1)-Je2(6,1) Je2(3,2:4) -Je2(6,5:8) Je2(3,9)]
% 
 thdot=pinv(Je)*[   0.0247 
     0.0023
    0.0377
     0.0247 
     0.0023
    0.0377
   -0.0371
   -0.0371]
% 
 yy00(17:26)=thdot(1:10)
 
 [T2,Y2] = ode45(@rigid_2,TiTf2,yy00);


n=length(T1)

T=[T1;T2];

Y(1:n,1:26)=Y1;
Y(n+1:length(T),1:12)=Y2(:,1:12);
Y(n+1:length(T),13:22)=Y2(:,13:22);
set(0,'DefaultLineLineWidth',1.5)
 
% fh1=figure('Name','Motion Parameters','NumberTitle','off');
% set(fh1, 'color', 'white'); % sets the color to white 
% 
% subplot(2,2,1)
% plot(T,Y(:,1),'-',T,Y(:,2))
% legend('x0', 'y0')
% xlabel('Time')
% ylabel('Base Displacement')
% 
% %figure(2)
% subplot(2,2,2)
% plot(T,Y(:,3),'-',T,Y(:,4),'-',T,Y(:,5),'-',T,Y(:,6),T,Y(:,7),'-',T,Y(:,8),'-',T,Y(:,9),'-')
% legend('th0', 'th1', 'th2','th3', 'th4', 'th5','th6')
% xlabel('Time')
% ylabel('Joint Angle')
% 
% %figure(3)
% subplot(2,2,3)
% plot(T,Y(:,10),'-',T,Y(:,11))
% legend('dxo','dyo')
% xlabel('Time')
% ylabel('Base velocity')
% 
% %figure(4)
% subplot(2,2,4)
% plot(T,Y(:,12),'-',T,Y(:,13),'-',T,Y(:,14),'-',T,Y(:,15),'-',T,Y(:,16),'-',T,Y(:,17),'-',T,Y(:,18),'-')
% legend('dtho','dth1','dth2','dth3','dth4','dth5','dth6')
% xlabel('Time')
% ylabel('Joint velocity')

%Animation

m0=500;m1=10;m2=10;m3=10;m4=10;m5=10;m6=10;m11=10; m12=10; m13=10; m14=10; m15=10; m16=10;
l0=1;l1=1;l2=1;l3=1;l4=1;l5=1;l6=1; l7=1;l8=1; l9=1;l11=1; l12=1; l13=1; l14=1; l15=1; l16=1 ;
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
x15=x14+l5*cos(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)+Y(i,7)+Y(i,8)); y15=y14+l5*sin(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)+Y(i,7)+Y(i,8));

x21=Y(i,1); y21=Y(i,2);
x22=x21-lc0*cos(Y(i,3)); y22=y21-lc0*sin(Y(i,3));
x23=x22+l11*cos(Y(i,3)+Y(i,9)); y23=y22+l11*sin(Y(i,3)+Y(i,9));
x24=x23+l12*cos(Y(i,3)+Y(i,9)+Y(i,10)); y24=y23+l12*sin(Y(i,3)+Y(i,9)+Y(i,10));
x25=x24+l13*cos(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11)); y25=y24+l13*sin(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11));
x26=x25+l14*cos(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11)+Y(i,12)); y26=y25+l14*sin(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11)+Y(i,12));
x27=x26+l15*cos(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11)+Y(i,12)+Y(i,13)); y27=y26+l15*sin(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11)+Y(i,12)+Y(i,13));


XX=[x02 x03 x04 x05 x06 x07 x11 x12 x13 x14 x15 x14 x13 x12 x11 x07 x03 x04 x21 x22 x23 x24 x25 x26 x27];
YY=[y02 y03 y04 y05 y06 y07 y11 y12 y13 y14 y15 y14 y13 y12 y11 y07 y03 y04 y21 y22 y23 y24 y25 y26 y27];

%figure(5);

plot(XX,YY,'linewidth',4);
hold on


fill([x02 x03 x04 x05 x06 x07],[y02 y03 y04 y05 y06 y07],'r')
hold on


circle = rsmak('circle');
%fnplt(circle), axis square
ell = fncmb(circle,[r 0;0 r]);

s=pi*t/20;

target=fncmb(fncmb(ell, [cos(s) -sin(s);sin(s) cos(s)]), [x01;y01+1+sqrt(2)] );

hold on, fnplt(target), hold off

hold off
xmin=-1*(l0+l1+l2+l3); xmax=1*(l0+l1+l2+l3); ymin=-1*(l0+l1+l2+l3); ymax=1*(l0+l1+l2+l3);
axis([xmin xmax ymin ymax])
title(['Current time t:',num2str(t)]);
grid on
pause(0.00005)

else
    
     l5=2*(1+r);
    
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
x11=x10+l4*cos(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)+Y(i,7)); y11=y10+l4*sin(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)+Y(i,7));
x12=x11+l5*cos(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)+Y(i,7)+Y(i,8)); y12=y11+l5*sin(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)+Y(i,7)+Y(i,8));

x13=Y(i,1); y13=Y(i,2);
x14=x13-lc0*cos(Y(i,3)); y14=y13-lc0*sin(Y(i,3));
x15=x14+l6*cos(Y(i,3)+Y(i,9)); y15=y14+l6*sin(Y(i,3)+Y(i,9));
x16=x15+l7*cos(Y(i,3)+Y(i,9)+Y(i,10)); y16=y15+l7*sin(Y(i,3)+Y(i,9)+Y(i,10));
x17=x16+l8*cos(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11)); y17=y16+l8*sin(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11));
x18=x17+l9*cos(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11)+Y(i,12)); y18=y17+l9*sin(Y(i,3)+Y(i,9)+Y(i,10)+Y(i,11)+Y(i,12));

XX=[x02 x03 x04 x05 x06 x07 x08 x09 x10 x11 (2*x11+x12)/3 x11 x10 x09 x08 x07 x03 x04 x14 x15 x16 x17 x18 (2*x18+x11)/3];
YY=[y02 y03 y04 y05 y06 y07 y08 y09 y10 y11 (2*y11+y12)/3 y11 y10 y09 y08 y07 y03 y04 y14 y15 y16 y17 y18 (2*y18+y11)/3];

%figure(5);


plot(XX,YY,'linewidth',4);
hold on

fill([x02 x03 x04 x05 x06 x07],[y02 y03 y04 y05 y06 y07],'r')
hold on

   circle = rsmak('circle');
%fnplt(circle), axis square
ellipse = fncmb(circle,[r 0;0 r]);
Ctx=.5*x11+.5*x12;Cty=.5*y11+.5*y12;
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
