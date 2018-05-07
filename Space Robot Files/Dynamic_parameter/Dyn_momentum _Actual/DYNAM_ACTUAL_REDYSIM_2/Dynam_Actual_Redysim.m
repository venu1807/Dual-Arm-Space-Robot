clear all;
close all;
clc

%Data generation

q=load('statevar.dat');
t=load('timevar.dat');
m=load('mtvar.dat');

len_t = length(t);

r0 = q(:,1:3);       %CM position of the base

th0 = q(:,4);        %CM angular position of the base

th1 = q(:,7);        %Joint1 position

dr0 = q(:,8:10);     %CM linear velocity of the base

dth0= q(:,11);       %CM angular velocity of the base

dth1= q(:,14);      %Joint1 velocity

Px = m(:,1);
Py = m(:,2);
Py = m(:,3);

Lx = m(:,4);
Ly = m(:,5);
Lz = m(:,6);

for id=1:len_t
    
    x0=q(id,1);
    y0=q(id,2);
    
    dx0 = q(id,8);
    dy0 = q(id,9);
    
    th0= q(id,7);
    
    dth0=q(
    
    th0=
    
    dr0=vb;
    
    dr1=vb + [-(a0/2)*sin(ph0) ;(a0/2)*cos(ph0);0]*dph0;
    
    dr2=vb + [-(a0/2)*sin(ph0)-(a1)*sin(ph0+th1) ; (a0/2)*cos(ph0)+(a1)*cos(ph0+th1) ; 0]*dph0 + [-(a1)*sin(ph0+th1) ;(a1)*cos(ph0+th1) ; 0]*dq1(id,1) ;
    
    w0x=[0     -dph0  0;
        dph0   0     0;
        0      0     1];
    
    w1x=[0               -(dph0+dq1(id,1))   0;
        (dph0+dq1(id,1))    0                0;
         0                  0                1];
         
    w2x=[0                          -(dph0+dq1(id,1)+dq1(id,2))  0;
        (dph0+dq1(id,1)+dq1(id,2))    0                          0;
         0                            0                          1];
     
    IR0=[cos(ph0) -sin(ph0)  0; 
         sin(ph0)  cos(ph0)  0;
         0         0         1];
     
    IR1=[cos(ph0+th1) -sin(ph0+th1)  0; 
         sin(ph0+th1)  cos(ph0+th1)  0;
         0                 0         1];
     
    IR2=[cos(ph0+th1+th2) -sin(ph0+th1+th2)  0; 
         sin(ph0+th1+th2)  cos(ph0+th1+th2)  0;
         0                 0                 1];
   
    G0=[0 0 0;0 0 0;0 0 0];
   
    G1=w1x*IR1;
   
    G2=w2x*IR2;
   
    a00=[0;0;0];
    
    a11=[(a1/2)*cos(ph0+th1);(a1/2)*sin(ph0+th1);0];
    
    a22=[(a2/2)*cos(ph0+th1+th2);(a2/2)*sin(ph0+th1+th2);0]; 
    
    A=[dr0 w0x dr1 w1x dr2 w2x];
    
    b=[m0;m0*a00;m1;m1*a11;m2;m2*a22];
    
    P=A*b;
     
     
     
end
