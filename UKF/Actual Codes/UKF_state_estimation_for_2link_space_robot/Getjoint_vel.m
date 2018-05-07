function [dth_1 dth_2] = Getjoint_vel()
%
%
persistent dth1 dth2
persistent k firstRun


if isempty(firstRun) 
  load Joint_velocity
  k = 1;
  
  firstRun = 1;
end
dth_1 = dth1(k);
dth_2 = dth2(k);
  
k = k + 1;
