% ReDySim torque module. The control algorithm is entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [tau_d] = torque(t,tf, n, dof, q,dq)

% % Free Simulatoin
% tau_d=zeros(n,1);

% Force Simulation: Set point PD control
tau_d=zeros(n,1);
qd=-2*pi;
dqd=0;
kp=49;kd=14;
tau_d(1)=kp*(qd-q(1))+kd*(dqd-dq(1));

end

