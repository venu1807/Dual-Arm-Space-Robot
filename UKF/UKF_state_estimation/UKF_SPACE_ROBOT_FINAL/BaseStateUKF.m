function [Phi, Theta, Psi, V_x, V_y, V_z, W_x, W_y, W_z] = BaseStateUKF(z,t,r0,mt)
%
%
persistent Q R
persistent x P
persistent n m
persistent firstRun

if isempty(firstRun)
    
   Q=eye(9);
  
   R=eye(9);

%    R=[0.0001 0 0 0 0 0;
%       0 0.0001 0 0 0 0;
%       0 0 0.0001 0 0 0;
%       0 0 0 0.0001 0 0;
%       0 0 0 0 0.0001 0;
%       0 0 0 0 0      1];
  
%   R=randn(6,6);

  x = [0;0; 0 ;0 ;0; 0; 0; 0; 0];  
  P = 1*eye(9);
  
  n = 9;
  m = 9;
  
  firstRun = 1;  
end

[Xi W] = SigmaPoints(x, P, 0);

fXi = zeros(n, 2*n+1);
for k = 1:2*n+1
  fXi(:, k) = fx(Xi(:,k),t,r0,mt);
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

Phi   = x(1);
Theta = x(2);
Psi   = x(3);
V_x   = x(4);
V_y   = x(5);
V_z   = x(6);
W_x   = x(7);
W_y   = x(8);
W_z   = x(9);


%------------------------------

function xp = fx(x,t,r0,mt)

    [th1,th2,th3,th4,th5,th6,dth1,dth2,dth3,dth4,dth5,dth6]=Trajectory(t);
        
    [Ib_1,Ibm_1,M]=verify_coupled_param_mtum(th1,th2,th3,th4,th5,th6);
    
    dth=[dth1;dth2;dth3;dth4;dth5;dth6];
    
    JJ=[zeros(3,1);cross(r0,mt)];
     
    prod=-inv(Ib_1)*( (Ibm_1*dth) + JJ);
        
    x_t=prod;
    
%     x_t=prod+0.0001*randn(6,1);

    mm=inv(M)*[x_t(4);x_t(5);x_t(6)];
    
    EU=mm*t;
    
%     xp=x+EU;
%     +0.0001*randn(6,1);

    k1=[x_t(1);x_t(2);x_t(3)];
    
%     k2=[x_t(4);x_t(5);x_t(6)];
%     mm=inv(M)*k2;
%     jk=[EU;k1;mm];

    jk=[EU;prod];
    
    jk1=jk+0.0001*randn(9,1);

    xp=x+jk1;
%-------------------------------------------------------------------
function yp = hx(x)

yp=eye(9)*[x(1);x(2);x(3);x(4);x(5);x(6);x(7);x(8);x(9)];