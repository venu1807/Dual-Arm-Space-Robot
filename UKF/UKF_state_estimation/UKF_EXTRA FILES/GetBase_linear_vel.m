function [dx0 dy0 dz0] = GetBase_linear_vel()
%
%
persistent v_x v_y v_z
persistent k firstRun


if isempty(firstRun) 
  load Base_linear_velocity
  k = 1;
  
  firstRun = 1;
end
dx0 = v_x(k);
dy0 = v_y(k);
dz0 = v_z(k);
  
k = k + 1;
