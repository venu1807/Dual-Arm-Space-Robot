% ReDySim main module. Use this module to generate equations of motion
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi
% Contact: surilvshah@mail.com or saha@mech.iitd.ac.in
function []=run_me()
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Enter DH parameters and Inertia propoerties below
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [q th n alp a b bt dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx]=inputs();

% [n alp a b bt dx dy dz al alt m g Icxx Icyy Iczz Icxy Icyz Iczx]=inputs();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generation of the symbolic expressions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('------------------------------------------------------------------');
disp('ReDySim Symbolic Module: Floating-Base Systems');
disp('-------------------------------------------------------------------')
disp('Generating Equations of Motion')
tic
[KL] = Jacobian_vom12()
% [base_eq tu] = invdyn_float (q, dq, ddq, th, dth,ddth, n,alp,a,b,bt,dx,dy,dz, m,g,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx);
toc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Symbolic Simplifications and writing into file equation_of_motoin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('-------------------------------------------------------------------')
% disp('Performing Symbolic Simplification')
% % vpa(Ib)
% % vpa(Ibm)
%  IB = simplify(Ib);
%  IBM=simplify(Ibm);
% % disp('-------------------------------------------------------------------')
%  disp('Writing the simplified equations into the file named equaiton_of_motion')
%  fid1 = fopen('Hb.m','w'); 
% %  fprintf(fid1,'%s\n\n',char(Ib));
%  
% %  fid2 = fopen('Hbm.m','w'); 
% %  fprintf(fid2,'%s\n\n',char(Ibm));
%  
% IB=zeros(6,6);
% for i=1:6
%     for j=1:6
%      IB(i,j) = char(Ib(i,j)) ;
%      fprintf(fid1,' %s\n\n',IB);
%     end
% end
% % 
% % for i=1:n-1
% %     taui = char(tau(i)) ;
% %     fprintf(fid,'torque_%d = ',i);
%    
% % end
% % fclose all;
% % disp('-------------------------------------------------------------------')
% % disp('Thank you for using ReDySim Symolic Module');
% % disp('Contributors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi ');
% % disp('------------------------------------------------------------------');