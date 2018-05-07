clc;
clear all;
%function [Mt, Jt]=Eqn_matrix_T(It,rtb)
%syms m0 m1 m2 m3 m4 m5 m6 m7 lc0 lc1 lc2 lc3 lc4 lc5 lc6 lc7 x0 y0 th0 th1 th2 th3 th4 th5 th6 th7 l0 l1 l2 l3 l4 l5 l6 l7 Izz0 Izz1 Izz2 Izz3 Izz4 Izz5 Izz6 Izz7 t
%syms dx0 dy0 dth0 dth1 dth2 dth3 dth4 dth5 dth6 dth7
syms fx fy tau0 tau1 tau2 tau3 tau4 tau5 tau6 tau7

syms mt rx ry rz px py pz Itxx Ityy Itzz

m0=500;m1=10;m2=10;m3=10;m4=10;m5=10;m6=10; l0=1;l1=1;l2=1;l3=1;l4=1;l5=1;l6=1; lc0=.5*l0;lc1=.5*l1;lc2=.5*l2;lc3=.5*l3; lc4=.5*l4;lc5=.5*l5;lc6=.5*l6;  
Izz0=83.61; Izz1=1.05; Izz2=1.05; Izz3=1.05;Izz4=1.05; Izz5=1.05; Izz6=1.05;

%mt=50; Itxx=1;Ityy=1; Itzz=1;
%Target EOM
Jt=vpa(zeros(6,6));
Mt=vpa(zeros(6,6));
It(1:3,1:3)=[Itxx 0 0
    0 Ityy 0
   0 0 Itzz];
Mt(1:3,1:3)=It;
Mt(4,4)=mt;
Mt(5,5)=mt;
Mt(6,6)=mt;

rb=[rx;ry;rz]
%pbe=[px;py;pz]
rtb=rb

Rtb(3,2)=rtb(1)
Rtb(2,3)=-Rtb(3,2)
Rtb(3,1)=-rtb(2)
Rtb(1,3)=-Rtb(3,2)
Rtb(2,1)=rtb(3)
Rtb(1,2)=-Rtb(2,1)

Jt(4:6,1:3)=Rtb
Jt(1:3,1:3)=eye(3,3)
Jt(4:6,4:6)=eye(3,3)

[thdotf ttf tbf]=Impact_eqns()

Ti=0; Tf=20;

yy0=[0;0;0;0.698; -1.571; 1.047;0;0;0;0;0;0];
TiTf1=Ti:.01:Tf
%yy0=[0;0;0;-0.275209183298752;-1.02677807237436;-0.738184763886455;0;0;0;0;0;0];
[T1,Y1] = ode45(@rigid_1,TiTf1,yy0);

Tii=Tf; Tff=30;
TiTf2=Tii:.01:Tff
n=length(T1)

[thdotf ttf tbf]=Impact_eqns()

yy00=[Y1(n,1:6).';tbf;thdotf]; 

[T2,Y2] = ode45(@rigid_2,TiTf2,yy00);

T=[T1;T2];
Y=[Y1;Y2];