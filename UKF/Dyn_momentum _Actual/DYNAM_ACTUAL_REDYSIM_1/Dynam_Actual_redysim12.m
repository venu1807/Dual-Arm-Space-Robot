clear all;
close all;
clc

%Data generation

q=load('statevar.dat');
t=load('timevar.dat');
m=load('mtvar.dat');

len_t = length(t);

Px = m(:,1);
Py = m(:,2);
Py = m(:,3);

Lx = m(:,4);
Ly = m(:,5);
Lz = m(:,6);

%position and velocity at the sensor.
rcpC = [-0.2; -0.3; 0];
vpI = zeros(len_t,3); 
rpI = zeros(len_t,3);
RIP=zeros(3,3,len_t);
RP1=zeros(3,3,len_t); 
  

reg_x = zeros(1,6); 
Bx = 0;
v0=zeros(len_t,3);
v1=zeros(len_t,3);

for i=1:1:len_t
    
    a0=1;
    
    x0=q(i,1);
    y0=q(i,2);
    
    r0=[x0;y0;0];
    
    dx0 = q(i,8);
    dy0 = q(i,9);
    
    v0(i,:)=[dx0;dy0;0]';
    
    th0  = q(i,4);
    dth0 = q(i,11);
    
    th1  = q(i,7);
    dth1 = q(i,14);
    
    RIP(:,:,i) = [cos(th0) -sin(th0)  0
                  sin(th0)  cos(th0)  0
                  0              0    1];
    
	R0I = RIP(:,:,i);
    
    RP1(:,:,i) = [cos(th1) -sin(th1)  0
                  sin(th1)  cos(th1)  0
                  0              0    1];
    
    R1I = RIP(:,:,i)*RP1(:,:,i);
    
    v1(i,:)=([dx0-a0/2*sin(th0),dy0+a0/2*cos(th0),0]*dth0);
    
%     w0x=[0 -dth0 0;dth0 0 0;0 0 1];
    w0x(i)=dth0;
   
    w1x(i)=dth0+dth1;
    
%     w1x=([0 -dth0 0;dth0 0 0;0 0 1])+([0 -dth1 0;dth1 0 0;0 0 1]);
    
    l0x = [v0(i,1)   -w0x(i)*R0I(2,1)     -w0x(i)*R0I(2,2)];
    
    l0y = [v0(i,2)    w0x(i)*R0I(1,1)      w0x(i)*R0I(1,2)];
    
    l1x = [v1(i,1)   -w1x(i)*R1I(2,1)     -w1x(i)*R1I(2,2)];
    
    l1y = [v1(i,2)    w1x(i)*R1I(1,1)      w1x(i)*R1I(1,2)];
    
    reg_x = [reg_x; l0x l1x; l0y l1y];

%     Bx    = [Bx; Px(i); Py(i)];
    Bx=[Bx;m(i,1);m(i,2)];
   
end

 A=reg_x;
 C=[reg_x(:,1:3) reg_x(:,5:6)];
 D=[reg_x(:,4)];
 Error=mean(D-Bx)
 x_noise=pinv(A)*Bx
 x_null =pinv(C)*D
 x_null_noise =pinv(C)*(Bx-D)
 

    
    








    
    
    
%     dr0=vb;
%     
%     dr1=vb + [-(a0/2)*sin(ph0) ;(a0/2)*cos(ph0);0]*dph0;
%     
%     dr2=vb + [-(a0/2)*sin(ph0)-(a1)*sin(ph0+th1) ; (a0/2)*cos(ph0)+(a1)*cos(ph0+th1) ; 0]*dph0 + [-(a1)*sin(ph0+th1) ;(a1)*cos(ph0+th1) ; 0]*dq1(id,1) ;
%     
%     w0x=[0     -dph0  0;
%         dph0   0     0;
%         0      0     1];
%     
%     w1x=[0               -(dph0+dq1(id,1))   0;
%         (dph0+dq1(id,1))    0                0;
%          0                  0                1];
%          
%     w2x=[0                          -(dph0+dq1(id,1)+dq1(id,2))  0;
%         (dph0+dq1(id,1)+dq1(id,2))    0                          0;
%          0                            0                          1];
%      
%     IR0=[cos(ph0) -sin(ph0)  0; 
%          sin(ph0)  cos(ph0)  0;
%          0         0         1];
%      
%     IR1=[cos(ph0+th1) -sin(ph0+th1)  0; 
%          sin(ph0+th1)  cos(ph0+th1)  0;
%          0                 0         1];
%      
%     IR2=[cos(ph0+th1+th2) -sin(ph0+th1+th2)  0; 
%          sin(ph0+th1+th2)  cos(ph0+th1+th2)  0;
%          0                 0                 1];
%    
%     G0=[0 0 0;0 0 0;0 0 0];
%    
%     G1=w1x*IR1;
%    
%     G2=w2x*IR2;
%    
%     a00=[0;0;0];
%     
%     a11=[(a1/2)*cos(ph0+th1);(a1/2)*sin(ph0+th1);0];
%     
%     a22=[(a2/2)*cos(ph0+th1+th2);(a2/2)*sin(ph0+th1+th2);0]; 
%     
%     A=[dr0 w0x dr1 w1x dr2 w2x];
%     
%     b=[m0;m0*a00;m1;m1*a11;m2;m2*a22];
%     
%     P=A*b;
     
     
     
% end