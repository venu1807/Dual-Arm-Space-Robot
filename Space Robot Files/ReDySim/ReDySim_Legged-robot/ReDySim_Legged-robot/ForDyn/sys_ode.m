% ReDySim sys_ode. This module contains ODE of system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function dy=sys_ode(t,y)
%Input data
[n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop]=inputs();
q=y(1:6);
th=y(6:6+n-1);
nqn=6+n;
dq=y(nqn:nqn+6-1);
dth=y(nqn+6-1:2*(n+6-1));
qq=y(2*(n+6-1)+3:2*(n+6-1)+8);
dqq=y(2*(n+6-1)+9:2*(n+6-1)+14);
disp(t);

%Joint torque
[tu_q tu_th ddqq]=torque(t, n, q, th, dq, dth, qq, dqq);
tue=[tu_q; tu_th];

%Method 1:Direct method
[ddy grnden]=fordyn_float(q, dq, th, dth, n,alp,a,b,bt,dx,dy,dz,al, alt, m,g,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx, g_prop, tu_q,tu_th);

dy=zeros(2*(n+6-1)+2,1);
dy(1:n+6-1)=y(n+6:2*(n+6-1));
dy(n+6:2*(n+6-1))=ddy;

% deriv of ground energy (ground reaction force*velocity)
dy(2*(n+6-1)+1)=-(grnden);

% deriv of joint energy
dy(2*(n+6-1)+2)=-tue'*dy(1:n+6-1);

%ddq for inverse dynamics
dy(2*(n+6-1)+3:2*(n+6-1)+8)=dqq;
dy(2*(n+6-1)+9:2*(n+6-1)+14)=ddqq;
%%%%%%%%%%%%%%%%%%% hopon.m ends %%%%%%%%%%%%%%%%%%%%