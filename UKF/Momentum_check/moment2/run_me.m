% Verifies that the coupled parameters are the minimal parameters by
% constructing the momentum model with two sets of decoupled parameters
% which give the same coupled parameters
clear all; close all; clc;

u=load('statevar.dat');
T=load('timevar.dat');
mt=load('mtvar.dat');
k=length(T);

% qr=zeros(6, 1); % Fix an arbitrary pose
% thr=[0, pi/6, pi/3]; % Fix arbitrary joint angles
ane=[1; 0; 0];

% Case-1
[n, nq, alp, a, b, bt, dx, dy, dz, al, alt, m, g,  Icxx, Icyy, Iczz, Icxy, Icyz, Iczx]=inputs_case1_3_link();
% [n, nq, alp, a, b, bt, dx, dy, dz, al, alt, m, g,  Icxx, Icyy, Iczz, Icxy, Icyz, Iczx]=inputs_try_set_1();
ee=n;
kl=zeros(k,6);

for t=1:k
 
 qr=u(t,1:6);
 
 thr=[0 u(t,7:8)];
    
[Ib_1, Im_1, Ibm_1, Jbe_1, Jme_1, GJM_1, Jg2_1] = Jacobian_vom(qr,thr,n,alp,a,b,bt,dx,dy,dz,m,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx, ee, ane);
% Ib_1_tilde = Ib_1(4 : 6, 4 : 6) - (Ib_1(4 : 6, 1 : 3) * Ib_1(4 : 6, 1 : 3)) / Ib_1(1, 1)
% Ibm_1_tilde = Ibm_1(4 : 6, :) - (Ib_1(4 : 6, 1 : 3) * Ibm_1(1 : 3, :)) / Ib_1(1, 1)
% prod_term_1 = inv(Ib_1) * Ibm_1

% vb=u(t,9:11)';
% 
% theta=u(t,5);
% psi=u(t,6);
% 
% % M=[-sin(psi)*cos(theta)  cos(psi)     0;
% %     sin(theta)                0       1;
% %     cos(psi)*cos(theta)  sin(psi)     0];
% % 
% % phib=[u(t,12) 0 0];
% % 
% % wb=M*phib';
% 
% wb=[0 0 u(t,12)]';
% 
% V=[vb; wb];

dth=u(t,15:16)';



kl(t,:)=-inv(Ib_1)*Ibm_1*dth;

M
K


% O=zeros(3,1);
% 
% % kl(t,:)=[O; cross(qr(1:3),mt(k,1:3))'];
% 
% 
% JJ=Ib_1*V + Ibm_1*dth + [O; cross(qr(1:3),mt(k,1:3))'];
%  
% kl(t,:)=JJ;
% Ibm_1

end

kl;

figure
subplot(2,1,1)
plot(T,kl(:,1))%t vs Px from GJM file
subplot(2,1,2)
plot(T,u(:,9))%t vs Px from mtvar.dat file

figure

subplot(2,1,1)
plot(T,kl(:,2))%t vs Px from GJM file
subplot(2,1,2)
plot(T,u(:,10))%t vs Px from mtvar.dat file

figure

subplot(2,1,1)
plot(T,kl(:,6))%t vs Px from GJM file
subplot(2,1,2)
plot(T,u(:,12))%t vs Px from mtvar.dat file
% %  plot(T,u(:,15:16))
% 
% 
% 
% 
% % % Case-2
% % [n, nq, alp, a, b, bt, dx, dy, dz, al, alt, m, g,  Icxx, Icyy, Iczz, Icxy, Icyz, Iczx]=inputs_case2_3_link();
% % % [n, nq, alp, a, b, bt, dx, dy, dz, al, alt, m, g,  Icxx, Icyy, Iczz, Icxy, Icyz, Iczx]=inputs_try_set_2();
% % [Ib_2, Im_2, Ibm_2, Jbe_2, Jme_2, GJM_2, Jg2_2] = Jacobian_vom(qr,thr,n,alp,a,b,bt,dx,dy,dz,m,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx, ee, ane);
% Ib_2_tilde = Ib_2(4 : 6, 4 : 6) - (Ib_2(4 : 6, 1 : 3) * Ib_2(4 : 6, 1 : 3)) / Ib_2(1, 1);
% Ibm_2_tilde = Ibm_2(4 : 6, :) - (Ib_2(4 : 6, 1 : 3) * Ibm_2(1 : 3, :)) / Ib_2(1, 1);
% prod_term_2 = inv(Ib_2) * Ibm_2;
% 
% % Matrices of interest
% Ib_e_tilde = Ib_2_tilde - Ib_1_tilde
% Ibm_e_tilde = Ibm_2_tilde - Ibm_1_tilde
% prod_term_e = prod_term_2 - prod_term_1



% xhd=GJM*thetad;
% xbd=pinv(Jbe)*(xhd-Jme*thetad);
% res=[xbd; 0; thetad];