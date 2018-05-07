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
Z3=zeros(f,12);
Z4=zeros(f,1);

for id =1:f
    
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
    
    I0=[0;0;I0z]*dph0
  
  
    I1=[0;0;I1z]*(dph0+dq1(id,1))
  
 
    I2=[0;0;I2z]*(dph0+dq1(id,1)+dq1(id,2))
  
 
    C11= m1*[0;0;-((a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1))*dx0+((a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1))*dy0]+m1*[0;0;((a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1))^2+((a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1))^2 ]*dph0 +m1*[0;0;((a0/2)*cos(ph0)+(a1/2)*cos(ph0+th1))*((a1/2)*cos(ph0+th1))+((a0/2)*sin(ph0)+(a1/2)*sin(ph0+th1))*((a1/2)*sin(ph0+th1))]*dq1(id,1)
  
%  
    C22= m2*[0;0;-((a0/2)*sin(ph0)+(a1)*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2))*dx0+((a0/2)*cos(ph0)+(a1)*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2))*dy0]+ m2*[0;0;((a0/2)*sin(ph0)+(a1)*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2))^2+((a0/2)*cos(ph0)+(a1)*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2))^2 ]*dph0 +m2*[0;0;((a0/2)*cos(ph0)+(a1)*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2))*((a1)*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2))+((a0/2)*sin(ph0)+(a1)*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2))*((a1)*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2))]*dq1(id,1)+m2*[0;0;;((a0/2)*cos(ph0)+(a1)*cos(ph0+th1)+(a2/2)*cos(ph0+th1+th2))*((a2/2)*cos(ph0+th1+th2))+((a0/2)*sin(ph0)+(a1)*sin(ph0+th1)+(a2/2)*sin(ph0+th1+th2))*((a2/2)*sin(ph0+th1+th2))]*dq1(id,2);
    
     
    L11 = I0+I1+I2+C11+C22;
    
    Z2(index1,:)=L11;
end

Z2


