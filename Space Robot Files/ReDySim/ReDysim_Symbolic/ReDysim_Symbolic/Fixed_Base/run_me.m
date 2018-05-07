% ReDySim main module. Use this module to generate equations of motion
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
% Contact: surilvshah@mail.com or saha@mech.iitd.ac.in
function []=run_me()
clear all;
fclose all;
clc;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Enter DH parameters and Inertia propoerties below
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[q,dq,ddq,n,alp,a,bb,thh,bt,r,dx,dy,dz,m,gr,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx]=inputs();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generation of the symbolic expressions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('------------------------------------------------------------------');
disp('ReDySim Symbolic Module: Fixed-base Systems');
disp('-------------------------------------------------------------------')
disp('Generating Equations of Motion')
tic
[tu] = invdyn (q,dq,ddq,n,alp,a,bb,thh,bt,r,dx,dy,dz,m,gr,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx);
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Symbolic Simplifications and writing into file equation_of_motoin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('-------------------------------------------------------------------')
disp('Performing Symbolic Simplification')
[tau] = simplify(tu);
disp('-------------------------------------------------------------------')
disp('Writing the simplified equation into the file named equaiton_of_motion')
fid = fopen('equation_of_motion.m','w');
for i=1:n
    if r(i)==1
        taui = char(tau(i)) ;
        fprintf(fid,'torque_%d = ',i);
        fprintf(fid,'%s\n\n',taui);
    else
        taui = char(tau(i)) ;
        fprintf(fid,'force_%d = ',i);
        fprintf(fid,'%s\n\n',taui);
    end
end
fclose all;
disp('-------------------------------------------------------------------')
disp('Thank you for using ReDySim Symolic Module');
disp('Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi ');
disp('------------------------------------------------------------------');