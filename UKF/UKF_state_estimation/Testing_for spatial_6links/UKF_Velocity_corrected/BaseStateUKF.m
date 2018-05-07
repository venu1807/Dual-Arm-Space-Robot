function [V_x, V_y, V_z, W_x, W_y, W_z] = BaseStateUKF(z,t)
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

  x = [0;0; 0 ;0 ;0; 0];  
  P = 1*eye(6);
  
  n = 6;
  m = 6;
  
  firstRun = 1;  
end

[Xi W] = SigmaPoints(x, P, 0);

fXi = zeros(n, 2*n+1);
for k = 1:2*n+1
  fXi(:, k) = fx(Xi(:,k),t);
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

% thin=[0.3803;   -0.6198;    1.2867]; %60
% thf=[-pi/2; -pi/2; -pi/2];
% tf=30;
% Tp=tf;
% n=3;
% for i=1:n-1
%        thi(i,1)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
%        dthi(i,1)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
% end
% ua = thi(1);
% ub = thi(2);
% 
% [prod_term,M]=verify_coupled_param_mtum(ua,ub);
% 
% Z1=[zz(1);zz(2);zz(3)];
% Z2=M*[zz(4);zz(5);zz(6)];
% z=[Z1;Z2];

x = xp + K*(z - zp);
P = Pp - K*Pz*K';


V_x   = x(1);
V_y   = x(2);
V_z   = x(3);
W_x   = x(4);
W_y   = x(5);
W_z   = x(6);


%------------------------------

function xp = fx(x,t)

%     thin=[0.3803;   -0.6198;    1.2867;]; %60
%     thf=[-pi/2; -pi/2; -pi/2];
    thin=[0.3803;   -0.6198;    1.2867;    2.4411;    1.7062;   -1.0058];%60
    thf=[-0.2530;   -1.8050;   -0.0364;    3.3946;    1.8050;    0.0364];
    tf=30;
    Tp=tf;
    n=7;
    for i=1:n-1
            thi(i,1)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
            dthi(i,1)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
    end
    u1 = thi(1);
    u2 = thi(2);
    u3 = thi(3);
    u4 = thi(4);
    u5 = thi(5);
    u6 = thi(6);
    
        
    dth1=dthi(1);
    dth2=dthi(2);
    dth3=dthi(3);
    dth4=dthi(4);
    dth5=dthi(5);
    dth6=dthi(6);
        
    [prod_term M]=verify_coupled_param_mtum(u1,u2,u3,u4,u5,u6);
        
    dth=[dth1;dth2;dth3;dth4;dth5;dth6];
     
    x_t=prod_term*dth;
%     +0.0001*randn(6,1);
    k1=[x_t(1);x_t(2);x_t(3)];
    k2=[x_t(4);x_t(5);x_t(6)];
    mm=inv(M)*k2;
    
    jk=[k1;mm];
    
    jk1=jk+0.0001*randn(6,1);

    xp=x+jk1;
%-------------------------------------------------------------------
function yp = hx(x)

yp=eye(6)*[x(1);x(2);x(3);x(4);x(5);x(6)];