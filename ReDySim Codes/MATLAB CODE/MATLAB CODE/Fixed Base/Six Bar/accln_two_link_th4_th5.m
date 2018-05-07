clc;
clear all;

%function   [ddq] = accln()

syms  m4 lc4  th4 l4 Izz4  m5 lc5  th5 l5 Izz5  
syms dth4 dth5
syms tau4 tau5

g=[0; -9.81; 0];

q=[th4; th5]
dq=[dth4; dth5]

c4=cos(th4);
s4=sin(th4);


c45=cos(th4+th5);
s45=sin(th4+th5);


c40=[lc4*c4
    lc4*s4
    0];

c50=[l4*c4+lc5*c45
    l4*s4+lc5*s45
    0];
  

w40=[0
    0
    dth4];

w50=[0
    0
    dth4+dth5];


v40=[diff(c40,th4) diff(c40,th5)]*dq;
v50=[diff(c50,th4) diff(c50,th5)]*dq;


K40=((m4*v40.'*v40)+(Izz4*w40.'*w40))/2;
K50=((m5*v50.'*v50)+(Izz5*w50.'*w50))/2;

P40=-m4*(g'*c40);
P50=-m5*(g'*c50);


K=simplify(K40+K50);

P=simplify(P40+P50)

L=K-P

%Diff K with q_dot

L1=[diff(L,dth4); diff(L,dth5)];

%Diff L1 with t

L2=[diff(L1,dth4) diff(L1,dth5)];

L3=[diff(L1,th4) diff(L1,th5)]*dq;

%Diff L with q

L4=[diff(L,th4); diff(L,th5)];

%Equations of motion

M=simplify(L2)

C=simplify(L3-L4)

%EOM

%Minv=inv(M)

F=[tau4; tau5]

%ddq=simplify(Minv*(F-C))
