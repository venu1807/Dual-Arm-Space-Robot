% ReDySim main module. Use this module to run your program
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
% Contact: surilvshah@mail.com or saha@mech.iitd.ac.in
function [] = run_me()
clear all;
fclose all;
clc;
%Use this file to run your program
%Run the main code
runinv;
%Plots the input joint motion
plot_motion;
%Plot the joint torques
plot_tor;
%Animate trajectory
animate;

disp('------------------------------------------------------------------');
disp('Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi ');
disp('Thank you for using ReDySim');
disp('------------------------------------------------------------------');
