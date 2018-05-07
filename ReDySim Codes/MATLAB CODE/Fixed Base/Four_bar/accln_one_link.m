clc;
clear all;

%function   [ddq] = accln()
syms m1 lc1  th1 l1 Izz1
syms dth1 
syms tau1

g=[0; -9.81; 0];

th0=0;x0=0;y0=0;

q=[th1]
dq=[dth1]

c1=cos(th1);
s1=sin(th1);

c10=[lc1*c1
    lc1*s1
    0];
  

w10=[0
    0
    dth1];


v10=[diff(c10,th1)]*[dth1];

K10=((m1*v10.'*v10)+(Izz1*w10.'*w10))/2;

P10=-m1*(g'*c10);

K=simplify(K10);

P=simplify(P10)

L=K-P

%Diff K with q_dot

L1=[diff(L,dth1)];

%Diff L1 with t

L2=[diff(L1,dth1) ];

L3=[diff(L1,th1) ]*dq;

%Diff L with q

L4=[diff(L,th1)];

%Equations of motion

M=simplify(L2)

C=simplify(L3-L4)

%EOM

%Minv=inv(M)

F=[tau1]

%ddq=simplify(Minv*(F-C))
