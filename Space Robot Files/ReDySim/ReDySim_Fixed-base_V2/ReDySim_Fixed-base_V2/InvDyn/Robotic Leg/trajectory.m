% ReDySim trajectory module. The desired indpendent joint trejectories are 
% enterd here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [thi dthi ddthi]= trajectory(tim, dof, Tp)
%Enter trejectories here

%Constant angular velocity
omega=45;
dthi(1:dof)=omega*2*pi/60;
ddthi(1:dof)=0;
thi(1:dof)=dthi(1:dof)*tim;
% trj=[th1;dth1;ddth1];
