clc;
clear all;

%function   [ddq] = accln()
syms  m2 m3 lc2 lc3 th2 th3 l2 l3 Izz2 Izz3 t
syms dth2 dth3
syms tau2 tau3

th0=0; x0=0; y0=0;

g=[0; -9.81; 0]

q=[th2; th3];
dq=[dth2; dth3];

c0=cos(th0);
s0=sin(th0);
c2=cos(th2);
s2=sin(th2);
c23=cos(th2+th3);
s23=sin(th2+th3);

c00=[x0
     y0
     0];

c20=[x0+lc2*c2
    y0+lc2*s2
    0];
  
c30=[x0+l2*c2+lc3*c23
    y0+l2*s2+lc3*s23
    0];


w20=[0
    0
    dth2];

w30=[0
    0
    dth2+dth3];


v20=[diff(c20,th2) diff(c20,th3)]*[dth2;dth3];
v30=[diff(c30,th2) diff(c30,th3)]*[dth2;dth3];


K20=((m2*v20.'*v20)+(Izz2*w20.'*w20))/2;
K30=((m3*v30.'*v30)+(Izz3*w30.'*w30))/2;

P20=-m2*(g'*c20);
P30=-m3*(g'*c30);

K=simplify(K20+K30);

P=simplify(P20+P30);

L=K-P

%Diff L with q_dot

L1=[diff(L,dth2); diff(L,dth3)];

%Diff L1 with t
L2=[diff(L1,dth2) diff(L1,dth3)];

L3=[diff(L1,th2) diff(L1,th3)]*dq;

%Diff L with q

L4=[diff(L,th2); diff(L,th3)];

%Equations of motion

M=simplify(L2)

C=simplify(L3-L4)

%EOM Manually

%EOM

%Minv=inv(M)

F=[tau2; tau3]

%ddq=simplify(Minv*(F-C))