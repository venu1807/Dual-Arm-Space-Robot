% t=linspace(0,30,100);
t=0:0.1:20;
[T,Y]=ode45(@space_links_21,t,[0,0,0,0,0,0]);

H=table(Y(:,1),Y(:,2),Y(:,3),Y(:,4),Y(:,5),Y(:,6),'VariableNames',{'x0' 'dx0' 'y0' 'dy0' 'th0' 'dth0'})

[M]=Space_link_Traj();
[f,g]=size(M(:,1));
q1=[M(:,1),M(:,2)];
dq1=[M(:,3),M(:,4)];
ddq1=[M(:,5),M(:,6)];
disp('-----Joint angle 1&2 and their rates for simulation time period-----');
K=table(M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),M(:,6),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'})

ang2= M(:,1:2)*180/pi;
ang1= Y(:,5:6)*180/pi;

m0=100; m1=10; m2=10;
M1=m0+m1+m2;
a0=1; a1=1; a2=1;
d1x=0.5; d2x=0.5;
d1y=0; d2y=0;


I0z=83.61; I1z=1.05; I2z=1.05;

L1=[0;0;0];
P1=[0;0;0];
index1=0;
Z1=zeros(f,3);
Z2=zeros(f,3);
for id = 1:f
    index1=index1+1;
    dx0=Y(id,4);
    
    dy0=Y(id,5);
    
    ph0=Y(id,3);
    
    dph0=Y(id,6);
    
    vb=[dx0;dy0;0];
    
    wb=[0; 0 ;dph0];

    th1=q1(id,1);
    
    th2=q1(id,2);
    
    dph=[dq1(id,1);dq1(id,2)];
    
      
    rg=[ (m1/M1)*(a0/2)*cos(ph0)+(m1/M1)*(a1/2)*cos(ph0+th1)+(m2/M1)*(a0/2)*cos(ph0)+(m2/M1)*a1*cos(ph0+th1)+(m2/M1)*(a2/2)*cos(ph0+th1+th2);
         (m1/M1)*(a0/2)*sin(ph0)+(m1/M1)*(a1/2)*sin(ph0+th1)+(m2/M1)*(a0/2)*sin(ph0)+(m2/M1)*a1*sin(ph0+th1)+(m2/M1)*(a2/2)*sin(ph0+th1+th2);
         0];

    r1c=[0, 0, (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1)
         0, 0, -(a0/2)*cos(ph0)-(a1/2)*cos(ph0+th1)
         -(a0/2)*sin(ph0)-(a1/2)*sin(ph0+th1), (a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1), 0];

    r2c=[0, 0 ,(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
          0, 0 ,-(a0/2)*cos(ph0)-a1*cos(ph0+th1)-(a2/2)*cos(ph0+th1+th2);
         -(a0/2)*sin(ph0)-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2),(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),0];

    r1= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1);
        (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1);
         0];   
     
    r11= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1),(a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1), 0];  
      
    r2= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2);
         (a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
         0];
    r22= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2),0];  
      
    Iw1 = I0z + I1z + m1*r11*r1 + I2z + m2*r22*r2;
    
    Iw = Iw1*[0 0 1];

    Jr1= [0 0;0 0;1 0]; 
    
    Jr2= [0 0;0 0;1 1];
    
    Jt1=[-(a1/2)*sin(ph0+th1) 0; (a1/2)*cos(ph0+th1) 0;0 0];
    
    Jt2=[-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2)     -(a2/2)*sin(ph0+th1+th2);
          a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2)      (a2/2)*cos(ph0+th1+th2);
          0 0];

    Iph = I1z*Jr1 + m1*r1c*Jt1 + I2z*Jr2 + m2*r2c*Jt2;
    
    L= M1*cross(rg,vb) + Iw*wb*[0;0;1] + Iph*dph;
    
    Z2(index1,:)=L;
    LL=[L1,L];
    L1=LL;
     
end
T;
Z1;
Z2
P1(:,1)=[];
L1(:,1)=[];
% % i=0:0.1:Tp;
figure(1)
subplot(2,1,1);
hold on
plot(t,Z2(:,3),t,Z2(:,2),t,Z2(:,1))
% plot(t,L1(1,:),t,L1(2,:),t,L1(3,:))
title('Angular Momentum(Lz)')
xlabel('Time(sec)')
ylabel('Anugular Momentum(Lz)(Nm-s)');

%  hold on
% subplot(2,1,2);
% % figure(2)
% % plot(t,P1(1,:),t,P1(2,:),t,P1(3,:))
% % plot(t,P1(1,:),t,P1(2,:),t,P1(3,:))
% title('Linear Momentum')
% legend('Px','Py','Pz')
