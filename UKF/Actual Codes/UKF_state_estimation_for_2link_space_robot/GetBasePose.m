function [x y z] = GetBasePose()
%
%
persistent c_x c_y c_z
persistent k firstRun


if isempty(firstRun) 
  load Base_position
  k = 1;
  
  firstRun = 1;
end

x = c_x(k);
y = c_y(k);
z = c_z(k);
  
k = k + 1;
