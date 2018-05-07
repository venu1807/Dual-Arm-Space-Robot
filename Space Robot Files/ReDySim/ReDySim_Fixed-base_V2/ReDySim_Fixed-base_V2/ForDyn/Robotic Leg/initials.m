% ReDySim initials module. The initial conditions are entered in this module
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function[n, y0, ti, tf, incr, rtol, atol, int_type] = initials()

%System: Mutli closed-loop robotic leg
%Number of links
[n ]=inputs(); 

% Initial condition here
%Mutli closed-loop robotic leg
q=[ 0;  4.5110;  -2.7389;  -0.8764;  -1.4604;  -1.4604;  -1.6812];
% dq=[-4.7124; 4.7124;  0;  8.0513; -3.0970; -3.0970; 3.0970];
dq=[0; 0;  0;  0; 0; 0; 0];

act_en=0;

y0=[q; dq; act_en];

%Time span
ti=0;
tf=1.33;
incr=.01; %Sampling time for adaptive solver and step size for fixed step solver

%Relative and absolute tolerance for ode45
rtol=1e-4;
atol=1e-6;
int_type=0; %0 for ode45, 1 for ode15s, 2 for ode5
end
