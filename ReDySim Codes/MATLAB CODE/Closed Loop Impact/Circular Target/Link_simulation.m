clc;
clear all;

r=.5;

Ti=0; Tf=20;

TiTf1=Ti:.05:Tf

yy0=[0;0;0; 0.3803; -0.6198; 1.2867; pi-0.3803; 0.6198; -1.2867;0;0;0;0;0;0;0;0;0]; 



%yy0=[0;0;0; 0.698;-1.571; 1.047; 2.444 ;1.571; -1.047;0;0;0;0;0;0;0;0;0];
[T1,Y1] = ode45(@rigid_1,TiTf1,yy0);

Tii=Tf; Tff=30;

TiTf2=Tii:.05:Tff

n=length(T1)

[thdotf ttf tbf]=Impact_eqns()

yy00=[Y1(n,1:8).';0;0;tbf;thdotf(1:5)]; 

[T2,Y2] = ode45(@rigid_2,TiTf2,yy00);

T=[T1;T2];

Y(1:n,1:18)=Y1;
Y(n+1:length(T),1:8)=Y2(:,1:8);
Y(n+1:length(T),10:17)=Y2(:,11:18);
set(0,'DefaultLineLineWidth',1.5)
% 
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

m0=500;m1=10;m2=10;m3=10;m4=10;m5=10;m6=10; l0=1;l1=1;l2=1; l3=1;l4=1;l5=1;l6=1;l7=1; lc0=.5*l0;lc1=.5*l1;lc2=.5*l2;lc3=.5*l3; lc4=.5*l4;lc5=.5*l5;lc6=.5*l6; lc7=.5*l7; 
Izz0=83.61; Izz1=1.05; Izz2=1.05; Izz3=1.05;Izz4=1.05; Izz5=1.05; Izz6=1.05; 

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
x08=x07+l1*cos(Y(i,3)+Y(i,4)); y08=y07+l1*sin(Y(i,3)+Y(i,4));
x09=x08+l2*cos(Y(i,3)+Y(i,4)+Y(i,5)); y09=y08+l1*sin(Y(i,3)+Y(i,4)+Y(i,5));
x10=x09+l3*cos(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6)); y10=y09+l1*sin(Y(i,3)+Y(i,4)+Y(i,5)+Y(i,6));


x11=Y(i,1); y11=Y(i,2);
x12=x11-lc0*cos(Y(i,3)); y12=y11-lc0*sin(Y(i,3));
x13=x12+l4*cos(Y(i,3)+Y(i,7)); y13=y12+l4*sin(Y(i,3)+Y(i,7));
x14=x13+l5*cos(Y(i,3)+Y(i,7)+Y(i,8)); y14=y13+l5*sin(Y(i,3)+Y(i,7)+Y(i,8));
x15=x14+l6*cos(Y(i,3)+Y(i,7)+Y(i,8)+Y(i,9)); y15=y14+l6*sin(Y(i,3)+Y(i,7)+Y(i,8)+Y(i,9));

XX=[x02 x03 x04 x05 x06 x07 x08 x09 x10 x09 x08 x07 x03 x04 x12 x13 x14 x15];
YY=[y02 y03 y04 y05 y06 y07 y08 y09 y10 y09 y08 y07 y03 y04 y12 y13 y14 y15];

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
    
     l3=2*(1+r);
    
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
x13=x12+l4*cos(Y(i,3)+Y(i,7)); y13=y12+l4*sin(Y(i,3)+Y(i,7));
x14=x13+l5*cos(Y(i,3)+Y(i,7)+Y(i,8)); y14=y13+l5*sin(Y(i,3)+Y(i,7)+Y(i,8));

%x15=x14+l6*cos(Y(i,3)+Y(i,7)+Y(i,8)+theta6); y15=y14+l6*sin(Y(i,3)+Y(i,7)+Y(i,8)+theta6);
XX=[x02 x03 x04 x05 x06 x07 x08 x09 x10 x09 x08 x07 x03 x04 x12 x13 x10];
YY=[y02 y03 y04 y05 y06 y07 y08 y09 y10 y09 y08 y07 y03 y04 y12 y13 y10];

%figure(5);


plot(XX,YY,'linewidth',4);
hold on

fill([x02 x03 x04 x05 x06 x07],[y02 y03 y04 y05 y06 y07],'r')
hold on

   circle = rsmak('circle');
%fnplt(circle), axis square
ellipse = fncmb(circle,[r 0;0 r]);
Ctx=.5*x09+.5*x10;Cty=.5*y09+.5*y10;
s=atan2((y10-y09),(x10-x09));
target=fncmb(fncmb(ellipse, [cos(s) -sin(s);sin(s) cos(s)]), [Ctx;Cty] );
hold on, fnplt(target), hold off 


%xmin=-1*(l0+l1+l2+l3); xmax=1*(l0+l1+l2+l3); ymin=-1*(l0+l1+l2+l3); ymax=1*(l0+l1+l2+l3);
axis([xmin xmax ymin ymax])
title(['Current time t:',num2str(t)]);
grid on
pause(0.05)
end
end
