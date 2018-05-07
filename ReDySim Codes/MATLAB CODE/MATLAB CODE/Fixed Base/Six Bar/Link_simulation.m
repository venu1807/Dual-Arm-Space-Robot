clc;
clear all;

Ti=0; Tf=2;

yy00=[60*pi/180 ;60*pi/180; (60)*pi/180; 120*pi/180;300*pi/180;0;0];



yy0=yy00
%Vel

th1=yy00(1); th2=yy00(2); th3=yy00(3);th4=yy00(4);th5=yy00(5);

th6=300*pi/180;

% Link lengths
l1=1%0.05; %crank
l2=1%0.13; %output link 
l3=1%0.1; %connecting link
l0=1%0.15;%fixed base
l4=1%.2;
l5=1

l31=0.5*l3; l32=0.5*l3;

J1=[ - l2*sin(th1 + th2) - l1*sin(th1) - l31*sin(th1 + th2 + th3), - l2*sin(th1 + th2) - l31*sin(th1 + th2 + th3), -l31*sin(th1 + th2 + th3)
   l2*cos(th1 + th2) + l1*cos(th1) + l31*cos(th1 + th2 + th3),   l2*cos(th1 + th2) + l31*cos(th1 + th2 + th3),  l31*cos(th1 + th2 + th3)]


J2 =[ - l5*sin(th4 + th5) - l4*sin(th4) - l32*sin(th4 + th5 + th6), -l5*sin(th4 + th5) - l32*sin(th4 + th5 + th6), - l32*sin(th4 + th5 + th6)
   l5*cos(th4 + th5) + l4*cos(th4) + l32*cos(th4 + th5 + th6),  l5*cos(th4 + th5)+ l32*cos(th4 + th5 + th6),   l32*cos(th4 + th5 + th6)]


J(:,1:3)=J1;
J(:,4:6)=-J2;

Je(1:2,1:3)=J1
Je(3,1:3)=ones(1,3)
Je(4:5,4:6)=J2
Je(6,4:6)=ones(1,3)

Pxd=0;
Pyd=10;
Pwd=0;

thdot=pinv(Je)*[Pxd;Pyd;Pwd;Pxd;Pyd;Pwd]

yy0(8:12)=thdot(1:5)


%yy0(8:12)=zeros(5,1)
[T,Y] = ode45(@rigid,[Ti Tf],yy0);

set(0,'DefaultLineLineWidth',1.5)

fh1=figure('Name','Motion Parameters','NumberTitle','off');
set(fh1, 'color', 'white'); % sets the color to white 

subplot(2,1,1)
plot(T,Y(:,1),'-',T,Y(:,2),'-',T,Y(:,3),'-',T,Y(:,4),'-')
legend('th1', 'th2','th3','th4')
xlabel('Time')
ylabel('Joint Angles')

%figure(2)
%subplot(2,2,2)
%plot(T,Y(:,5),'-',T,Y(:,6))
%legend('lmdx', 'lmdy')
%xlabel('Time')
%ylabel('Langrange Multiplier')

%figure(3)
subplot(2,1,2)
plot(T,Y(:,7),'-',T,Y(:,8),T,Y(:,9),T,Y(:,10))
legend('dth1','dth2','dth3','dth4')
xlabel('Time')
ylabel('joint rate')

%figure(4)
%subplot(2,2,4)
%plot(T,Y(:,11),'-',T,Y(:,12),'-')
%legend('dlmdx','dlmdy')
%xlabel('Time')
%ylabel('rate of change of lmd')

%Animation

for i=1:length(T)
    t=T(i);

    x00=0; y00=0;
x01=-l0; y01=0;
x02=x00+l1*cos(Y(i,1)); y02=y00+l1*sin(Y(i,1));
x03=x02+l2*cos(+Y(i,1)+Y(i,2)); y03=y02+l2*sin(Y(i,1)+Y(i,2));
x04=x03+l3*cos(+Y(i,1)+Y(i,2)+Y(i,3)); y04=y03+l3*sin(Y(i,1)+Y(i,2)+Y(i,3));

x05=x01+l4*cos(Y(i,4)); y05=y01+l4*sin(Y(i,4));
x06=x05+l5*cos(Y(i,4)+Y(i,5)); y06=y05+l5*sin(Y(i,4)+Y(i,5));


XX=[x00 x02 x03  x04 x06 x05 x01];
YY=[y00 y02 y03  y04 y06 y05 y01];

figure(5)

%fill([x02 x03 x04 x05 x06 x07],[y02 y03 y04 y05 y06 y07],'r')

plot(XX,YY,'linewidth',4);

xmin=-1*(l0+l1+l2+l3); xmax=1*(l0+l1+l2+l3); ymin=-1*(l0+l1+l2+l3); ymax=1*(l0+l1+l2+l3);
axis([xmin xmax ymin ymax])
grid on
pause(0.0000005)
end