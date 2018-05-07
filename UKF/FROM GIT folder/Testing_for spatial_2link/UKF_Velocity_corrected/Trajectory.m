function [th1,th2,dth1,dth2]=Trajectory(t)
%     thin=[0.3803; -0.6198]; %60
%     thf=[-pi/2; -pi/2];
    thin=[ -pi/2 ;  pi/4];%60
    thf=[ 0;  -pi/2];
    tf=30;
    Tp=tf;
    n=length(thin);
    for i=1:n
            thi(i,1)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
            dthi(i,1)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
    end
    th1 = thi(1);
    th2 = thi(2);
    
%     ll=[ua,ub];
%         
    dth1=dthi(1);
    dth2=dthi(2);
    
%     pp=[dth1,dth2];