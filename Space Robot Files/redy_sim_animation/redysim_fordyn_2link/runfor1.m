t=0:0.05:60;
tf=60;
Tp=tf;
n=3;


[th_d dth_d ddth_d]=trajectory(t, n, tf)

[dy]=ode45(@sys_ode,t,[0,0,0,0,0,0,0.3803,-0.6198,0,0,0,0,0,0,0,0],Tp);