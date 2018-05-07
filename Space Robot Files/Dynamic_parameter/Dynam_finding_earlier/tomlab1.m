Name='LSSOL test example';

% In TOMLAB it is best to use Inf and -Inf, not big numbers.
n = 9;  % Number of unknown parameters
x_L = [-2 -2 -Inf, -2*ones(1,6)]';
x_U = 2*ones(n,1);

A   = [ ones(1,8) 4; 1:4,-2,1 1 1 1; 1 -1 1 -1, ones(1,5)];
b_L = [2    -Inf -4]';
b_U = [Inf    -2 -2]';

y = ones(10,1);
C = [ ones(1,n); 1 2 1 1 1 1 2 0 0; 1 1 3 1 1 1 -1 -1 -3; ...
      1 1 1 4 1 1 1 1 1;1 1 1 3 1 1 1 1 1;1 1 2 1 1 0 0 0 -1; ...
      1 1 1 1 0 1 1 1 1;1 1 1 0 1 1 1 1 1;1 1 0 1 1 1 2 2 3; ...
      1 0 1 1 1 1 0 2 2];

x_0 = 1./[1:n]';

t          = [];   % No time set for y(t) (used for plotting)
weightY    = [];   % No weighting
weightType = [];   % No weighting type set
x_min      = [];   % No lower bound for plotting
x_max      = [];   % No upper bound for plotting

Prob = llsAssign(C, y, x_L, x_U, Name, x_0, t, weightType, weightY, ...
                 A, b_L, b_U,  x_min, x_max);

Result  = tomRun('lsei',Prob,2);