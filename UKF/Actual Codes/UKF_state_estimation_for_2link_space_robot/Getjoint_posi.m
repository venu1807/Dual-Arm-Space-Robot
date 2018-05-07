function [th_1 th_2] = Getjoint_posi()
%
%
persistent th1 th2
persistent k firstRun


if isempty(firstRun) 
  load Joint_position
  k = 1;
  
  firstRun = 1;
end
th_1 = th1(k);
th_2 = th2(k);
  
k = k + 1;
