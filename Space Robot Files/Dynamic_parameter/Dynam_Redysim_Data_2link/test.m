M=load('mtvar.dat');
T=load('timevar.dat');

figure(1)
subplot(2,1,1);

hold on
plot(T,M(:,1),'r','DisplayName','Px');

hold on
plot(T,M(:,2),'b','DisplayName','Py');

hold on
plot(T,M(:,3),'k','DisplayName','Pz');

xlabel('Time(sec)')
ylabel('"Px,Py,Pz"(N-s)');
title('Linear Momentum(N-s)');
legend('show')


subplot(2,1,2);

hold on
plot(T,M(:,4),'c','DisplayName','Lx');

hold on
plot(T,M(:,5),'m','DisplayName','Ly');

hold on
plot(T,M(:,6),'g','DisplayName','Lz');

xlabel('Time(sec)')
ylabel(' "Lx,Ly,Lz"(Nm-s)');
title('Angular Momentum(Nm-s)');
legend('show')