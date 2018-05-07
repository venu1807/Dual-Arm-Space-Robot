clc;
clear all;

%function   [ddq] = accln()
syms m0 m1 m2 m3 lc0 lc1 lc2 lc3 th0 th1 th2 th3 l0 l1 l2 l3 Izz0 Izz1 Izz2 Izz3 t
syms dx0 dy0 dth0 dth1 dth2 dth3
syms fx0 fy0 tau0 tau1 tau2 tau3

g=[0;-9.81;0]

q=[th1;th2;th3];
dq=[dth1; dth2; dth3];

x0=0;y0=0;th0=0;dth0=0; lc0=0;l0=0;

c0=cos(th0);
s0=sin(th0);
c1=cos(th1);
s1=sin(th1);
c2=cos(th2);
s2=sin(th2);
c3=cos(th3);
s3=sin(th3);
c01=cos(th0+th1);
s01=sin(th0+th1);
c012=cos(th0+th1+th2);
s012=sin(th0+th1+th2);
c0123=cos(th0+th1+th2+th3);
s0123=sin(th0+th1+th2+th3);

c00=[x0
     y0
     0];

c10=[x0+lc0*c0+lc1*c01
    y0+lc0*s0+lc1*s01
    0];
  
c20=[x0+lc0*c0+l1*c01+lc2*c012
    y0+lc0*s0+l1*s01+lc2*s012
    0];

c30=[x0+lc0*c0+l1*c01+l2*c012+lc3*c0123
    y0+lc0*s0+l1*s01+l2*s012+lc3*s0123
    0];

w00=[0
    0
    dth0];

w10=[0
    0
    dth0+dth1];

w20=[0
    0
    dth0+dth1+dth2];

w30=[0
    0
    dth0+dth1+dth2+dth3];


v10=[diff(c10,th1) diff(c10,th2)  diff(c10,th3)]*dq
v20=[diff(c20,th1) diff(c20,th2)  diff(c20,th3)]*dq
v30=[diff(c30,th1) diff(c30,th2)  diff(c30,th3)]*dq


K10=((m1*v10.'*v10)+(Izz1*w10.'*w10))/2;
K20=((m2*v20.'*v20)+(Izz2*w20.'*w20))/2;
K30=((m3*v30.'*v30)+(Izz3*w30.'*w30))/2;

P10=-m1*(g.'*c10)
P20=-m2*(g.'*c20)
P30=-m3*(g.'*c30)

K=simplify(K10+K20+K30);
P=simplify(P10+P20+P30);

L=K-P

%Diff K with q_dot
L1=[diff(L,dth1); diff(L,dth2); diff(L,dth3)];

%Diff K1 with t
L2=[diff(L1,dth1) diff(L1,dth2) diff(L1,dth3)];

L3=[diff(L1,th1) diff(L1,th2) diff(L1,th3)]*dq;

%Diff K with q

L4=[diff(L,th1); diff(L,th2); diff(L,th3)];

%Equations of motion

M=simplify(L2)

C=simplify(L3-L4)

%EOM

%Minv=inv(M)

F=[tau1; tau2; tau3]

%ddq=simplify(Minv*(F-C))