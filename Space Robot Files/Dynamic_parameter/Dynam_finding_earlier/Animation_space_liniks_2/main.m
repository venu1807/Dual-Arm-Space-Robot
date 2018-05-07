clc;
clear all;

% Trajectory
Tp=20;
t=0:0.1:Tp;

thin=[0.3803;   -0.6198];%60
thf=[-pi/2; -pi/2];

n=3;
for i=1:n-1
    thi(i,:)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
    dthi(i,:)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
    ddthi(i,:)=(2*pi*(thf(i)-thin(i))/(Tp*Tp))*sin((2*pi/Tp)*t);
end

th1=thi(1,:); dth1=dthi(1,:); ddth1=ddthi(1,:);
th2=thi(2,:); dth2=dthi(2,:); ddth2=ddthi(2,:);

% Initial Values
x0=0;y0=0;ph0=0; 
dx0=0;dy0=0;dph0=0;

y0_in = [x0 y0 ph0 dx0 dy0 dph0];

% options = odeset('RelTol',1e-8,'AbsTol',1e-8);
% [T,Y] = ode45(@rigid2script,t,y0_in,options);

[T,Y] = ode45(@rigid2script,t,y0_in);
% torque = Hbm'*ddx0 + Hm*ddph + cm
Y;

% end

%% Animation
% Y(:,1)=0;
% Y(:,2)=0;
a0=1; a1=1; a2=1;
x0=Y(:,1);
y0=Y(:,2);
ph0=Y(:,3);
l=a0; w=a0;
x1=x0-(l/2); y1=y0-(w/2);
x2=x0+(l/2); y2=y0-(w/2);
x3=x0+(l/2); y3=y0+(w/2);
x4=x0-(l/2); y4=y0+(w/2);
% i=1;

% th1=0*T;
% th2=sin(T);
% a1=1; a2=1;
for i=1:size(x0)
xv=[x1(i) x2(i) x3(i) x4(i)];
yv=[y1(i) y2(i) y3(i) y4(i)];
% Rv(1,:)=xv(i,:);Rv(2,:)=yv(i,:);
Rot=[cos(ph0(i)) -sin(ph0(i));sin(ph0(i)) cos(ph0(i))];
XY=Rot*[xv;yv];
%Midpoint
m=(XY(:,2)+XY(:,3))/2;
% figure
XY1=[XY,XY(:,1)];
% rectangle('Position',[XY(i,1) XY(i,1) l w])
% hold off;
% end
O0x=m(1); O0y=m(2);

O1x=a1*cos(ph0(i)+th1(i)); O1y=a1*sin(ph0(i)+th1(i));
O2x=a1*cos(ph0(i)+th1(i))+a2*cos(ph0(i)+th1(i)+th2(i)); O2y=a1*sin(ph0(i)+th1(i))+a2*sin(ph0(i)+th1(i)+th2(i));

% O1x=a1*cosd(th1(i)); O1y=a1*sind(th1(i));
% O2x=a1*cosd(th1(i))+a2*cosd(th1(i)+th2(i)); O2y=a1*sind(th1(i))+a2*sind(th1(i)+th2(i));
XX=[O0x O0x+O1x O0x+O2x];
YY=[O0y O0y+O1y O0y+O2y];

% plot(XX,YY);
figure(1)
plot(XY1(1,:),XY1(2,:),XX,YY,'linewidth',1.5);
grid on
title(sprintf('Time = %g sec', T(i)))
axis([-5 5 -5 5])
pause(0.1)
drawnow
end

% Base Motion
figure(3)
title('Base Motion')
subplot(2,2,1);
plot(T,Y(:,1),T,Y(:,2))
legend('X_0','Y_0')
legend('boxoff')
subplot(2,2,2);
plot(T,Y(:,2))
legend('\phi_0')
legend('boxoff')
subplot(2,2,3);
plot(T,Y(:,4),T,Y(:,5))
legend('dX_0','dY_0')
legend('boxoff')
subplot(2,2,4);
plot(T,Y(:,6))
legend('d\phi_0')
legend('boxoff')

%Joint Motion
figure(4)
title('Joint Motion')
subplot(1,2,1);
plot(T,th1,T,th2)
legend('th1','th2')
legend('boxoff')
subplot(1,2,2);
plot(T,dth1,T,dth2)
legend('dth1','dth2')
legend('boxoff')

% Momentum
% Momentum
