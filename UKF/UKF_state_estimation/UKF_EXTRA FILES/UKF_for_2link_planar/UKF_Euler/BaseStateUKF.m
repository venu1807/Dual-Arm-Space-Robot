function [phi,theta,si] = BaseStateUKF(z,t)
%
%
persistent Q R
persistent x P
persistent n m
persistent firstRun

if isempty(firstRun)
    
   Q=eye(3);
  
   R=eye(3);

%    R=[0.0001 0 0 0 0 0;
%       0 0.0001 0 0 0 0;
%       0 0 0.0001 0 0 0;
%       0 0 0 0.0001 0 0;
%       0 0 0 0 0.0001 0;
%       0 0 0 0 0      1];
  
%   R=randn(6,6);

  x = [0;0; 0 ];  
  P = 1*eye(3);
  
  n = 3;
  m = 3;
  
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

x = xp + K*(z - zp);
P = Pp - K*Pz*K';


phi   = x(1);
theta  = x(2);
si   = x(3);
% W_x   = x(4);
% W_y   = x(5);
% W_z   = x(6);


%------------------------------

function xp = fx(x,t)

    thin=[0.3803;   -0.6198;    1.2867]; %60
    thf=[-pi/2; -pi/2; -pi/2];
    tf=30;
    Tp=tf;
    n=3;
    for i=1:n-1
            thi(i,1)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
            dthi(i,1)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
    end
    ua = thi(1);
    ub = thi(2);
        
    dth1=dthi(1);
    dth2=dthi(2);
        
    [prod_term,M]=verify_coupled_param_mtum(ua,ub);
        
     dth=[dth1;dth2];
     
     x_t=prod_term*dth+0.0001*randn(6,1);
     EU=M*[x_t(4);x_t(5);x_t(6)]*t;

     xp=x+EU;
%-------------------------------------------------------------------
function yp = hx(x)

yp=eye(3)*[x(1);x(2);x(3)];