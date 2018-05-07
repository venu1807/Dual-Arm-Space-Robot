% ReDySim trajectory module. The desired indpendent joint trejectories are 
% enterd here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [qi dqi ddqi]= trajectory(tim)
%Enter trejectories here

%Constant angular velocity
omega=45;
dqi=omega*2*pi/60;
ddqi=0;
qi=dqi*tim;
% trj=[qi;dqi;ddqi];
