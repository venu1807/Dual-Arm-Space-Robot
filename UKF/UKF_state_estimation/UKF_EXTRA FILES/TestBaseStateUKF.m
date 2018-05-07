clear all

Nsamples = 301;
BaseStateSaved = zeros(Nsamples, 6);

dt = 0.1;

for k=1:Nsamples
  
  [th_1, th_2] = Getjoint_posi();
  
  [dth_1 ,dth_2] = Getjoint_vel();
  
  [phi, theta, psi] = GetBase_angular_posi();
  
  [dx0 , dy0 , dz0] = GetBase_linear_vel();
  
  [wx , wy , wz]    = GetBase_angular_vel();
  
  [d_x0, d_y0,  d_z0,  w_x , w_y,  w_z] = BaseStateUKF([dx0 dy0 dz0 wx wy wz ]',dt,[ phi theta  psi ],[ th_1  th_2 ],[ dth_1 dth_2 ]);
  
  BaseStateSaved(k, :) = [d_x0  d_y0  d_z0  w_x  w_y   w_z ];
  
end 



t = 0:dt:Nsamples*dt-dt;

figure
plot(t, BaseStateSaved(:,1))

figure
plot(t, BaseStateSaved(:,2))

figure
plot(t, BaseStateSaved(:,3))

figure
plot(t, BaseStateSaved(:,4))

figure
plot(t, BaseStateSaved(:,5))

figure
plot(t, BaseStateSaved(:,6))




