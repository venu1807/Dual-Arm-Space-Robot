function [th1,th2,th3,th4,th5,th6,dth1,dth2,dth3,dth4,dth5,dth6]=Trajectory(t)
    
    thin=[0.3803;   -0.6198;    1.2867;    2.4411;    1.7062;   -1.0058];%60
    thf=[-0.2530;   -1.8050;   -0.0364;    3.3946;    1.8050;    0.0364];
    tf=30;
    Tp=tf;
    n=length(thin);
    for i=1:n
            thi(i,1)=thin(i)+((thf(i)-thin(i))/Tp)*(t-(Tp/(2*pi))*sin((2*pi/Tp)*t));
            dthi(i,1)=((thf(i)-thin(i))/Tp)*(1-cos((2*pi/Tp)*t));
    end
    th1 = thi(1);
    th2 = thi(2);
    th3 = thi(3);
    th4 = thi(4);
    th5 = thi(5);
    th6 = thi(6);
    
        
    dth1=dthi(1);
    dth2=dthi(2);
    dth3=dthi(3);
    dth4=dthi(4);
    dth5=dthi(5);
    dth6=dthi(6);