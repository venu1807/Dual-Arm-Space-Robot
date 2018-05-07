% ReDySim sys_ode. This module contains ODE of system under study
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function dy=sys_ode(s,y)

%Model parameter
[n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx g_prop]=inputs();

q=y(1:6);
dq=y(6+1:2*6);
disp(s);

% Trajectories
[thh dthh ddthh ]=trajectory(s);
th=thh;dth=dthh;

% C+Tug- TERM USING INVERSE DYNAMIC ALGORITHM
ddth=[0;ddthh];
[tu ddq grnden] = invdyn_float(q, dq, th, dth,ddth, n,alp,a,b,bt,dx,dy,dz,al,alt, m,g,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx, g_prop);


%Accelerations
dy=zeros(2*6+2,1);
dy(1:6)=dq;
dy(6+1:2*6)=ddq;

% deriv of ground energy (ground reaction force*velocity)
dy(2*6+1)=-(grnden);

% deriv of joint energy
dy(2*6+2)=-tu'*dth(2:n); 
%%%%%%%%%%%%%%%%%%% hopon.m ends %%%%%%%%%%%%%%%%%%%%
