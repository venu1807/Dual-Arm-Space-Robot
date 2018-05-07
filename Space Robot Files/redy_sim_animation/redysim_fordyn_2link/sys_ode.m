% ReDySim sys_ode. This module contains ODE of system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function dy=sys_ode(t,y,Tp)
%Input data
[n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx m0 m1 m2 a0 a1 a2 d1x d2x I0z I1z I2z]=inputs();
q=y(1:6);
th_re=y(6:6+n-1);
nqn=6+n;
dq=y(nqn:nqn+6-1);
dth_re=y(nqn+6-1:2*(n+6-1));
disp(t);


x0=q(1); y0=q(2); ph0=q(4); 
dx0=dq(1); dy0=dq(2); dph0=dq(4);
th1=th_re(2); th2=th_re(3);

[th_d dth_d ddth_d]=trajectory(0:0.05:60,3,60);

dth1=dth_d(2,:);
dth2=dth_d(3,:);

M1 =(m0+m1+m2);

M11=(m0+m1+m2);

M12=0;

M13= - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1) - (a0*m1*sin(ph0))/2- (a0*m2*sin(ph0))/2- d2x*m2*sin(ph0 + th1 + th2);

M14= - a1*m2*sin(ph0 + th1)- d1x*m1*sin(ph0 + th1)- d2x*m2*sin(ph0 + th1 + th2);

M15= - d2x*m2*sin(ph0 + th1 + th2);

C11=0;

C12=0;

C13= - d2x*dph0^2*m2*cos(ph0 + th1 + th2) - a1*dph0^2*m2*cos(ph0 + th1) - d1x*dph0^2*m1*cos(ph0 + th1)- (a0*dph0^2*m1*cos(ph0))/2 - (a0*dph0^2*m2*cos(ph0))/2- 2*d2x*dph0*dth2*m2*cos(ph0 + th1 + th2);

C14= - d2x*dth1^2*m2*cos(ph0 + th1 + th2) - a1*dth1^2*m2*cos(ph0 + th1)- d1x*dth1^2*m1*cos(ph0 + th1) - 2*d2x*dph0*dth1*m2*cos(ph0 + th1 + th2)- 2*a1*dph0*dth1*m2*cos(ph0 + th1) - 2*d1x*dph0*dth1*m1*cos(ph0 + th1);

C15= - d2x*dth2^2*m2*cos(ph0 + th1 + th2) - 2*d2x*dth1*dth2*m2*cos(ph0 + th1 + th2);

M21=0;

M22= (m0+m1+m2);

M23= a1*m2*cos(ph0 + th1)+ d1x*m1*cos(ph0 + th1)+ (a0*m1*cos(ph0))/2 +(a0*m2*cos(ph0))/2+ d2x*m2*cos(ph0 + th1 + th2);

M24= a1*m2*cos(ph0 + th1)+ d1x*m1*cos(ph0 + th1)+ d2x*m2*cos(ph0 + th1 + th2);

M25= d2x*m2*cos(ph0 + th1 + th2);

C21=0;

C22=0;

C23=- d2x*dph0^2*m2*sin(ph0 + th1 + th2)- a1*dph0^2*m2*sin(ph0 + th1)- d1x*dph0^2*m1*sin(ph0 + th1)- (a0*dph0^2*m1*sin(ph0))/2 - (a0*dph0^2*m2*sin(ph0))/2 - 2*d2x*dph0*dth2*m2*sin(ph0 + th1 + th2);

C24=- d2x*dth1^2*m2*sin(ph0 + th1 + th2)- a1*dth1^2*m2*sin(ph0 + th1) - d1x*dth1^2*m1*sin(ph0 + th1)- 2*d2x*dph0*dth1*m2*sin(ph0 + th1 + th2)- 2*a1*dph0*dth1*m2*sin(ph0 + th1) - 2*d1x*dph0*dth1*m1*sin(ph0 + th1);

C25=- d2x*dth2^2*m2*sin(ph0 + th1 + th2)- 2*d2x*dth1*dth2*m2*sin(ph0 + th1 + th2);

M31=- a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1) - (a0*m1*sin(ph0))/2 - (a0*m2*sin(ph0))/2- d2x*m2*sin(ph0 + th1 + th2);

M32=  a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1) + (a0*m1*cos(ph0))/2 + (a0*m2*cos(ph0))/2+ d2x*m2*cos(ph0 + th1 + th2);

M33=(I0z+I1z+I2z)+ (a0^2*m1)/4  + (a0^2*m2)/4+ a1^2*m2+ d1x^2*m1 + d2x^2*m2 + a0*d2x*m2*cos(th1 + th2)+ a0*a1*m2*cos(th1)+ a0*d1x*m1*cos(th1)+ 2*a1*d2x*m2*cos(th2);

M34=(I1z+I2z)+ a1^2*m2+ d1x^2*m1 + d2x^2*m2 + (a0*d2x*m2*cos(th1 + th2))/2+ (a0*a1*m2*cos(th1))/2 + (a0*d1x*m1*cos(th1))/2+ 2*a1*d2x*m2*cos(th2);

M35=(I2z)++ d2x^2*m2+ (a0*d2x*m2*cos(th1 + th2))/2+ a1*d2x*m2*cos(th2);

C31=0;

C32=0;

C33=- a0*d2x*dph0*dth2*m2*sin(th1 + th2)- 2*a1*d2x*dph0*dth2*m2*sin(th2);

C34= -(a0*d2x*dth1^2*m2*sin(th1 + th2))/2- (a0*a1*dth1^2*m2*sin(th1))/2 - (a0*d1x*dth1^2*m1*sin(th1))/2 - a0*d2x*dph0*dth1*m2*sin(th1 + th2) - a0*a1*dph0*dth1*m2*sin(th1) - a0*d1x*dph0*dth1*m1*sin(th1);

C35=- (a0*d2x*dth2^2*m2*sin(th1 + th2))/2-a1*d2x*dth2.^2*m2*sin(th2)- a0*d2x*dth1*dth2*m2*sin(th1 + th2)-2*a1*d2x*dth1*dth2*m2*sin(th2);


M41= - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1)- d2x*m2*sin(ph0 + th1 + th2) ;

M42=  a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1)+ d2x*m2*cos(ph0 + th1 + th2);

M43=  (I1z+I2z)+ a1^2*m2+ d1x^2*m1 + d2x^2*m2 + (a0*d2x*m2*cos(th1 + th2))/2 + (a0*a1*m2*cos(th1))/2 + (a0*d1x*m1*cos(th1))/2 + 2*a1*d2x*m2*cos(th2) ;

M44=  (I1z+I2z)+ a1^2*m2 +d1x^2*m1 + d2x^2*m2+ 2*a1*d2x*m2*cos(th2);

M45=  I2z + d2x^2*m2+ a1*d2x*m2*cos(th2);

C41= 0;

C42= 0;

C43=  (a0*d2x*dph0^2*m2*sin(th1 + th2))/2 + (a0*a1*dph0^2*m2*sin(th1))/2 + (a0*d1x*dph0^2*m1*sin(th1))/2;

C44= - 2*a1*d2x*dth1*dth2*m2*sin(th2);

C45= - a1*d2x*dth2^2*m2*sin(th2)- 2*a1*d2x*dph0*dth2*m2*sin(th2);

M51= -d2x*m2*sin(ph0 + th1 + th2);

M52=  d2x*m2*cos(ph0 + th1 + th2);

M53=  I2z + d2x^2*m2 +(a0*d2x*m2*cos(th1 + th2))/2 + a1*d2x*m2*cos(th2);

M54=  I2z + d2x^2*m2+ a1*d2x*m2*cos(th2);

M55=  I2z+ d2x^2*m2;

C51= 0;

C52= 0;

C53= (a0*d2x*dph0^2*m2*sin(th1 + th2))/2 + a1*d2x*dph0^2*m2*sin(th2)+ 2*a1*d2x*dph0*dth1*m2*sin(th2);

C54= a1*d2x*dth1^2*m2*sin(th2);

C55= 0;

[th_d dth_d ddth_d]=trajectory(t, n, tf);

th=[0;0.3803; -0.6198];%60
dth=zeros(n-1,1);

Jtg=[  -((m1*a1/2)*sin(ph0+th1)+m2*a1*sin(ph0+th1)+(m2*a2/2)*sin(ph0+th1+th2))   -((m2*a2/2)*sin(ph0+th1+th2));
             (m1*a1/2)*cos(ph0+th1)+m2*a1*cos(ph0+th1)+(m2*a2/2)*cos(ph0+th1+th2)      (m2*a2/2)*cos(ph0+th1+th2);
            0 0];
        

a11=-((m1/M1)*(a0/2)*sin(ph0)+(m1/M1)*(a1/2)*sin(ph0+th1)+(m2/M1)*(a0/2)*sin(ph0)+(m2/M1)*a1*sin(ph0+th1)+(m2/M1)*(a2/2)*sin(ph0+th1+th2) );
a21=(m1/M1)*(a0/2)*cos(ph0)+(m1/M1)*(a1/2)*cos(ph0+th1)+(m2/M1)*(a0/2)*cos(ph0)+(m2/M1)*a1*cos(ph0+th1)+(m2/M1)*(a2/2)*cos(ph0+th1+th2);
% Jtg1=[  0   0   0;
%         0   0   0;
%         a11  a21  0];    
%      
Rg=[  0   0   0;
      0   0   0; 
    -((m1/M1)*(a0/2)*sin(ph0)+(m1/M1)*(a1/2)*sin(ph0+th1)+(m2/M1)*(a0/2)*sin(ph0)+(m2/M1)*a1*sin(ph0+th1)+(m2/M1)*(a2/2)*sin(ph0+th1+th2) )  (m1/M1)*(a0/2)*cos(ph0)+(m1/M1)*(a1/2)*cos(ph0+th1)+(m2/M1)*(a0/2)*cos(ph0)+(m2/M1)*a1*cos(ph0+th1)+(m2/M1)*(a2/2)*cos(ph0+th1+th2)  0 ];

r1c=[0, 0, (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1);0, 0, -(a0/2)*cos(ph0)-(a1/2)*cos(ph0+th1);-(a0/2)*sin(ph0)-(a1/2)*sin(ph0+th1), (a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1), 0];

r2c=[0, 0 ,(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
          0, 0 ,-(a0/2)*cos(ph0)-a1*cos(ph0+th1)-(a2/2)*cos(ph0+th1+th2);
         -(a0/2)*sin(ph0)-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2),(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),0];



Jr1= [0 0;0 0;1 0]; 
    
Jr2= [0 0;0 0;1 1];
    
Jt1=[-(a1/2)*sin(ph0+th1) 0; (a1/2)*cos(ph0+th1) 0;0 0];
    
Jt2=[-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2)     -(a2/2)*sin(ph0+th1+th2);
          a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2)      (a2/2)*cos(ph0+th1+th2);
          0 0];
% 
Iph = I1z*Jr1 + m1*r1c*Jt1 + I2z*Jr2 + m2*r2c*Jt2;
    
HBM= Iph -(Rg*Jtg);

temp=(eye(2)- (pinv(HBM)*HBM ))*dph;

%Joint Torque 
% [tu_q tu_th] = torque(t, n, Tp, q, th, dq, dth);
% tue=[tu_q; tu_th];
% Differential equation

%Method 1:Direct method
% [ddy]=fordyn_float(q, dq, th, dth, n,alp,a,b,bt,dx,dy,dz,al, alt, m,g,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx, tu_q,tu_th);
dy=zeros(2*(n+6-1)+1,1);

dy(1:n+6-3)=y(n+6:2*(n+6-2));
dy(n+6-2:n+6-1)=temp(1:2);

tu_q=[0;0;0;0;0;0];
kp=49; kv=14;
tu_th=kp*(th_re(2:3)-th(2:n))+kv*(dth_re(2:3)-dth(2:n));
tu=[tu_th(1);tu_th(2)];
tue=[tu_q; tu_th];

Hb=[M11 M12 M13;M21 M22 M23;M31 M32 M33];
Hbm=[M14 M15;M24 M25;M34 M35];
HbmT=[M41 M42 M43;M51 M52 M53];
Hm=[M44 M45;M54 M55];
Cb=[C11+C12+C13+C14+C15;C21+C22+C23+C24+C25;C31+C32+C33+C34+C35];
Cm=[C41+C42+C43+C44+C45;C51+C52+C53+C54+C55];

ddPHI = [ddth_d(1);ddth_d(2)];

ddy=(pinv(HbmT))*(Tau-(Hm*ddPHI)-Cm);

dy(n+6:2*(n+2))=ddy(1:2);
dy(11)=0;
dy(12)=ddy(3);
dy(13:14)=0;
dy(15:16)=0;
% deriv of joint energy
dy(2*(n+6-1)+1)=-tue'*dy(1:n+6-1);
%%%%%%%%%%%%%%%%%%% hopon.m ends %%%%%%%%%%%%%%%%%%%%