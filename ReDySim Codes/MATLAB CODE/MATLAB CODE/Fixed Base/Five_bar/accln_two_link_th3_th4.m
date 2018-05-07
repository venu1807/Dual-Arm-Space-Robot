clc;
clear all;

%function   [ddq] = accln()

syms m3 lc3  th3 l3 Izz3   m4 lc4  th4 l4 Izz4
syms dth3   dth4
syms tau3 tau4

g=[0; -9.81; 0];

q=[th3; th4]
dq=[dth3; dth4]

c3=cos(th3);
s3=sin(th3);


c34=cos(th3+th4);
s34=sin(th3+th4);


c30=[lc3*c3
    lc3*s3
    0];

c40=[l3*c3+lc4*c34
    l3*s3+lc4*s34
    0];
  

w30=[0
    0
    dth3];

w40=[0
    0
    dth3+dth4];


v30=[diff(c30,th3) diff(c30,th4)]*dq;
v40=[diff(c40,th3) diff(c40,th4)]*dq;



K30=((m3*v30.'*v30)+(Izz3*w30.'*w30))/2;
K40=((m4*v40.'*v40)+(Izz4*w40.'*w40))/2;

P30=-m3*(g'*c30);
P40=-m4*(g'*c40);


K=simplify(K30+K40);

P=simplify(P30+P40)

L=K-P

%Diff K with q_dot

L1=[diff(L,dth3); diff(L,dth4)];

%Diff L1 with t

L2=[diff(L1,dth3) diff(L1,dth4)];

L3=[diff(L1,th3) diff(L1,th4)]*dq;

%Diff L with q

L4=[diff(L,th3); diff(L,th4)];

%Equations of motion

M=simplify(L2)

C=simplify(L3-L4)

%EOM

%Minv=inv(M)

F=[tau3; tau4]

%ddq=simplify(Minv*(F-C))
