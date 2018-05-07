% ReDySim torque module. The control algorithm is entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [ tu_q tu_th ddqq] = torque(s, n, q, th, dq, dth, qq, dqq)

% %A: Free simulaiton
% tu_th=zeros(n-1,1);
% tu_q=[0;0;0;0;0;0];

%B: Force Simulation
%Desired Joint trejectory
[th_d dth_d ddth_d]=trajectory(s);

% % 1: Simple PD
% kp=49; kv=14;
% tu_th=kp*(thd(2:n)-th(2:n))+kv*(dthd(2:n)-dth(2:n));
% tu_q=[0;0;0;0;0;0];
% tue=[tu_q; tu_th];

% %2: Feed forward
% thd=th_d;dthd=dth_d;ddthd=[0;ddth_d];
% qd=qq;dqd=dqq;
% [n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop]=inputs();
% [tu_th ddqq] = invdyn_float(qd, dqd, thd, dthd,ddthd, n,alp,a,b,bt,dx,dy,dz,al,alt, m,g,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx, g_prop);
% kp=49; kv=14;
% tu_th=tu_th+kp*(thd(2:n)-th(2:n))+kv*(dthd(2:n)-dth(2:n));
% tu_q=[0;0;0;0;0;0];
% tue=[tu_q; tu_th];

%3: Computed torque
kp=49; kv=14;
tus=ddth_d+kp*(th_d(2:n)-th(2:n))+kv*(dth_d(2:n)-dth(2:n));
ddth=[0;tus];
[n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop]=inputs();
[tu_th ddqq] = invdyn_float(q, dq, th, dth,ddth, n,alp,a,b,bt,dx,dy,dz,al,alt, m,g,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx, g_prop);
tu_q=[0;0;0;0;0;0];

end

