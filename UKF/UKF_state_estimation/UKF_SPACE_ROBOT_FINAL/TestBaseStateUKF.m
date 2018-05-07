function TestBaseStateUKF()

close all;

clear all;

[n]=inputs

i=n-1;

b=load('timevar.dat');

Nsamples = length(b);

BaseStateSaved = zeros(Nsamples, 9);

zsaved=zeros(Nsamples,9);

dt = 0.1;

u=load('statevar.dat');

mt=load('mtvar.dat');

for k=1:Nsamples
  
%    z=[u(k,13);u(k,14);u(k,15);u(k,16);u(k,17);u(k,18)]+0.0001.*randn(6,1);

%   [th1,th2,th3,th4,th5,th6,dth1,dth2,dth3,dth4,dth5,dth6]=Trajectory(dt);
%         
%   [Ib_1,Ibm_1,M]=verify_coupled_param_mtum(th1,th2,th3,th4,th5,th6);
  
%   wb=M*[u(k,10+i);u(k,11+i);u(k,12+i)];
  
  z=[u(k,4);u(k,5);u(k,6);u(k,7+i);u(k,8+i);u(k,9+i);u(k,10+i);u(k,11+i);u(k,12+i)]+0.0001.*randn(9,1);
  
  r0=[u(k,1);u(k,2);u(k,3)];
  
  Mt=[mt(k,1);mt(k,2);mt(k,3)];
  
  [phi, theta, psi, d_x0, d_y0,  d_z0,  w_x , w_y,  w_z] = BaseStateUKF(z,dt,r0,Mt);
  
  BaseStateSaved(k, :) = [phi theta psi d_x0  d_y0  d_z0  w_x  w_y   w_z ];
  
  zsaved(k,:)=z';
  
end 

t = 0:dt:Nsamples*dt-dt;

close all;

figure; 

set(gcf,'Color','White');
 
subplot(3,1,1); hold on; box on;
plot(t, BaseStateSaved(:,1), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,1), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('Phi(rad)');
legend('True', 'measured');
% 
% 
subplot(3,1,2); hold on; box on;
plot(t, BaseStateSaved(:,2), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,2), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('Theta(rad)');
legend('True', 'measured');
 
subplot(3,1,3); hold on; box on;
plot(t, BaseStateSaved(:,3), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,3), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('Psi(rad)');
legend('True', 'measured');
 
figure;
set(gcf,'Color','White');

subplot(3,1,1); hold on; box on;
plot(t, BaseStateSaved(:,4), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,4), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('V_x(m/sec)');
legend('True', 'measured');
 

subplot(3,1,2); hold on; box on;
plot(t, BaseStateSaved(:,5), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,5), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('V_y(m/sec)');
legend('True', 'measured');
 
subplot(3,1,3); hold on; box on;
plot(t, BaseStateSaved(:,6), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,6), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('V_z(m/sec)');
legend('True', 'measured');
 
figure;
set(gcf,'Color','White');

subplot(3,1,1); hold on; box on;
plot(t, BaseStateSaved(:,7), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,7), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('W_x(rad/sec)');
legend('True', 'measured');

subplot(3,1,2); hold on; box on;
plot(t, BaseStateSaved(:,8), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,8), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('W_y(rad/sec)');
legend('True', 'measured');

subplot(3,1,3); hold on; box on;
plot(t, BaseStateSaved(:,9), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,9), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('W_z(rad/sec)');
legend('True', 'measured');



