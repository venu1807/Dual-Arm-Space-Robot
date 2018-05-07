function [M,I,J,K,T,Q]=traj4(t, n, tf)
thin=[0.3803;   -0.6198];
thf=[-pi/2; -pi/2];
ti=0;
tf=30;
n=3;
Tp=tf;
% t=20;
index=0;
LastName = {'th1','th2','dth1','dth2','ddth1','ddth2'};
A=zeros(1,2);
B=zeros(1,2);
C=zeros(1,2);
H=zeros(tf,6);
index=0;
time=zeros(21,1);
for t=0:0.1:tf
    index=index+1;
       for i=1:2
       th(i)=thin(i)+((thf(i)-thin(i))/Tp)*((Tp/(2*pi))*sin((2*pi/Tp)*t));
       dth(i)=((thf(i)-thin(i))/Tp)*(-cos((2*pi/Tp)*t));
       ddth(i)=(2*pi*(thf(i)-thin(i))/(Tp*Tp))*sin((2*pi/Tp)*t);
       A(i)=th(i);
       B(i)=dth(i);
       C(i)=ddth(i);
       H(index,:)=[A B C];
       end
    time(index)=t;
end 
Q=time;
I=H(:,1:2);
J=H(:,3:4);
K=H(:,5:6);
M=[I,J,K];
T=table(I(:,1),I(:,2),J(:,1),J(:,2),K(:,1),K(:,2),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'});
end