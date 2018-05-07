% ReDySim trajectory module. The desired indpendent joint trejectories are 
% enterd here
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function [th_d dth_d ddth_d]=trajectory(t, n, tf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1: Joint level trejectory: Cycloidal motion
% thin=[0.3803;   -0.6198];%60
% thf=[-pi/2; -pi/2];
% Tp=tf;
% for i=1:n-1
%     thi(i,1)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
%     dthi(i,1)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
%     ddthi(i,1)=(2*pi*(thf(i)-thin(i))/(Tp*Tp))*sin((2*pi/Tp)*t);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% th_d  =[0;thi]
% dth_d =[0;dthi]
% ddth_d=[0;ddthi]


thin=[0.3803; -0.6198];
thf=[-pi/2; -pi/2];
ti=0;
tf=60;
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
for t=0:0.05:60
    index=index+1;
       for i=1:2
       th(i)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
       dth(i)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
       ddth(i)=(2*pi*(thf(i)-thin(i))/(Tp*Tp))*sin((2*pi/Tp)*t);
       A(i)=th(i);
       B(i)=dth(i);
       C(i)=ddth(i);
       H(index,:)=[A B C];
       end
    time(index)=t;
end 
Q=time;
th_d=H(:,1:2);
dth_d=H(:,3:4);
ddth_d=H(:,5:6);
% M=[I,J,K];
% T=table(I(:,1),I(:,2),J(:,1),J(:,2),K(:,1),K(:,2),'VariableNames',{'th1' 'th2' 'dth1' 'dth2' 'ddth1' 'ddth2'});
end