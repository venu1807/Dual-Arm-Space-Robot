clear all;
clc;

t=linspace(0,30,100);
[T,Y]=ode45(@space_links_2,t,[0,0,0,0,0,0]);

H=table(Y(:,1),Y(:,2),Y(:,3),Y(:,4),Y(:,5),Y(:,6),'VariableNames',{'x0' 'dx0' 'y0' 'dy0' 'th0' 'dth0'})

[M]=Space_link_Traj();
[f,g]=size(M(:,1));
q1=[M(:,1),M(:,2)]; 
dq1=[M(:,3),M(:,4)];
ddq1=[M(:,5),M(:,6)];
disp('-----Joint angle 1&2 and their rates for simulation time period-----');
K=table(M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),M(:,6),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'})


% Parameters and initial conditions
%   mass, link length, initial angles, simulation time
% m = 1;
L = 3;
L1 =1;
L2 =1;


% x1 = [L1*cos(M(:,1)+Y(:,5)),   L1*cos(M(:,1)+Y(:,5))+L2*cos(M(:,1)+M(:,2)+Y(:,5))];
% y1 = [L1*sin(M(:,1)+Y(:,5)),   L1*sin(M(:,1)+Y(:,5))+L2*sin(M(:,1)+M(:,2)+Y(:,5))];

% x1 = [L1*cos(M(:,1)+(Y(:,5))),   L1*cos(M(:,1)+Y(:,5))+L2*cos(M(:,1)+M(:,2)+Y(:,5))];
% y1 = [L1*sin(M(:,1)+(Y(:,5))),   L1*sin(M(:,1)+Y(:,5))+L2*sin(M(:,1)+M(:,2)+Y(:,5))];



ang = M(:,1:2)*180/pi;
ang1= Y(:,5:6)*180/pi;

% x1 = [L1*cos(ang(:,1)+ang1(:,1)),   L1*cos(ang(:,1)+ang1(:,1))+L2*cos(ang(:,1)+ang(:,2)+ang1(:,1))];
% y1 = [L1*sin(ang(:,1)+ang1(:,1)),   L1*sin(ang(:,1)+ang1(:,1))+L2*sin(ang(:,1)+ang(:,2)+ang1(:,1))];

% Convert radians to degrees


index=0;

% Animating using Loops (Smart updating)
figure;

tic;    % start timing
for id = 1:length(T)
   index=index+1;
   % The top plot shows a time series of link angles
   x0=[ 0.5;0.5;-0.5;-0.5; 0.5];
   y0=[-0.5;0.5; 0.5;-0.5;-0.5];
   B=[x0 y0];
%    R=[cos(ang1(id,1)) -sin(ang1(id,1));sin(ang1(id,1)) cos(ang1(id,1))]';
    R=[cos(Y(id,5)) -sin(Y(id,5));sin(Y(id,5)) cos(Y(id,5))]';
    V=B*R;

   X0(:,id)=V(:,1);
   Y0(:,id)=V(:,2);
   
%    x1(id,:) = [(X0(1,id)/2)*cos(M(id,1))+L1*cos(M(id,1)+(Y(id,5))),   (X0(1,id)/2)*cos(M(id,1))+L1*cos(M(id,1)+Y(id,5))+L2*cos(M(id,1)+M(id,2)+Y(id,5))];
%    y1(id,:) = [(Y0(1,id)/2)*cos(M(id,1))+L1*sin(M(id,1)+(Y(id,5))),   (Y0(1,id)/2)*cos(M(id,1))+L1*sin(M(id,1)+Y(id,5))+L2*sin(M(id,1)+M(id,2)+Y(id,5))];

%    x1(id,:) = [L1*cos(M(id,1)+Y(id,5)),   L1*cos(M(id,1)+Y(id,5))+L2*cos(M(id,1)+M(id,2)+Y(id,5))];
%    y1(id,:) = [L1*sin(M(id,1)+Y(id,5)),   L1*sin(M(id,1)+Y(id,5))+L2*sin(M(id,1)+M(id,2)+Y(id,5))]; 
   
   x1(id,:) = L1*[cos(M(id,1)+Y(id,5)),   cos(M(id,1)+Y(id,5))+cos(M(id,1)+M(id,2)+Y(id,5))];
   y1(id,:) = L1*[sin(M(id,1)+Y(id,5)),   sin(M(id,1)+Y(id,5))+sin(M(id,1)+M(id,2)+Y(id,5))]; 
   
   
   B=[x1(id,:)' y1(id,:)'];
%    rx(:,index)=X0(:,id);
%    ry(:,index)=Y0(:,id);
   
   plot(X0(:,id),Y0(:,id))

   patch(X0(:,id),Y0(:,id),'red')
   axis equal
   axis([-L L -L L]);
  
    hold on
   cx=(X0(1,id)+X0(2,id))/2;
   cy=(Y0(1,id)+Y0(2,id))/2;
   
   plot([cx, x1(id,1)+cx;x1(id,1)+cx, x1(id,2)+cx], [cy, y1(id,1)+cy;y1(id,1)+cy, y1(id,2)+cy],'.-','Color',[0.15 0.32 0.26], 'MarkerSize', 20, 'LineWidth', 2)
%    plot([0, x1(id,1);x1(id,1), x1(id,2)], [0, y1(id,1);y1(id,1), y1(id,2)],'.-','Color',[0.15 0.32 0.26], 'MarkerSize', 20, 'LineWidth', 2)
%     plot([(rx(1,index)+rx(2,index))/2, x1(id,1);x1(id,1), x1(id,2)], [(ry(1,index)+ry(2,index))/2, y1(id,1);y1(id,1), y1(id,2)],'.-','LineWidth', 2)
   axis equal; 
  
   axis([-L L -L L]);
   
   title(sprintf('Time: %0.2f sec', T(id)));
%    xlabel('XY-Plane[ $$$ 2-Link space robot ANIMATION  $$$ ]','FontSize',12,'FontWeight','bold','Color','k');
   xlabel(sprintf('Angle(th1): %0.2f degrees',ang(id,1)),'FontSize',12,'FontWeight','bold','Color','m');
   ylabel(sprintf('Angle(th2): %0.2f degrees',ang(id,2)),'FontSize',12,'FontWeight','bold','Color','r');

   drawnow;
   hold off
end
fprintf('Animation (Regular): %0.2f sec\n', toc)


figure
hold on
title('Base position(x0,y0)(m) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('Base position(x0,y0)(m)')
plot(t,Y(:,1),'c-o','DisplayName','x0')

hold on
plot(t,Y(:,3),'m*','DisplayName','y0');
legend('show')

figure
hold on
title('Base velocities(dx0,dy0)(m/s) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('Base velocities(dx0,dy0)(m/s)')
plot(t,Y(:,2),'m-o','DisplayName','dx0')

hold on
plot(t,Y(:,4),'b*','DisplayName','dy0');
legend('show')

figure
hold on
title('Base rotation(th0)(rad) vs Time(s) Graph');
xlabel('Time(sec)')
ylabel('Base rotation(th0)(rad)')
plot(t,Y(:,5),'b*')

figure
hold on
title('Rate of Base rotation(dth0)(rad/s) vs Time(s) Graph');
xlabel('Time(sec)')
ylabel('Rate of Base rotation(dth0)(rad/s)')
plot(t,Y(:,6),'co')


figure
hold on
title('(JOINT ANGLEs)(rad) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(JOINT ANGLEs)(rad)')
plot(t,M(:,1),'g-o','DisplayName','th1')

hold on
plot(t,M(:,2),'r*','DisplayName','th2');
legend('show')

figure
hold on
title('(Rate of JOINT ANGLEs)(rad/s) vs Time(sec) Graph')
xlabel('Time(sec)')
ylabel('(Rate of JOINT ANGLEs)(rad/s)')
plot(t,M(:,3),'g-o','DisplayName','dth1')

hold on
plot(t,M(:,4),'r*','DisplayName','dth2')
legend('show')

% clc;






















