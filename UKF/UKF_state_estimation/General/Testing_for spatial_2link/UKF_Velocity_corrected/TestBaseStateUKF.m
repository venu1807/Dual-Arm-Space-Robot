function []=TestBaseStateUKF(i)

b=load('timevar.dat');

Nsamples = length(b);

BaseStateSaved = zeros(Nsamples, 6);

zsaved=zeros(Nsamples,6);

dt = 0.1;

u=load('statevar.dat');
% z1=[u(:,9);u(:,10);u(:,11);u(:,14);u(:,13);u(:,12)]+0.0001*randn(6,1);

for k=1:Nsamples
  
%   z=[u(k,9);u(k,10);u(k,11);u(k,12);u(k,13);u(k,14)]+0.0001.*randn(6,1); %change measured state(z) according to statevar.dat file
  z=[u(k,7+i);u(k,8+i);u(k,9+i);u(k,10+i);u(k,11+i);u(k,12+i)]+0.0001.*randn(6,1);
  
  [d_x0, d_y0,  d_z0,  w_x , w_y,  w_z] = BaseStateUKF(z,dt);
  
  BaseStateSaved(k, :) = [d_x0  d_y0  d_z0  w_x  w_y   w_z ];
  
  zsaved(k,:)=z';
  
end 

t = 0:dt:Nsamples*dt-dt;

close all;
figure; set(gcf,'Color','White');
 
subplot(3,2,1); hold on; box on;
plot(t, BaseStateSaved(:,1), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,1), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('xdot(m/sec)');
legend('True', 'measured');
% 
% 
subplot(3,2,2); hold on; box on;
plot(t, BaseStateSaved(:,2), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,2), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('ydot(m/sec)');
legend('True', 'measured');
 
subplot(3,2,3); hold on; box on;
plot(t, BaseStateSaved(:,3), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,3), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('zdot(m/sec)');
legend('True', 'measured');
 

subplot(3,2,4); hold on; box on;
plot(t, BaseStateSaved(:,4), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,4), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('phidot(rad/sec)');
legend('True', 'measured');
 

subplot(3,2,5); hold on; box on;
plot(t, BaseStateSaved(:,5), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,5), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('thetadot(rad/sec)');
legend('True', 'measured');
 
subplot(3,2,6); hold on; box on;
plot(t, BaseStateSaved(:,6), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,6), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('sidot(rad/sec)');
legend('True', 'measured');
 





