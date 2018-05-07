t=0:0.1:30;
[T,Y]=ode45(@space_links_21,t,[0,0,0,0,0,0]);


H=table(Y(:,1),Y(:,2),Y(:,3),Y(:,4),Y(:,5),Y(:,6),'VariableNames',{'x0' 'y0' 'th0' 'dx0' 'dy0' 'dth0'});


[M]=Space_link_Traj();
[f,g]=size(M(:,1));
q1=[M(:,1),M(:,2)];
dq1=[M(:,3),M(:,4)];
ddq1=[M(:,5),M(:,6)];
% disp('-----Joint angle 1&2 and their rates for simulation time period-----');
K=table(M(:,1),M(:,2),M(:,3),M(:,4),M(:,5),M(:,6),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'});

ang2= M(:,1:2)*180/pi;
ang1= Y(:,5:6)*180/pi;

m0=100; m1=10; m2=10;
M1=m0+m1+m2;
a0=1; a1=1; a2=1;
d1x=0.5; d2x=0.5;
d1y=0; d2y=0;


I0z=83.61; I1z=1.05; I2z=1.05;

L1=[0;0;0];
P1=[0;0;0];
index1=0;
Z1=zeros(f,3);
Z2=zeros(f,3);
Z3=zeros(f,1);
Z4=zeros(f,1);


fomode='w';
fip4=fopen('L_M.dat',fomode);

for id = 1:f
    index1=index1+1;
    dx0=Y(id,4);
    dy0=Y(id,5);
    ph0=Y(id,3);
    dph0=Y(id,6);
    vb=[dx0;dy0;0];
    wb=[0;0;dph0];

    th1=q1(id,1);
    
    th2=q1(id,2);
    
    dph=[dq1(id,1);dq1(id,2)];
    
    rbg=[((m1/M1)*(a0/2)*cos(ph0)) + ((m1/M1)*(a1/2)*cos(ph0+th1)) + ((m2/M1)*(a0/2)*cos(ph0)) + ((m2/M1)*a1*cos(ph0+th1)) + ((m2/M1)*(a2/2)*cos(ph0+th1+th2));
         ((m1/M1)*(a0/2)*sin(ph0)) + ((m1/M1)*(a1/2)*sin(ph0+th1)) + ((m2/M1)*(a0/2)*sin(ph0)) + ((m2/M1)*a1*sin(ph0+th1)) + ((m2/M1)*(a2/2)*sin(ph0+th1+th2));
         0];

    Jtg=[  -((m1*a1/2)*sin(ph0+th1)+m2*a1*sin(ph0+th1)+(m2*a2/2)*sin(ph0+th1+th2))   -((m2*a2/2)*sin(ph0+th1+th2));
             (m1*a1/2)*cos(ph0+th1)+m2*a1*cos(ph0+th1)+(m2*a2/2)*cos(ph0+th1+th2)      (m2*a2/2)*cos(ph0+th1+th2);
            0 0];
        
%     Px=M1*dx0 - (m1*( a0/2*sin(ph0) +a1/2*sin(ph0+th1)) +m2*( a0/2*sin(ph0) +a1*sin(ph0+th1) +a2/2*sin(ph0+th1+th2) ))*dph0 - (m1*(a1/2 *sin(ph0+th1))+m2*(a1*sin(ph0+th1) +a2/2*sin(ph0+th1+th2)))*dq1(id,1)- m2*a2/2*sin(ph0+th1+th2)*dq1(id,2);
%     
%     Z3(index1)=Px;
%     
%     Py=M1*dy0 + (m1*( a0/2*cos(ph0) +a1/2*cos(ph0+th1)) +m2*( a0/2*cos(ph0) +a1*cos(ph0+th1) +a2/2*cos(ph0+th1+th2) ))*dph0 + (m1*(a1/2 *cos(ph0+th1))+m2*(a1*cos(ph0+th1) +a2/2*cos(ph0+th1+th2)))*dq1(id,1)+ m2*a2/2*cos(ph0+th1+th2)*dq1(id,2);
%     Z4(index1)=Py;
    

      F1=(M1*vb)';
      F2=(M1*cross(wb,rbg))';
      F3=(Jtg*dph)';
      F=(F1+F2+F3)';
      
      
      P= ((M1*vb)+(M1*cross(wb,rbg))+(Jtg*dph))';
      
%       
      fprintf(fip4,'%e ',P);
      fprintf(fip4,'\n');
      
%        Z1(index1,:)=P;
%       PP=[P1,P];
%       P1=PP;
      
    rg=[ (m1/M1)*(a0/2)*cos(ph0)+(m1/M1)*(a1/2)*cos(ph0+th1)+(m2/M1)*(a0/2)*cos(ph0)+(m2/M1)*a1*cos(ph0+th1)+(m2/M1)*(a2/2)*cos(ph0+th1+th2);
         (m1/M1)*(a0/2)*sin(ph0)+(m1/M1)*(a1/2)*sin(ph0+th1)+(m2/M1)*(a0/2)*sin(ph0)+(m2/M1)*a1*sin(ph0+th1)+(m2/M1)*(a2/2)*sin(ph0+th1+th2);
         0];

    r1c=[0, 0, (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1)
         0, 0, -(a0/2)*cos(ph0)-(a1/2)*cos(ph0+th1)
         -(a0/2)*sin(ph0)-(a1/2)*sin(ph0+th1), (a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1), 0];

    r2c=[0, 0 ,(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
          0, 0 ,-(a0/2)*cos(ph0)-a1*cos(ph0+th1)-(a2/2)*cos(ph0+th1+th2);
         -(a0/2)*sin(ph0)-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2),(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),0];

    r1= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1);
        (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1);
         0];   
     
    r11= [(a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1),(a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1), 0];  
      
    r2= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2);
         (a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2);
         0];
    r22= [(a0/2)*cos(ph0)+a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2),(a0/2)*sin(ph0)+a1*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2),0];  
      
    Iw1 = I0z + I1z + m1*r11*r1 + I2z + m2*r22*r2;
    
    Iw = Iw1*[0 0 1];

    Jr1= [0 0;0 0;1 0]; 
    
    Jr2= [0 0;0 0;1 1];
    
    Jt1=[-(a1/2)*sin(ph0+th1) 0; (a1/2)*cos(ph0+th1) 0;0 0];
    
    Jt2=[-a1*sin(ph0+th1)-(a2/2)*sin(ph0+th1+th2)     -(a2/2)*sin(ph0+th1+th2);
          a1*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2)      (a2/2)*cos(ph0+th1+th2);
          0 0];

    Iph = I1z*Jr1 + m1*r1c*Jt1 + I2z*Jr2 + m2*r2c*Jt2;
    
    B1=m1*[0;0;( (a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1) )^2 + ( (a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1) )^2]*(dph0+dq1(id,1));
    
    B2=m2*[0;0;( (a0/2)*sin(ph0)+(a1)*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2) )^2 + ( (a0/2)*cos(ph0)+(a1)*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2) )^2]*(dph0+dq1(id,1)+dq1(id,2));
    
    L= M1*cross(rg,vb) + Iw*wb*[0;0;1] + Iph*dph ;
    
    Z2(index1,:)=L;
    LL=[L1,L];
    L1=LL;
     
    
    
      
      
end
Z1;
Z2;
P1(:,1)=[];
L1(:,1)=[];


% fomode='w';
% fip4=fopen('L_M.dat',fomode);
% for j=1:f
%     %WRITING SOLUTION FOR EACH INSTANT IN FILES
%     for l=1:3
%          fprintf(fip4,'%e ',P(l,:));
%          fprintf(fip4,'\n');
%     end
% end

% 
% figure(1)
% subplot(2,1,1);
% 
% hold on
% plot(t,Z1(:,1),'r','DisplayName','Px');
% 
% hold on
% plot(t,Z1(:,2),'b','DisplayName','Py');
% 
% hold on
% plot(t,Z1(:,3),'k','DisplayName','Pz');
% 
% xlabel('Time(sec)')
% ylabel('"Px,Py,Pz"(N-s)');
% title('Linear Momentum(N-s)');
% legend('show')
% 
% 
% subplot(2,1,2);
% 
% hold on
% plot(t,Z2(:,1),'c','DisplayName','Lx');
% 
% hold on
% plot(t,Z2(:,2),'m','DisplayName','Ly');
% 
% hold on
% plot(t,Z2(:,3),'g','DisplayName','Lz');
% 
% xlabel('Time(sec)')
% ylabel(' "Lx,Ly,Lz"(Nm-s)');
% title('Angular Momentum(Nm-s)');
% legend('show')
