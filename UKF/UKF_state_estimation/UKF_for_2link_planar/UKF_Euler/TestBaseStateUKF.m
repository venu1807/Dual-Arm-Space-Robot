clear all

Nsamples = 301;
BaseStateSaved = zeros(Nsamples, 3);
zsaved=zeros(Nsamples,3);

dt = 0.1;

u=load('statevar.dat');
% z1=[u(:,9);u(:,10);u(:,11);u(:,14);u(:,13);u(:,12)]+0.0001*randn(6,1);

for k=1:Nsamples
  
%   [th_1, th_2] = Getjoint_posi();
%   
%   [dth_1 ,dth_2] = Getjoint_vel();
%   
%   [phi, theta, psi] = GetBase_angular_posi();
%   
%   [dx0 , dy0 , dz0] = GetBase_linear_vel();
%   
%   [wx , wy , wz]    = GetBase_angular_vel();

  z=[u(k,4);u(k,5);u(k,6)] +0.0001.*randn(3,1);
  
  [phi theta si] = BaseStateUKF(z,dt);
  
  BaseStateSaved(k, :) = [phi theta si ];
  zsaved(k,:)=z';
  
end 



t = 0:dt:Nsamples*dt-dt;


% figure
% plot(t, BaseStateSaved(:,1),)
% hold on
% plot(t,u(:,9));
% 
% figure
% plot(t, BaseStateSaved(:,2))
% 
% figure
% plot(t, BaseStateSaved(:,3))
% 
% figure
% plot(t, BaseStateSaved(:,4))
% 
% figure
% plot(t, BaseStateSaved(:,5))
% 
% figure
% plot(t, BaseStateSaved(:,6))


close all;
figure; set(gcf,'Color','White');
 
subplot(3,1,1); hold on; box on;
plot(t, BaseStateSaved(:,1), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,1), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('phi0(rad)');
legend('True', 'measured');
% 
% 
subplot(3,1,2); hold on; box on;
plot(t, BaseStateSaved(:,2), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,2), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('theta0(rad)');
legend('True', 'measured');
 
subplot(3,1,3); hold on; box on;
plot(t, BaseStateSaved(:,3), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,3), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('si0(rad)');
legend('True', 'measured');
 

% subplot(3,2,4); hold on; box on;
% plot(t, BaseStateSaved(:,4), 'b-', 'LineWidth', 2);
% plot(t, zsaved(:,4), 'g-.', 'LineWidth', 2)
% set(gca,'FontSize',12);
% xlabel('Time (Seconds)');ylabel('sidot(rad/sec))');
% legend('True', 'measured');
%  
% 
% subplot(3,2,5); hold on; box on;
% plot(t, BaseStateSaved(:,5), 'b-', 'LineWidth', 2);
% plot(t, zsaved(:,5), 'g-.', 'LineWidth', 2)
% set(gca,'FontSize',12);
% xlabel('Time (Seconds)');ylabel('thetadot(rad/sec))');
% legend('True', 'measured');
%  
% subplot(3,2,6); hold on; box on;
% plot(t, BaseStateSaved(:,6), 'b-', 'LineWidth', 2);
% plot(t, zsaved(:,6), 'g-.', 'LineWidth', 2)
% set(gca,'FontSize',12);
% xlabel('Time (Seconds)');ylabel('phidot(rad/sec))');
% legend('True', 'measured');
 












 
% subplot(3,2,2); hold on; box on;
% plot(tArray, xArray(2,:), 'b-', 'LineWidth', 2);
% plot(tArray, xhatArray(2,:), 'r:', 'LineWidth', 2);
% plot(tArray, u(:,10), 'g:', 'LineWidth', 2)
% set(gca,'FontSize',12);
% xlabel('Time (Seconds)');ylabel('ydot(m/sec)');
% legend('True', 'Estimated','measured');
%  
% subplot(3,2,3); hold on; box on;
% plot(tArray, xArray(3,:), 'b-', 'LineWidth', 2);
% plot(tArray, xhatArray(3,:), 'r:', 'LineWidth', 2);
% plot(tArray, u(:,11), 'g:', 'LineWidth', 2);
% set(gca,'FontSize',12); 
% xlabel('Time (Seconds)'); ylabel('zdot(m/sec)');
% legend('True', 'Estimated','measured');
%  
% subplot(3,2,4); hold on; box on;
% plot(tArray, xArray(4,:), 'b-', 'LineWidth', 2);
% plot(tArray,xhatArray(4,:), 'r:', 'LineWidth', 2)
% plot(tArray, u(:,14), 'g:', 'LineWidth', 2)
% set(gca,'FontSize',12); 
% xlabel('Time (Seconds)'); ylabel('dpsi(rad/sec)');
% legend('True', 'Estimated','measured');
%  
% subplot(3,2,5); hold on; box on;
% plot(tArray, xArray(5,:), 'b-', 'LineWidth', 2);
% plot(tArray,xhatArray(5,:), 'r:', 'LineWidth', 2)
% plot(tArray, u(:,13), 'g:', 'LineWidth', 2)
% set(gca,'FontSize',12); 
% xlabel('Time (Seconds)'); ylabel('dtheta0(rad/sec)');
% legend('True', 'Estimated','measured');
% 
% subplot(3,2,6); hold on; box on;
% plot(tArray, xArray(6,:), 'b-', 'LineWidth', 2);
% plot(tArray,xhatArray(6,:), 'r:', 'LineWidth', 2)
% plot(tArray, u(:,12), 'g:', 'LineWidth', 2)
% set(gca,'FontSize',12); 
% xlabel('Time (Seconds)'); ylabel('dphi0(rad/sec)');
% legend('True', 'Estimated','measured');
% 


