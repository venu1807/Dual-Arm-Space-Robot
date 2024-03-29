clc;
clear all;

%function   [ddq] = accln()
syms m1 lc1  th1 l1 Izz1   m2 lc2  th2 l2 Izz2
syms dth1   dth2
syms tau1 tau2

g=[0; -9.81; 0];

q=[th1; th2]
dq=[dth1; dth2]

c1=cos(th1);
s1=sin(th1);

c1=cos(th1);
s1=sin(th1);

c12=cos(th1+th2);
s12=sin(th1+th2);


c10=[lc1*c1
    lc1*s1
    0];

c20=[l1*c1+lc2*c12
    l1*s1+lc2*s12
    0];
  

w10=[0
    0
    dth1];

w20=[0
    0
    dth1+dth2];


v10=[diff(c10,th1) diff(c10,th2)]*dq;
v20=[diff(c20,th1) diff(c20,th2)]*dq;



K10=((m1*v10.'*v10)+(Izz1*w10.'*w10))/2;
K20=((m2*v20.'*v20)+(Izz2*w20.'*w20))/2;

P10=-m1*(g'*c10);
P20=-m2*(g'*c20);


K=simplify(K10+K20);

P=simplify(P10+P20)

L=K-P

%Diff K with q_dot

L1=[diff(L,dth1); diff(L,dth2)];

%Diff L1 with t

L2=[diff(L1,dth1) diff(L1,dth2)];

L3=[diff(L1,th1) diff(L1,th2)]*dq;

%Diff L with q

L4=[diff(L,th1); diff(L,th2)];

%Equations of motion

M=simplify(L2)

C=simplify(L3-L4)

%EOM

%Minv=inv(M)

F=[tau1; tau2]

%ddq=simplify(Minv*(F-C))
