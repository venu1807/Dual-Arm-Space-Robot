function [] = TestBaseStateUKF()

b=load('timevar.dat');

Nsamples = length(b);

BaseStateSaved = zeros(Nsamples, 3);

zsaved=zeros(Nsamples,3);

dt = 0.1;

u=load('statevar.dat');

for k=1:Nsamples
  

  z=[u(k,4);u(k,5);u(k,6)] +0.0001.*randn(3,1);
  
  [phi theta si] = BaseStateUKF(z,dt);
  
  BaseStateSaved(k, :) = [phi theta si ];
  
  zsaved(k,:)=z';
  
end

t = 0:dt:Nsamples*dt-dt;

close all;
figure; set(gcf,'Color','White');
 
subplot(3,1,1); hold on; box on;
plot(t, BaseStateSaved(:,1), 'b-', 'LineWidth', 2);
plot(t, zsaved(:,1), 'g-.', 'LineWidth', 2)
set(gca,'FontSize',12);
xlabel('Time (Seconds)');ylabel('phi0(rad)');
legend('True', 'measured');

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
 














 



