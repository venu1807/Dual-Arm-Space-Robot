function [phi theta psi] = GetBase_angular_posi()
%
%
persistent phi_x theta_y psi_z
persistent k firstRun


if isempty(firstRun) 
  load Base_angular_position
  k = 1;
  
  firstRun = 1;
end
phi = phi_x(k);
theta = theta_y(k);
psi = psi_z(k);
  
k = k + 1;
