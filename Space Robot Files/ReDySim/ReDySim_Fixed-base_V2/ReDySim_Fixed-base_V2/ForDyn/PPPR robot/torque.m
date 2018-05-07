% ReDySim torque module. The control algorithm is entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [tau_d] = torque(t,tf, n, dof, q,dq)

% Free Simulation
tau_d=zeros(n,1);

%Force Simultion: Set point control
qd=[0.1; 0.1; 0.1; pi/2];
dqd=[0; 0; 0; 0];
kp=49;
kd=14;
tau_d(1)=kp*(qd(1)-q(1))+kd*(dqd(1)-dq(1));
tau_d(2)=kp*(qd(2)-q(2))+kd*(dqd(2)-dq(2));
tau_d(3)=kp*(qd(3)-q(3))+kd*(dqd(3)-dq(3));
tau_d(4)=kp*(qd(4)-q(4))+kd*(dqd(4)-dq(4));

% %Force Simultion:ajectory following control
% [qd dqd ddqd]= trajectory(t, dof, tf);
% kp=49;
% kd=14;
% tau_d(1)=kp*(qd(1)-q(1))+kd*(dqd(1)-dq(1));
% tau_d(2)=kp*(qd(2)-q(2))+kd*(dqd(2)-dq(2));
% tau_d(3)=kp*(qd(3)-q(3))+kd*(dqd(3)-dq(3));
% tau_d(4)=kp*(qd(4)-q(4))+kd*(dqd(4)-dq(4));
end

