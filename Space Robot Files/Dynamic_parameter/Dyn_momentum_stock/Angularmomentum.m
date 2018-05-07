Tp=5;
t=0:0.1:Tp;
thin=[0.3803;   -0.6198];%60
thf=[-pi/2; -pi/2];
n=3;

for i=1:n-1
    thi(i,:)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
    dthi(i,:)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
    ddthi(i,:)=(2*pi*(thf(i)-thin(i))/(Tp*Tp))*sin((2*pi/Tp)*t);
end

tht1=thi(1,:); dtht1=dthi(1,:); ddtht1=ddthi(1,:);
tht2=thi(2,:); dtht2=dthi(2,:); ddtht2=ddthi(2,:);

m0=100; m1=10; m2=10;
M=m0+m1+m2;
a0=1; a1=1; a2=1;
d1x=0.5; d2x=0.5;
d1y=0; d2y=0;


I0z=83.61; I1z=1.05; I2z=1.05;

dx0=Y(:,4);
dy0=Y(:,5);
dph0=Y(:,6);
ph0=Y(:,3)';

L1=[0;0;0];
P1=[0;0;0];

for i=1:size(dx0)    
    
vb=[dx0(i),dy0(i),0]';
wb=[0; 0 ;dph0(i)];
ph0=Y(i,3);
th1=tht1(i);
th2=tht2(i);
dph=[dtht1(i); dtht2(i)];

rg=[(m1/M)*(a0/2)*cos(ph0)+(m1/M)*(a1/2)*cos(ph0+th1)+(m2/M)*(a0/2)*cos(ph0)+(m2/M)*a1*cos(ph0+th1)+(m2/M)*(a2/2)*cos(ph0+th1+th2)
    (m1/M)*(a0/2)*sin(ph0)+(m1/M)*(a1/2)*sin(ph0+th1)+(m2/M)*(a0/2)*sin(ph0)+(m2/M)*a1*sin(ph0+th1)+(m2/M)*(a2/2)*sin(ph0+th1+th2)
    0]

r1c=[0 0 (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1)
     0 0 -(a0/2)*cos(ph0)-(a1/2)*cos(ph0+th1)
     -(a0/2)*sin(ph0)-(a1/2)*sin(ph0+th1) (a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1) 0];

r2c=[0 0 (a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2)
     0 0 -(a0/2)*cos(ph0)-a1/2*cos(ph0+th1)-(a2/2)*cos(ph0+th1+th2)
     -(a0/2)*sin(ph0)-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2) (a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2) 0];

r1= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1)
     (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1)
      0];
r11= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1) (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1) 0];  
% rb1c=[0 0 (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1)
%       0 0 (-a0/2)*cos(ph0)-(a1/2)*cos(ph0+th1)
%       (-a0/2)*sin(ph0)-(a1/2)*sin(ph0+th1) (a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1) 0];
     
     
r2= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2)
     (a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2)
      0];
r22= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2) (a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2) 0];
% rb2c=[0 0 (a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2)
%       0 0 (-a0/2)*cos(ph0)-a1*cos(ph0+th1)-(a2/2)*cos(ph0+th1+th2)
%       (-a0/2)*sin(ph0)-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2) (a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2) 0];
       
Iw = I0z + I1z +m1*r11*r1 + I2z +m2*r22*r2;
Iw = Iw*[0 0 1];

Jr1= [0 0;0 0;1 0]; Jr2=[0 0;0 0;1 1];
Jt1=[(-a1/2)*sin(ph0+th1) 0; (a1/2)*cos(ph0+th1) 0;0 0];
Jt2=[-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2) (-a2/2)*sin(ph0+th1+th2)
      a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2) (a2/2)*cos(ph0+th1+th2)
      0 0];

Iph = I1z*Jr1 + m1*r1c*Jt1 + I2z*Jr2 + m2*r2c*Jt2;
% a=Iw*wb*[0;0;1] + Iph*dph
% b=M*cross(rg,vb)
L=M*cross(rg,vb) + Iw*wb*[0;0;1] + Iph*dph;
LL=[L1,L];
L1=LL;

end

L1(:,1)=[];
% i=0:0.1:Tp;
figure(1)
subplot(2,1,1);
plot(T,L1(1,:),T,L1(2,:),T,L1(3,:))
title('Angular Momentum')
legend('Lx','Ly','Lz')
% subplot(2,1,2);
% plot(T,P1(1,:),T,P1(2,:),T,P1(3,:))
% title('Linear Momentum')