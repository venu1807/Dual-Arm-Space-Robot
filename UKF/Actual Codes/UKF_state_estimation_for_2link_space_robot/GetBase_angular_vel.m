function [wx wy wz] = GetBase_angular_vel()
%
%
persistent w_x w_y w_z
persistent k firstRun


if isempty(firstRun) 
  load Base_angular_velocity
  k = 1;
  
  firstRun = 1;
end
wx = w_x(k);
wy = w_y(k);
wz = w_z(k);
  
k = k + 1;
