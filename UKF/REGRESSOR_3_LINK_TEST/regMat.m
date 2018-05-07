% This function evaluates the regressor matrix of a free floating robot
% according to the formulation in the paper. Please note that the second
% section has to be updated as per the robot's kinematic structure
% q, th_d, dq, dth_d - position and velocity of base and joints
% lk_no - index of link which is attached to the base

function [prow, lrow] = regMat(q,th_d,dq,dth_d,lk_no)
%% Start of the actual program - ok
[n, ~, ~, ~, ~, ~, ~, ~, ~, ~, alt]=inputs();

%% Update the position of sensor in base CM frame (sa0) - ok
% sa0 = [-0.07; -0.1; 0];
sa0 = [-0.2; -0.3; 0];
%Positions of the joints fixed to the base in sensor frame
% (in real system this will be an input)
jt_pos = [alt(1)-sa0(1), -sa0(1)-alt(1)
          -sa0(2)      , -sa0(2) 
          0            , 0             ];

      
% Y=load('statevar.dat');
% t=load('timevar.dat');
% m=load('mtvar.dat')/10;

q=[-3.848507e-09, 3.695321e-08, 0.000000e+00, 3.845329e-08, 0.000000e+00, 0.000000e+00, 3.802998e-01, -6.198003e-01, 1.286700e+00, 2.441100e+00,	1.706200e+00, -1.005800e+00];
dq=[-1.154535e-07, 1.108580e-06, 0.000000e+00	, 1.153582e-06,	 0.000000e+00,	 0.000000e+00,	 -4.629772e-06,	 -8.664465e-06	, -9.672590e-06	, 6.970610e-06,	 7.222824e-07,	 7.619056e-06];


% len_t = length(t);
% r0cI = Y(:,1:3);     %CM position of the base
% th0 = Y(:,4);        %CM angular position of the base
% th1 = Y(:,7);        %Joint position
% v0cI = Y(:,8:10);    %CM linear velocity of the base
% om0 = Y(:,11);       %CM angular velocity of the base
% om1 = Y(:,14);       %Joint velocity
% Px  = m(:,1);
% Py  = m(:,2);
% Lz  = m(:,6);



% len_t = length(t);
% q(:,1:3) = Y(:,1:3);     %CM position of the base
% q(:,4) = Y(:,4);        %CM angular position of the base
% q(:,7) = Y(:,7);        %Joint position
% dq(:,1:3) = Y(:,8:10);    %CM linear velocity of the base
% dq(:,4)= Y(:,11);       %CM angular velocity of the base
% dq(:,7) = Y(:,14);       %Joint velocity
% Px  = m(:,1);
% Py  = m(:,2);

%% Robot's Kinematic Data (in inertial frame) - ok
   
r0c = q(1:3); %CM position of the base
th0 = q(4); %Angular position of the base
th_d= q(7:12);
thj = th_d; %Joint position

v0c = dq(1:3); %CM linear velocity of the base
om0 = dq(4); %Angular velocity of the based
dth_d=dq(7:12);
omj = dth_d; %Joint velocity

lk_no=[1,4];

nc = length(lk_no); %number of chains attached to the base link

%% Computation of sensor data - ok
R=zeros(3,3,n);
for j=1:len_t
R(:,:,n) = [cos(th0) -sin(th0) 0
            sin(th0)  cos(th0) 0
            0         0        1];

% %Fabrication of the simulated sensor data
% (in real system this is the input instead of base CM pose and velocity)
rs = r0c + R(:,:,1)*sa0;
vs = v0c + cross([0;0;om0], R(:,:,1)*sa0); 
%

%% Computation of the rotation matrices - ok
for j=1:n-1
        R(:,:,j+1) = [cos(thj(j)) -sin(thj(j)) 0
                      sin(thj(j))  cos(thj(j)) 0
                      0              0         1];
end

RiI = zeros(3,3,n);
RiI(:,:,1) = R(:,:,1);
lkm = [lk_no, n];

for j=1:nc
    for i=lkm(j):(lkm(j+1)-1)
        if i == lkm(j)
            mul = RiI(:,:,1);
        else
            mul = RiI(:,:,i);
        end
        RiI(:,:,i+1) = mul*R(:,:,i+1);
    end
end

%% Computation of joint vector(s) connected to the base in the inertial frame - ok
rsiJ = zeros(3,nc); %Vector from sensor to joints fixed to the base

for i=1:nc
    rsiJ(:,i) = RiI(:,:,1)*jt_pos(:,i);
end

%% Computation of joint position in the inertia frame - ok
ri = zeros(3,n); % joint vectors from the origin of the inertial frame
ri(:,1) = rs;

count1 = 1;
count2 = 2;
for j=1:nc
    for i=lkm(j):(lkm(j+1)-1)
        if i == lkm(j)
            add = rsiJ(:,count1);   
            prev = ri(:,1);
            count1 = count1+1;
        else
            add = RiI(:,:,i)*[alt(count2);0;0];
            prev = ri(:,i);
            count2 = count2 + 1;
        end
        ri(:,i+1) = prev + add;
    end
    count2 = count2  + 1;
end

% Computation of regressor matrix's elements
%% vk and alpha computation - ok

vk = zeros(3,n); 
afa = zeros(3,n);
vk(:,1) = vs;
afa(:,1) = cross(ri(:,1),vk(:,1));
exc = 0;
for j=1:nc
    for i=lkm(j):(lkm(j+1)-1)
        vk(:,i+1) = vk(:,1) + cross([0;0;om0], (ri(:,i+1) - rs));
        if lkm(j) <= i-1
            for h = lkm(j):i-1
                rot = dth_d(h);
                exc = exc + cross([0;0;rot], ri(:,i+1) - ri(:,h+1));
            end
        end
        vk(:,i+1) = vk(:,i+1) + exc;
        afa(:,i+1) = cross(ri(:,i+1), vk(:,i+1));
        exc = 0;
    end
end

%% omk and beta computation

omk = zeros(1,n);
bomk = zeros(3,3,n);
bta = zeros(3,n); 
bbta = zeros(3,3,n);
omk(1) = om0;
bomk(:,:,1) = box([0;0;omk(1)])*RiI(:,:,1);
bta(:,1) = -vk(:,1) + cross(ri(:,1),[0;0;omk(1)]);
bbta(:,:,1) = box(bta(:,1))*RiI(:,:,1);

for j=1:nc
    for i=lkm(j):(lkm(j+1)-1)
        if i == lkm(j)
            prev = omk(1);
        else
            prev = omk(i);
        end
        omk(i+1) = prev + omj(i);
        bomk(:,:,i+1) = box([0;0;omk(i+1)])*RiI(:,:,i+1);
        bta(:,i+1) = -vk(:,i+1) + cross(ri(:,i+1),[0;0;omk(:,i+1)]);
        bbta(:,:,i+1) = box(bta(:,i+1))*RiI(:,:,i+1);
    end
end

%% Deleting the zero components

vk(3,:)=[]; 
afa([1,2],:)=[];
bomk(:,3,:) = []; 
bomk(3,:,:) = [];
bbta([1,2],:,:) = []; 
bbta(:,3,:) = [];


%% Matrix assembly for all the n links
z21 = zeros(2,1);
prow = [vk(:,1)  bomk(:,:,1)];
lrow = omk(1);
for i=2:n
    papd = [vk(:,i)  bomk(:,:,i)];
    prow = [prow, papd];
    lrow = [lrow, omk(i)];
end

%% Verifiction of conservation of momentum
% ltum = prow*[100 0 0 10 5 0 10 5 0].';
% atum = low*[10.05 1.05 1.05].'
end