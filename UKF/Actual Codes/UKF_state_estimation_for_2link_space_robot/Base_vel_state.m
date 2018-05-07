function [dx0_m dy0_m dz0_m wx_m wy_m wz_m] = Base_vel_state( [dx0  dy0  dz0],[wx  wy  wz] )
%
%

dx0_m=dx0;

dy0_m=dy0;

dz0_m=dz0;

wx_m=wx;

wy_m=wy;

wz_m=wz;

% r=[dx0_m dy0_m dz0_m wx_m wy_m wz_m]';






















% % m0=100; m1=10; m2=10;
% M1=m0+m1+m2;
% a0=1; a1=1; a2=1;
% d1x=0.5; d2x=0.5;
% d1y=0; d2y=0;
% I0z=83.61; I1z=1.05; I2z=1.05;
% 
% ph0=phi;
% 
% th1=th_1;
% th2=th_2;
% 
% dth_1=dth1;
% dth_2=dth2;
% 
% rbg_1=((m1/M1)*(a0/2)*cos(ph0)) + ((m1/M1)*(a1/2)*cos(ph0+th1)) + ((m2/M1)*(a0/2)*cos(ph0)) + ((m2/M1)*a1*cos(ph0+th1)) + ((m2/M1)*(a2/2)*cos(ph0+th1+th2));
% 
% rbg_2=((m1/M1)*(a0/2)*sin(ph0)) + ((m1/M1)*(a1/2)*sin(ph0+th1)) + ((m2/M1)*(a0/2)*sin(ph0)) + ((m2/M1)*a1*sin(ph0+th1)) + ((m2/M1)*(a2/2)*sin(ph0+th1+th2));
% 
% rbg_X=[0     0     rbg_2;
%        0     0    -rbg_1;
%       -rbg_2 rbg_1  0];
%   
% M1=m0+m1+m2;
% 
% I=eye(3,3);
% 
% Jtg=[  -((m1*a1/2)*sin(ph0+th1)+m2*a1*sin(ph0+th1)+(m2*a2/2)*sin(ph0+th1+th2))   -((m2*a2/2)*sin(ph0+th1+th2));
%              (m1*a1/2)*cos(ph0+th1)+m2*a1*cos(ph0+th1)+(m2*a2/2)*cos(ph0+th1+th2)      (m2*a2/2)*cos(ph0+th1+th2);
%             0 0];
% rg_1= (m1/M1)*(a0/2)*cos(ph0)+(m1/M1)*(a1/2)*cos(ph0+th1)+(m2/M1)*(a0/2)*cos(ph0)+(m2/M1)*a1*cos(ph0+th1)+(m2/M1)*(a2/2)*cos(ph0+th1+th2);       
%         
% rg_2= (m1/M1)*(a0/2)*sin(ph0)+(m1/M1)*(a1/2)*sin(ph0+th1)+(m2/M1)*(a0/2)*sin(ph0)+(m2/M1)*a1*sin(ph0+th1)+(m2/M1)*(a2/2)*sin(ph0+th1+th2);
% 
% rg_X=[0    0    rg_2;
%     0    0   -rg_1;
%    -rg_2 rg_1    0];
% 
% r1c=[0, 0, (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1)
%          0, 0, -(a0/2)*cos(ph0)-(a1/2)*cos(ph0+th1)
%          -(a0/2)*sin(ph0)-(a1/2)*sin(ph0+th1), (a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1), 0];
% 
% r2c=[0, 0 ,(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
%           0, 0 ,-(a0/2)*cos(ph0)-a1*cos(ph0+th1)-(a2/2)*cos(ph0+th1+th2);
%          -(a0/2)*sin(ph0)-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2),(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),0];
% 
% r1= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1);
%         (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1);
%          0];   
%      
% r11= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1),(a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1), 0];  
%       
% r2= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2);
%          (a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
%          0];
%     
% r22= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2),0];  
%       
% Iw1= I0z + I1z + m1*r11*r1 + I2z + m2*r22*r2;
%     
% Iw = Iw1;
% 
% Jr1= [0 0;0 0;1 0]; 
%     
% Jr2= [0 0;0 0;1 1];
%     
% Jt1=[-(a1/2)*sin(ph0+th1) 0; (a1/2)*cos(ph0+th1) 0;0 0];
%     
% Jt2=[-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2)     -(a2/2)*sin(ph0+th1+th2);
%           a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2)      (a2/2)*cos(ph0+th1+th2);
%           0 0];
% 
% Iph = I1z*Jr1 + m1*r1c*Jt1 + I2z*Jr2 + m2*r2c*Jt2;
% 
% 
% 
% H1=[M1*eye(3,3) -M1*rbg_X;M1*rg_X  Iw*eye(3,3)];
% 
% H2=[Jtg;Iph];
% 
% HI=inv(H1);
% 
% dph=[dth_1;dth_2];
% 
% JKL=HI*H2*dph;
% 
% dx0_a=JKL(1);
% dy0_a=JKL(2);
% dz0_a=JKL(3);
% 
% wx_a=JKL(4);
% wy_a=JKL(5);
% wz_a=JKL(6);

 