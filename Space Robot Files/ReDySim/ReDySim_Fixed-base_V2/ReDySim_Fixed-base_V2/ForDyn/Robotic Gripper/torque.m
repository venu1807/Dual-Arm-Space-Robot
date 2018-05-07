% ReDySim torque module. The control algorithm is entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [tau_d] = torque(t,tf, n, dof, q,dq)

% % Free Simulatoin
% tau_d=zeros(n,1);

% Force Simulation: Trajectory following PD control
[qd dqd ]= trajectory(t,dof, tf);
kp=16;kd=8;
for i=1:dof
    tau_d(i,1)=kp*(qd(i)-q(i))+kd*(dqd(i)-dq(i));
end

end

