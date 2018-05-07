% ReDySim trajectory module. The desired indpendent joint trejectories are 
% enterd here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [qi dqi ddqi]= trajectory(tim, dof, Tp)
%Enter trejectories here
%Constant angular velocity
omega=45;
dqi(1:dof)=omega*2*pi/60;
ddqi(1:dof)=0;
qi(1:dof)=dqi(1:dof)*tim;
% trj=[q1;dq1;ddq1];
