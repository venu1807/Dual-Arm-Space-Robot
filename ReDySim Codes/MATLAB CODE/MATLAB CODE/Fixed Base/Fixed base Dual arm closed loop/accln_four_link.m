clc;
clear all;

%function   [ddq] = accln()

syms m0 m4 m5 m6 m7 lc0 lc4 lc5 lc6 lc7 th0 th4 th5 th6 th7 l0 l4 l5 l6 l7 Izz0 Izz4 Izz5 Izz6 Izz7 t
syms dth4 dth5 dth6 dth7
syms tau0 tau4 tau5 tau6 tau7

g=[0;-9.81;0]

q=[th4;th5;th6;th7];
dq=[dth4; dth5; dth6; dth7];

c4=cos(th4);
s4=sin(th4);
c5=cos(th5);
s5=sin(th5);
c6=cos(th6);
s6=sin(th6);
c7=cos(th7);
s7=sin(th7);
c45=cos(th4+th5);
s45=sin(th4+th5);
c456=cos(th4+th5+th6);
s456=sin(th4+th5+th6);
c4567=cos(th4+th5+th6+th7);
s4567=sin(th4+th5+th6+th7);

c40=[lc4*c4
    lc4*s4
    0];
  
c50=[l4*c4+lc5*c45
    l4*s4+lc5*s45
    0];

c60=[l4*c4+l5*c45+lc6*c456
    l4*s4+l5*s45+lc6*s456
    0];
c70=[l4*c4+l5*c45+l6*c456+lc7*c4567
    l4*s4+l5*s45+l6*s456+lc7*s4567
    0];


w40=[0
    0
    dth4];

w50=[0
    0
    dth4+dth5];

w60=[0
    0
    dth4+dth5+dth6];


w70=[0
    0
    dth4+dth5+dth6+dth7];


v40=[diff(c40,th4) diff(c40,th5)  diff(c40,th6) diff(c40,th7)]*dq
v50=[diff(c50,th4) diff(c50,th5)  diff(c50,th6) diff(c50,th7)]*dq
v60=[diff(c60,th4) diff(c60,th5)  diff(c60,th6) diff(c60,th7)]*dq
v70=[diff(c70,th4) diff(c70,th5)  diff(c70,th6) diff(c70,th7)]*dq


K40=((m4*v40.'*v40)+(Izz4*w40.'*w40))/2;
K50=((m5*v50.'*v50)+(Izz5*w50.'*w50))/2;
K60=((m6*v60.'*v60)+(Izz6*w60.'*w60))/2;
K70=((m7*v70.'*v70)+(Izz7*w70.'*w70))/2;

P40=-m4*(g.'*c40)
P50=-m5*(g.'*c50)
P60=-m6*(g.'*c60)
P70=-m7*(g.'*c70)

K=simplify(K40+K50+K60+K70);
P=simplify(P40+P50+P60+P70);

L=K-P

%Diff K with q_dot
L1=[diff(L,dth4); diff(L,dth5); diff(L,dth6); diff(L,dth7)];

%Diff K1 with t
L2=[diff(L1,dth4) diff(L1,dth5) diff(L1,dth6) diff(L1,dth7)];

L3=[diff(L1,th4) diff(L1,th5) diff(L1,th6) diff(L1,th7)]*dq;

%Diff K with q

L4=[diff(L,th4); diff(L,th5); diff(L,th6); diff(L,th7)];

%Equations of motion

M=simplify(L2)

C=simplify(L3-L4)

%EOM

%Minv=inv(M)

F=[tau4; tau5; tau6; tau7]

%ddq=simplify(Minv*(F-C))