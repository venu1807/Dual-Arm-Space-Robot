clc;
clear all;

%function   [ddq] = accln()
syms m1 lc1  th1 l1 Izz1   m2 lc2  th2 l2 Izz2  m3 lc3  th3 l3 Izz3
syms dth1   dth2 dth3
syms tau1 tau2 tau3

g=[0; -9.81; 0];

q=[th1; th2; th3]
dq=[dth1; dth2; dth3]

c1=cos(th1);
s1=sin(th1);

c12=cos(th1+th2);
s12=sin(th1+th2);

c123=cos(th1+th2+th3);
s123=sin(th1+th2+th3);


c10=[lc1*c1
    lc1*s1
    0];

c20=[l1*c1+lc2*c12
    l1*s1+lc2*s12
    0];

c30=[l1*c1+l2*c12+lc3*c123
    l1*s1+l2*s12+lc3*s123
    0];
  

w10=[0
    0
    dth1];

w20=[0
    0
    dth1+dth2];

w30=[0
    0
    dth1+dth2+dth3];



v10=[diff(c10,th1) diff(c10,th2) diff(c10,th3)]*dq;
v20=[diff(c20,th1) diff(c20,th2) diff(c20,th3)]*dq;
v30=[diff(c30,th1) diff(c30,th2) diff(c30,th3)]*dq;



K10=((m1*v10.'*v10)+(Izz1*w10.'*w10))/2;
K20=((m2*v20.'*v20)+(Izz2*w20.'*w20))/2;
K30=((m3*v30.'*v30)+(Izz3*w30.'*w30))/2;

P10=-m1*(g'*c10);
P20=-m2*(g'*c20);
P30=-m3*(g'*c30);


K=simplify(K10+K20+K30);

P=simplify(P10+P20+P30)

L=K-P

%Diff K with q_dot

L1=[diff(L,dth1); diff(L,dth2) ; diff(L,dth3)];
 
%Diff L1 with t

L2=[diff(L1,dth1) diff(L1,dth2) diff(L1,dth3)];

L3=[diff(L1,th1) diff(L1,th2) diff(L1,th3)]*dq;

%Diff L with q

L4=[diff(L,th1); diff(L,th2); diff(L,th3) ];

%Equations of motion

M=simplify(L2)

C=simplify(L3-L4)

%EOM

%Minv=inv(M)

F=[tau1; tau2; tau3]

%ddq=simplify(Minv*(F-C))
