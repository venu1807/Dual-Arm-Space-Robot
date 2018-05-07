% clear all;
% clc;
function dy = rigid2script(t,y)

%Trajectory
thin=[0.3803;   -0.6198];%60
thf=[-pi/2; -pi/2];
Tp=20;
n=3;

for i=1:n-1
    thi(i,:)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
    dthi(i,:)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
    ddthi(i,:)=(2*pi*(thf(i)-thin(i))/(Tp*Tp))*sin((2*pi/Tp)*t);
end

th1=thi(1,:); dth1=dthi(1,:); ddth1=ddthi(1,:);
th2=thi(2,:); dth2=dthi(2,:); ddth2=ddthi(2,:);

m0=100; m1=10; m2=10;
a0=1; a1=1; a2=1;

d1x=a1/2; d2x=a2/2;
d1y=0; d2y=0;

I0z=83.61; I1z=1.05; I2z=1.05;

x0=y(1); dx0=y(4);
y0=y(2); dy0=y(5);
ph0=y(3); dph0=y(6);

%Row1
hb11 = m0 + m1 + m2;
hb12 = 0;
hb13 = - (a0*m1*sin(ph0))/2 - (a0*m2*sin(ph0))/2 - d2y*m2*cos(ph0 + th1 + th2) - d2x*m2*sin(ph0 + th1 + th2) - d1y*m1*cos(ph0 + th1) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1);

hbm14 = - d2y*m2*cos(ph0 + th1 + th2) - d2x*m2*sin(ph0 + th1 + th2) - d1y*m1*cos(ph0 + th1) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1);
hbm15 = - d2y*m2*cos(ph0 + th1 + th2) - d2x*m2*sin(ph0 + th1 + th2);

%Row2
hb21 = 0;
hb22 = m0 + m1 + m2;
hb23 = (a0*m1*cos(ph0))/2 + (a0*m2*cos(ph0))/2 + d2x*m2*cos(ph0 + th1 + th2) - d2y*m2*sin(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) - d1y*m1*sin(ph0 + th1);

hbm24 = d2x*m2*cos(ph0 + th1 + th2) - d2y*m2*sin(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) - d1y*m1*sin(ph0 + th1);
hbm25 = d2x*m2*cos(ph0 + th1 + th2) - d2y*m2*sin(ph0 + th1 + th2) ;

%Row3
hb31 = - (a0*m1*sin(ph0))/2 - (a0*m2*sin(ph0))/2 - d2y*m2*cos(ph0 + th1 + th2) - d2x*m2*sin(ph0 + th1 + th2) - d1y*m1*cos(ph0 + th1) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1);
hb32 = (a0*m1*cos(ph0))/2 + (a0*m2*cos(ph0))/2 + d2x*m2*cos(ph0 + th1 + th2) - d2y*m2*sin(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) - d1y*m1*sin(ph0 + th1);
hb33 = I0z + I1z + I2z + (a0^2*m1)/4 + (a0^2*m2)/4 + a1^2*m2 + d1x^2*m1 + d2x^2*m2 + d1y^2*m1 + d2y^2*m2 + a0*d2x*m2*cos(th1 + th2) - a0*d2y*m2*sin(th1 + th2) + a0*a1*m2*cos(th1) + a0*d1x*m1*cos(th1) + 2*a1*d2x*m2*cos(th2) - a0*d1y*m1*sin(th1) - 2*a1*d2y*m2*sin(th2);


hbm34 =  m2*a1^2 + 2*m2*cos(th2)*a1*d2x - 2*m2*sin(th2)*a1*d2y + (a0*m2*cos(th1)*a1)/2 + m1*d1x^2 + (a0*m1*cos(th1)*d1x)/2 + m2*d2x^2 + (a0*m2*cos(th1 + th2)*d2x)/2 + m1*d1y^2 - (a0*m1*sin(th1)*d1y)/2 + m2*d2y^2 - (a0*m2*sin(th1 + th2)*d2y)/2 + I1z + I2z;
hbm35 = I2z + d2x^2*m2 + d2y^2*m2 + (a0*d2x*m2*cos(th1 + th2))/2 - (a0*d2y*m2*sin(th1 + th2))/2 + a1*d2x*m2*cos(th2) - a1*d2y*m2*sin(th2);

%Row4

hbm41 = - d2y*m2*cos(ph0 + th1 + th2) - d2x*m2*sin(ph0 + th1 + th2) - d1y*m1*cos(ph0 + th1) - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1);
hbm42 = d2x*m2*cos(ph0 + th1 + th2) - d2y*m2*sin(ph0 + th1 + th2) + a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) - d1y*m1*sin(ph0 + th1);
hm43 = m2*a1^2 + 2*m2*cos(th2)*a1*d2x - 2*m2*sin(th2)*a1*d2y + (a0*m2*cos(th1)*a1)/2 + m1*d1x^2 + (a0*m1*cos(th1)*d1x)/2 + m2*d2x^2 + (a0*m2*cos(th1 + th2)*d2x)/2 + m1*d1y^2 - (a0*m1*sin(th1)*d1y)/2 + m2*d2y^2 - (a0*m2*sin(th1 + th2)*d2y)/2 + I1z + I2z;

hm44 = m2*a1^2 + 2*m2*cos(th2)*a1*d2x - 2*m2*sin(th2)*a1*d2y + m1*d1x^2 + m2*d2x^2 + m1*d1y^2 + m2*d2y^2 + I1z + I2z;
hm45 = m2*d2x^2 + a1*m2*cos(th2)*d2x + m2*d2y^2 - a1*m2*sin(th2)*d2y + I2z  ;

%Row5

hbm51 = - d2y*m2*cos(ph0 + th1 + th2) - d2x*m2*sin(ph0 + th1 + th2);
hbm52 = d2x*m2*cos(ph0 + th1 + th2) - d2y*m2*sin(ph0 + th1 + th2) ;
hm53 = I2z + d2x^2*m2 + d2y^2*m2 + (a0*d2x*m2*cos(th1 + th2))/2 - (a0*d2y*m2*sin(th1 + th2))/2 + a1*d2x*m2*cos(th2) - a1*d2y*m2*sin(th2);

hm54 = m2*d2x^2 + a1*m2*cos(th2)*d2x + m2*d2y^2 - a1*m2*sin(th2)*d2y + I2z;
hm55 = m2*d2x^2 + m2*d2y^2 + I2z;



% {C} Matrix
cb1 = -(d2x*dph0^2*m2*cos(ph0 + th1 + th2) + d2x*dth1^2*m2*cos(ph0 + th1 + th2) + d2x*dth2^2*m2*cos(ph0 + th1 + th2) - d2y*dph0^2*m2*sin(ph0 + th1 + th2) - d2y*dth1^2*m2*sin(ph0 + th1 + th2) - d2y*dth2^2*m2*sin(ph0 + th1 + th2) + a1*dph0^2*m2*cos(ph0 + th1) + a1*dth1^2*m2*cos(ph0 + th1) + d1x*dph0^2*m1*cos(ph0 + th1) + d1x*dth1^2*m1*cos(ph0 + th1) - d1y*dph0^2*m1*sin(ph0 + th1) - d1y*dth1^2*m1*sin(ph0 + th1) + (a0*dph0^2*m1*cos(ph0))/2 + (a0*dph0^2*m2*cos(ph0))/2 + 2*d2x*dph0*dth1*m2*cos(ph0 + th1 + th2) + 2*d2x*dph0*dth2*m2*cos(ph0 + th1 + th2) + 2*d2x*dth1*dth2*m2*cos(ph0 + th1 + th2) - 2*d2y*dph0*dth1*m2*sin(ph0 + th1 + th2) - 2*d2y*dph0*dth2*m2*sin(ph0 + th1 + th2) - 2*d2y*dth1*dth2*m2*sin(ph0 + th1 + th2) + 2*a1*dph0*dth1*m2*cos(ph0 + th1) + 2*d1x*dph0*dth1*m1*cos(ph0 + th1) - 2*d1y*dph0*dth1*m1*sin(ph0 + th1));
cb2 = -(d2y*dph0^2*m2*cos(ph0 + th1 + th2) + d2y*dth1^2*m2*cos(ph0 + th1 + th2) + d2y*dth2^2*m2*cos(ph0 + th1 + th2) + d2x*dph0^2*m2*sin(ph0 + th1 + th2) + d2x*dth1^2*m2*sin(ph0 + th1 + th2) + d2x*dth2^2*m2*sin(ph0 + th1 + th2) + d1y*dph0^2*m1*cos(ph0 + th1) + d1y*dth1^2*m1*cos(ph0 + th1) + a1*dph0^2*m2*sin(ph0 + th1) + a1*dth1^2*m2*sin(ph0 + th1) + d1x*dph0^2*m1*sin(ph0 + th1) + d1x*dth1^2*m1*sin(ph0 + th1) + (a0*dph0^2*m1*sin(ph0))/2 + (a0*dph0^2*m2*sin(ph0))/2 + 2*d2y*dph0*dth1*m2*cos(ph0 + th1 + th2) + 2*d2y*dph0*dth2*m2*cos(ph0 + th1 + th2) + 2*d2y*dth1*dth2*m2*cos(ph0 + th1 + th2) + 2*d2x*dph0*dth1*m2*sin(ph0 + th1 + th2) + 2*d2x*dph0*dth2*m2*sin(ph0 + th1 + th2) + 2*d2x*dth1*dth2*m2*sin(ph0 + th1 + th2) + 2*d1y*dph0*dth1*m1*cos(ph0 + th1) + 2*a1*dph0*dth1*m2*sin(ph0 + th1) + 2*d1x*dph0*dth1*m1*sin(ph0 + th1));
cb3 = -((a0*d2y*dth1^2*m2*cos(th1 + th2))/2 + (a0*d2y*dth2^2*m2*cos(th1 + th2))/2 + (a0*d2x*dth1^2*m2*sin(th1 + th2))/2 + (a0*d2x*dth2^2*m2*sin(th1 + th2))/2 + (a0*d1y*dth1^2*m1*cos(th1))/2 + a1*d2y*dth2^2*m2*cos(th2) + (a0*a1*dth1^2*m2*sin(th1))/2 + (a0*d1x*dth1^2*m1*sin(th1))/2 + a1*d2x*dth2^2*m2*sin(th2) + a0*d2y*dph0*dth1*m2*cos(th1 + th2) + a0*d2y*dph0*dth2*m2*cos(th1 + th2) + a0*d2y*dth1*dth2*m2*cos(th1 + th2) + a0*d2x*dph0*dth1*m2*sin(th1 + th2) + a0*d2x*dph0*dth2*m2*sin(th1 + th2) + a0*d2x*dth1*dth2*m2*sin(th1 + th2) + a0*d1y*dph0*dth1*m1*cos(th1) + 2*a1*d2y*dph0*dth2*m2*cos(th2) + 2*a1*d2y*dth1*dth2*m2*cos(th2) + a0*a1*dph0*dth1*m2*sin(th1) + a0*d1x*dph0*dth1*m1*sin(th1) + 2*a1*d2x*dph0*dth2*m2*sin(th2) + 2*a1*d2x*dth1*dth2*m2*sin(th2));
cm4 = -(-(a0*d2y*dph0^2*m2*cos(th1 + th2))/2 - (a0*d2x*dph0^2*m2*sin(th1 + th2))/2 - (a0*d1y*dph0^2*m1*cos(th1))/2 + a1*d2y*dth2^2*m2*cos(th2) - (a0*a1*dph0^2*m2*sin(th1))/2 - (a0*d1x*dph0^2*m1*sin(th1))/2 + a1*d2x*dth2^2*m2*sin(th2) + 2*a1*d2y*dph0*dth2*m2*cos(th2) + 2*a1*d2y*dth1*dth2*m2*cos(th2) + 2*a1*d2x*dph0*dth2*m2*sin(th2) + 2*a1*d2x*dth1*dth2*m2*sin(th2));
cm5 = -(-(a0*d2y*dph0^2*m2*cos(th1 + th2))/2 - (a0*d2x*dph0^2*m2*sin(th1 + th2))/2 - a1*d2y*dph0^2*m2*cos(th2) - a1*d2y*dth1^2*m2*cos(th2) - a1*d2x*dph0^2*m2*sin(th2) - a1*d2x*dth1^2*m2*sin(th2) - 2*a1*d2y*dph0*dth1*m2*cos(th2) - 2*a1*d2x*dph0*dth1*m2*sin(th2));


% H = [hb11 hb12 hb13 hbm14 hbm15
%      hb21 hb22 hb23 hbm24 hbm25
%      hb31 hb32 hb33 hbm34 hbm35
%      hbm41 hbm42 hm43 hm44 hm45
%      hbm51 hbm52 hm53 hm54 hm55];

Hb = [hb11 hb12 hb13
     hb21 hb22 hb23
     hb31 hb32 hb33];
 
Hbm = [hbm14 hbm15
       hbm24 hbm25
       hbm34 hbm35];
Hm = [hm44 hm45
      hm54 hm55];
   
% C = [cb1
%      cb2
%      cb3
%      cm4
%      cm5];

cb = [cb1
     cb2
     cb3];
cm = [cm4
      cm5];
  
ddph = [ddth1
        ddth2];
% tau=0;
temp=(inv(Hb))*(-cb - Hbm*ddph);

% torque = Hbm'*temp + Hm*ddph + cm;

dy=zeros(6,1);

dy(1)=dx0;
dy(2)=dy0;
dy(3)=dph0;
dy(4)=temp(1);
dy(5)=temp(2);
dy(6)=temp(3);

