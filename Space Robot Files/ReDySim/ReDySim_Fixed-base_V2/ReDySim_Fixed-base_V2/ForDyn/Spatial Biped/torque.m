% ReDySim torque module. The control algorithm is entered here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [tau_d] = torque(t,tf, n, dof, th,dth)
% Driving Torque
% Desired trejectories
[thh,dthh,ddthh]=trajectory(t);

% Computed torque control
kp=225;kv=40;
tus=ddthh+kp*(thh(1:n)-th(1:n))+kv*(dthh(1:n)-dth(1:n));
 thd=th;dthd=dthh;ddthd=tus;
[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs();
[tau_d] = invdyn_tree_eff(thd,dthd,ddthd,n,alp,a,b,th,bt,r,dx,dy,dz,m,g,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx);

end

