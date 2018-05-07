% M=load('mtvar.dat');
% T=load('timevar.dat');

clear all;
close all;
clc

%Data generation

q=load('statevar.dat');
t=load('timevar.dat');
m=load('mtvar.dat');

len_t = length(t);

r0 = q(:,1:3);       %CM position of the base

th0 = q(:,4);        %CM angular position of the base

th1 = q(:,7);        %Joint1 position

dr0 = q(:,8:10);     %CM linear velocity of the base

dth0= q(:,11);       %CM angular velocity of the base

dth1= q(:,14);      %Joint1 velocity

Px = m(:,1);
Py = m(:,2);
Py = m(:,3);

Lx = m(:,4);
Ly = m(:,5);
Lz = m(:,6);



figure(1)
subplot(2,1,1);

hold on
plot(t,q(:,1),'r','DisplayName','x0');

hold on
plot(t,q(:,2),'b','DisplayName','y0');

hold on
plot(t,q(:,3),'k','DisplayName','z0');

% xlabel('Time(sec)')
% ylabel('"x,Py,Pz"(N-s)');
% title('Linear Momentum(N-s)');
legend('show')
% 

subplot(2,1,2);

hold on
plot(t,q(:,9),'c','DisplayName','dx0');

hold on
plot(t,q(:,10),'m','DisplayName','dy0');

hold on
plot(t,q(:,11),'g','DisplayName','dz0');

% xlabel('Time(sec)')
% ylabel(' "Lx,Ly,Lz"(Nm-s)');
% title('Angular Momentum(Nm-s)');
legend('show')


figure(2)
subplot(2,1,1);

hold on
plot(t,m(:,1),'r','DisplayName','Px');

hold on
plot(t,m(:,2),'b','DisplayName','Py');

hold on
plot(t,m(:,3),'k','DisplayName','Pz');

xlabel('Time(sec)')
ylabel('"Px,Py,Pz"(N-s)');
title('Linear Momentum(N-s)');
legend('show')


subplot(2,1,2);

hold on
plot(t,m(:,4),'c','DisplayName','Lx');

hold on
plot(t,m(:,5),'m','DisplayName','Ly');

hold on
plot(t,m(:,6),'g','DisplayName','Lz');

xlabel('Time(sec)')
ylabel(' "Lx,Ly,Lz"(Nm-s)');
title('Angular Momentum(Nm-s)');
legend('show')


figure(3)
subplot(2,1,1);

hold on
plot(t,q(:,4),'r','DisplayName','th0');

hold on
plot(t,q(:,5),'b','DisplayName','phi0');

hold on
plot(t,q(:,6),'k','DisplayName','psi0');

% xlabel('Time(sec)')
% ylabel('"x,Py,Pz"(N-s)');
% title('Linear Momentum(N-s)');
 legend('show')
% 

subplot(2,1,2);

hold on
plot(t,q(:,12),'c','DisplayName','dth0');

hold on
plot(t,q(:,13),'m','DisplayName','dphi0');

hold on
plot(t,q(:,14),'g','DisplayName','dpsi0');

% xlabel('Time(sec)')
% ylabel(' "Lx,Ly,Lz"(Nm-s)');
% title('Angular Momentum(Nm-s)');
 legend('show')
 
 figure(4)
subplot(2,1,1);

hold on
plot(t,q(:,7),'r','DisplayName','th1');

hold on
plot(t,q(:,8),'b','DisplayName','th2');

% hold on
% plot(t,q(:,6),'k','DisplayName','psi0');

% xlabel('Time(sec)')
% ylabel('"x,Py,Pz"(N-s)');
% title('Linear Momentum(N-s)');
 legend('show')
% 

subplot(2,1,2);

hold on
plot(t,q(:,15),'c','DisplayName','dth1');

hold on
plot(t,q(:,16),'m','DisplayName','dth2');

% hold on
% plot(t,q(:,14),'g','DisplayName','dpsi0');

% xlabel('Time(sec)')
% ylabel(' "Lx,Ly,Lz"(Nm-s)');
% title('Angular Momentum(Nm-s)');
 legend('show')
 
figure(5)
subplot(2,1,1)
plot(t,q(:,17),'r','DisplayName','Actuator Energy');
legend('show')