function [V_x, V_y, V_z, W_x, W_y, W_z] = BaseStateUKF(z,dt,L1,L2,L3 )
%
%
persistent Q R
persistent x P
persistent n m
persistent firstRun

if isempty(firstRun)
    
   Q=eye(6);
  
   R=eye(6);

%    R=[0.0001 0 0 0 0 0;
%       0 0.0001 0 0 0 0;
%       0 0 0.0001 0 0 0;
%       0 0 0 0.0001 0 0;
%       0 0 0 0 0.0001 0;
%       0 0 0 0 0      1];
  
%   R=randn(6,6);

  x = [0 0 0 0 0 0]';  
  P = 1*eye(6);
  
  n = 6;
  m = 6;
  
  firstRun = 1;  
end


[Xi W] = SigmaPoints(x, P, 0);

fXi = zeros(n, 2*n+1);
for k = 1:2*n+1
  fXi(:, k) = fx(Xi(:,k),dt,L1,L2,L3);
end

[xp Pp] = UT(fXi, W, Q);

hXi = zeros(m, 2*n+1);
for k = 1:2*n+1
  hXi(:, k) = hx(fXi(:,k));
end

[zp Pz] = UT(hXi, W, R);

Pxz = zeros(n, m);
for k = 1:2*n+1
  Pxz = Pxz + W(k)*(fXi(:,k) - xp)*(hXi(:,k) - zp)';
end

K = Pxz*inv(Pz);

x = xp + K*(z - zp);
P = Pp - K*Pz*K';


V_x   = x(1);
V_y   = x(2);
V_z   = x(3);
W_x   = x(4);
W_y   = x(5);
W_z   = x(6);


%------------------------------

function xp = fx(x,dt,L1,L2,L3)

m0=100; m1=10; m2=10;
M1=m0+m1+m2;
a0=1; a1=1; a2=1;
d1x=0.5; d2x=0.5;
d1y=0; d2y=0;
I0z=83.61; I1z=1.05; I2z=1.05;

ph0=L1(1);

th1=L2(1);
th2=L2(2);

rbg_1=((m1/M1)*(a0/2)*cos(ph0)) + ((m1/M1)*(a1/2)*cos(ph0+th1)) + ((m2/M1)*(a0/2)*cos(ph0)) + ((m2/M1)*a1*cos(ph0+th1)) + ((m2/M1)*(a2/2)*cos(ph0+th1+th2));

rbg_2=((m1/M1)*(a0/2)*sin(ph0)) + ((m1/M1)*(a1/2)*sin(ph0+th1)) + ((m2/M1)*(a0/2)*sin(ph0)) + ((m2/M1)*a1*sin(ph0+th1)) + ((m2/M1)*(a2/2)*sin(ph0+th1+th2));

rbg_X=[0     0     rbg_2;
       0     0    -rbg_1;
      -rbg_2 rbg_1  0];
  
M1=m0+m1+m2;

I=eye(3,3);

Jtg=[  -((m1*a1/2)*sin(ph0+th1)+m2*a1*sin(ph0+th1)+(m2*a2/2)*sin(ph0+th1+th2))   -((m2*a2/2)*sin(ph0+th1+th2));
             (m1*a1/2)*cos(ph0+th1)+m2*a1*cos(ph0+th1)+(m2*a2/2)*cos(ph0+th1+th2)      (m2*a2/2)*cos(ph0+th1+th2);
            0 0];
rg_1= (m1/M1)*(a0/2)*cos(ph0)+(m1/M1)*(a1/2)*cos(ph0+th1)+(m2/M1)*(a0/2)*cos(ph0)+(m2/M1)*a1*cos(ph0+th1)+(m2/M1)*(a2/2)*cos(ph0+th1+th2);       
        
rg_2= (m1/M1)*(a0/2)*sin(ph0)+(m1/M1)*(a1/2)*sin(ph0+th1)+(m2/M1)*(a0/2)*sin(ph0)+(m2/M1)*a1*sin(ph0+th1)+(m2/M1)*(a2/2)*sin(ph0+th1+th2);

rg_X=[0    0    rg_2;
    0    0   -rg_1;
   -rg_2 rg_1    0];

r1c=[0, 0, (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1)
         0, 0, -(a0/2)*cos(ph0)-(a1/2)*cos(ph0+th1)
         -(a0/2)*sin(ph0)-(a1/2)*sin(ph0+th1), (a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1), 0];

r2c=[0, 0 ,(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
          0, 0 ,-(a0/2)*cos(ph0)-a1*cos(ph0+th1)-(a2/2)*cos(ph0+th1+th2);
         -(a0/2)*sin(ph0)-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2),(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),0];

r1= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1);
        (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1);
         0];   
     
r11= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1),(a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1), 0];  
      
r2= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2);
         (a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
         0];
    
r22= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2),0];  
      
Iw1= I0z + I1z + m1*r11*r1 + I2z + m2*r22*r2;
    
Iw = Iw1;

Jr1= [0 0;0 0;1 0]; 
    
Jr2= [0 0;0 0;1 1];
    
Jt1=[-(a1/2)*sin(ph0+th1) 0; (a1/2)*cos(ph0+th1) 0;0 0];
    
Jt2=[-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2)     -(a2/2)*sin(ph0+th1+th2);
          a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2)      (a2/2)*cos(ph0+th1+th2);
          0 0];

Iph = I1z*Jr1 + m1*r1c*Jt1 + I2z*Jr2 + m2*r2c*Jt2;



H1=[M1*eye(3,3) -M1*rbg_X;M1*rg_X  Iw*eye(3,3)];

H2=[Jtg;Iph];

HI=inv(H1);

dph=[L3(1);L3(2)];

xp=x+(HI*H2*dph);

%-------------------------------------------------------------------
function yp = hx(x)

yp=eye(6)*[x(1) x(2) x(3) x(4) x(5) x(6)]';