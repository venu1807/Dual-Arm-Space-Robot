Y=load('statevar.dat');

c_x=Y(:,1);
c_y=Y(:,2);
c_z=Y(:,3);

save Base_position.mat c_x c_y c_z

phi_x=Y(:,4);
theta_y=Y(:,5);
psi_z=Y(:,6);

save Base_angular_position.mat phi_x theta_y psi_z

th1=Y(:,7);
th2=Y(:,8);

save Joint_position.mat th1 th2

v_x=Y(:,9);
v_y=Y(:,10);
v_z=Y(:,11);

save Base_linear_velocity.mat  v_x v_y v_z

w_x=Y(:,12);
w_y=Y(:,13);
w_z=Y(:,14);

save Base_angular_velocity.mat w_x w_y w_z

dth1=Y(:,15);
dth2=Y(:,16);

save Joint_velocity.mat dth1 dth2





