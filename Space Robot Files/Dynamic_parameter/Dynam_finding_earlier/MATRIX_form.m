function [q dq ddq dth ddth n nq alp a b t bt dx dy dz m x g  Icxx Icyy Iczz Icxy Icyz Iczx M]=run_me()

syms x0 y0 z0 ph0 th0 si0
syms dx0 dy0 dz0 dph0 dth0 dsi0 
syms ddx0 ddy0 ddz0 ddph0 ddth0 ddsi0 
syms th1 th2 th3 th4 th5 th6 th7
syms dth1 dth2 dth3 dth4 dth5 dth6 dth7
syms ddth1 ddth2 ddth3 ddth4 ddth5 ddth6 ddth7 
% Vector connecting origin and centre-of-mass of the link
syms d0x d1x d2x d3x d4x d5x d6x d7x
syms d0y d1y d2y d3y d4y d5y d6y d7y
syms d0z d1z d2z d3z d4z d5z d6z d7z
% Gravitational Acceleratoin
syms g
% Mass
syms m0 m1 m2 
% Inertia tensors
syms I0x I1x I2x 
syms I0y I1y I2y 
syms I0z I1z I2z 
syms a0 a1 a2 

%Equations of motion.
syms M11 M12 M13 M14 M15 M21 M22 M23 M24 M25 M31 M32 M33 M34 M35 M41 M42 M43 M44 M45 M51 M52 M53 M54 M55
syms C11 C12 C13 C14 C15 C21 C22 C23 C24 C25 C31 C32 C33 C34 C35 C41 C42 C43 C44 C45 C51 C52 C53 C54 C55
syms F1 F2 Tau0 Tau1 Tau2
syms Ma Va Fa
Ma=[M11 M12 M13 M14 M15;M21 M22 M23 M24 M25;M31 M32 M33 M34 M35;M41 M42 M43 M44 M45;M51 M52 M53 M54 M55];
Va=[C11 C12 C13 C14 C15;C21 C22 C23 C24 C25;C31 C32 C33 C34 C35;C41 C42 C43 C44 C45;C51 C52 C53 C54 C55];
% Fa=[Fx;Fx;Tau0;Tau1;Tau2];

M11=(m0+m1+m2)

M12=0

M13= - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1) - (a0*m1*sin(ph0))/2- (a0*m2*sin(ph0))/2- d2x*m2*sin(ph0 + th1 + th2)

M14= - a1*m2*sin(ph0 + th1)- d1x*m1*sin(ph0 + th1)- d2x*m2*sin(ph0 + th1 + th2)

M15= - d2x*m2*sin(ph0 + th1 + th2)

C11=0

C12=0

C13= - d2x*dph0^2*m2*cos(ph0 + th1 + th2) - a1*dph0^2*m2*cos(ph0 + th1) - d1x*dph0^2*m1*cos(ph0 + th1)- (a0*dph0^2*m1*cos(ph0))/2 - (a0*dph0^2*m2*cos(ph0))/2- 2*d2x*dph0*dth2*m2*cos(ph0 + th1 + th2)

C14=- d2x*dth1^2*m2*cos(ph0 + th1 + th2)- a1*dth1^2*m2*cos(ph0 + th1)- d1x*dth1^2*m1*cos(ph0 + th1) - 2*d2x*dph0*dth1*m2*cos(ph0 + th1 + th2)- 2*a1*dph0*dth1*m2*cos(ph0 + th1) - 2*d1x*dph0*dth1*m1*cos(ph0 + th1)

C15=- d2x*dth2^2*m2*cos(ph0 + th1 + th2)- 2*d2x*dth1*dth2*m2*cos(ph0 + th1 + th2)

M21=0

M22=(m0+m1+m2)

M23= a1*m2*cos(ph0 + th1)+ d1x*m1*cos(ph0 + th1)+ (a0*m1*cos(ph0))/2 +(a0*m2*cos(ph0))/2+ d2x*m2*cos(ph0 + th1 + th2)

M24= a1*m2*cos(ph0 + th1)+ d1x*m1*cos(ph0 + th1)+ d2x*m2*cos(ph0 + th1 + th2)

M25= d2x*m2*cos(ph0 + th1 + th2)

C21=0

C22=0

C23=- d2x*dph0^2*m2*sin(ph0 + th1 + th2)- a1*dph0^2*m2*sin(ph0 + th1)- d1x*dph0^2*m1*sin(ph0 + th1)- (a0*dph0^2*m1*sin(ph0))/2 - (a0*dph0^2*m2*sin(ph0))/2 - 2*d2x*dph0*dth2*m2*sin(ph0 + th1 + th2)

C24=- d2x*dth1^2*m2*sin(ph0 + th1 + th2)- a1*dth1^2*m2*sin(ph0 + th1) - d1x*dth1^2*m1*sin(ph0 + th1)- 2*d2x*dph0*dth1*m2*sin(ph0 + th1 + th2)- 2*a1*dph0*dth1*m2*sin(ph0 + th1) - 2*d1x*dph0*dth1*m1*sin(ph0 + th1)

C25=- d2x*dth2^2*m2*sin(ph0 + th1 + th2)- 2*d2x*dth1*dth2*m2*sin(ph0 + th1 + th2)

M31=- a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1) - (a0*m1*sin(ph0))/2 - (a0*m2*sin(ph0))/2- d2x*m2*sin(ph0 + th1 + th2)

M32= a1*m2*cos(ph0 + th1) +d1x*m1*cos(ph0 + th1) + (a0*m1*cos(ph0))/2 + (a0*m2*cos(ph0))/2+ d2x*m2*cos(ph0 + th1 + th2)

M33=(I0z+I1z+I2z)+ (a0^2*m1)/4  + (a0^2*m2)/4+ a1^2*m2+ d1x^2*m1 + d2x^2*m2 + a0*d2x*m2*cos(th1 + th2)+ a0*a1*m2*cos(th1)+ a0*d1x*m1*cos(th1)+ 2*a1*d2x*m2*cos(th2)

M34=(I1z+I2z)+ a1^2*m2+ d1x^2*m1 + d2x^2*m2 + (a0*d2x*m2*cos(th1 + th2))/2+ (a0*a1*m2*cos(th1))/2 + (a0*d1x*m1*cos(th1))/2+ 2*a1*d2x*m2*cos(th2)

M35=(I2z)++ d2x^2*m2+ (a0*d2x*m2*cos(th1 + th2))/2+ a1*d2x*m2*cos(th2)

C31=0

C32=0

C33=- a0*d2x*dph0*dth2*m2*sin(th1 + th2)- 2*a1*d2x*dph0*dth2*m2*sin(th2)

C34= -(a0*d2x*dth1^2*m2*sin(th1 + th2))/2- (a0*a1*dth1^2*m2*sin(th1))/2 - (a0*d1x*dth1^2*m1*sin(th1))/2 - a0*d2x*dph0*dth1*m2*sin(th1 + th2) 
- a0*a1*dph0*dth1*m2*sin(th1) - a0*d1x*dph0*dth1*m1*sin(th1)

C35=- (a0*d2x*dth2^2*m2*sin(th1 + th2))/2-a1*d2x*dth2^2*m2*sin(th2)- a0*d2x*dth1*dth2*m2*sin(th1 + th2)-2*a1*d2x*dth1*dth2*m2*sin(th2)


M41= - a1*m2*sin(ph0 + th1) - d1x*m1*sin(ph0 + th1)- d2x*m2*sin(ph0 + th1 + th2) 

M42=  a1*m2*cos(ph0 + th1) + d1x*m1*cos(ph0 + th1)+ d2x*m2*cos(ph0 + th1 + th2)

M43=  (I1z+I2z)+ a1^2*m2+ d1x^2*m1 + d2x^2*m2 + (a0*d2x*m2*cos(th1 + th2))/2 + (a0*a1*m2*cos(th1))/2 + (a0*d1x*m1*cos(th1))/2 + 2*a1*d2x*m2*cos(th2) 

M44= (I1z+I2z)+ a1^2*m2 +d1x^2*m1 + d2x^2*m2+ 2*a1*d2x*m2*cos(th2)

M45=I2z + d2x^2*m2+ a1*d2x*m2*cos(th2)

C41=0

C42=0

C43=(a0*d2x*dph0^2*m2*sin(th1 + th2))/2 + (a0*a1*dph0^2*m2*sin(th1))/2 + (a0*d1x*dph0^2*m1*sin(th1))/2

C44=- 2*a1*d2x*dth1*dth2*m2*sin(th2)

C45=- a1*d2x*dth2^2*m2*sin(th2)- 2*a1*d2x*dph0*dth2*m2*sin(th2)

M51=-d2x*m2*sin(ph0 + th1 + th2)

M52=d2x*m2*cos(ph0 + th1 + th2)

M53=I2z + d2x^2*m2 +(a0*d2x*m2*cos(th1 + th2))/2 + a1*d2x*m2*cos(th2)

M54=I2z + d2x^2*m2+ a1*d2x*m2*cos(th2)

M55=I2z+ d2x^2*m2

C51=0

C52=0

C53=(a0*d2x*dph0^2*m2*sin(th1 + th2))/2 + a1*d2x*dph0^2*m2*sin(th2)+ 2*a1*d2x*dph0*dth1*m2*sin(th2)

C54= a1*d2x*dth1^2*m2*sin(th2)

C55=0

Hb=[M11 M12 M13;M21 M22 M23;M31 M32 M33]
Hbm=[M14 M15;M24 M25;M34 M35]
HbmT=[M41 M42 M43;M51 M52 M53]
Hm=[M44 M45;M54 M55]
Cb=[C11+C12+C13+C14+C15;C21+C22+C23+C24+C25;C31+C32+C33+C34+C35]
Cm=[C41+C42+C43+C44+C45;C51+C52+C53+C54+C55]
ddXb=[ddx0;ddy0; ddph0]
ddPHI=[ddth1 ;ddth2]
Fb=[F1; F2; Tau0]
Tau_m=[Tau1;Tau2]
Fb =(Hb*ddXb)+(Hbm*ddPHI)+Cb
Tau_m =(HbmT*ddXb)+(Hm*ddPHI)+Cm

