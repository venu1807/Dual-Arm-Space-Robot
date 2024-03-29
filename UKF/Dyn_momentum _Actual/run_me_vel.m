clear all;close all;clc

%Data generation

Y=load('statevar.dat'); t=load('timevar.dat'); m=load('mtvar.dat')/10;
len_t = length(t);
r0cI = Y(:,1:3); %CM position of the base
th0 = Y(:,4); %CM angular position of the base
th1 = Y(:,7); %Joint position
v0cI = Y(:,8:10); %CM linear velocity of the base
om0 = Y(:,11); %CM angular velocity of the base
om1 = Y(:,14); %Joint velocity
Px = m(:,1); Py = m(:,2); Lz = m(:,3);
plot(t,r0cI(:,1),'-.',t,r0cI(:,2),'-.')

% %Noise Addition
np = 0;

th0 = th0+(np/100)*range(th0)*randn(len_t,1);
th1 = th1+(np/100)*range(th1)*randn(len_t,1);
om0 = om0+(np/100)*range(om0)*randn(len_t,1);
om1 = om1+(np/100)*range(om1)*randn(len_t,1);
Px = Px+(np/100)*range(Px)*randn(len_t,1);



%%
%Evaluating the position and velocity at the sensor
rcpC = [-0.2 -0.3 0].'; vpI = zeros(len_t,3); rpI = zeros(len_t,3);
RIP=zeros(3,3,len_t); RP1=zeros(3,3,len_t); rp1JI=zeros(len_t,3);
for i=1:len_t
    RIC = [cos(th0(i)) -sin(th0(i)) 0
           sin(th0(i))  cos(th0(i)) 0
           0              0         1];
    RP1(:,:,i) = [cos(th1(i)) -sin(th1(i)) 0
                  sin(th1(i))  cos(th1(i)) 0
                  0              0         1];   
    vpI(i,:) = (v0cI(i,:).' + cross([0;0;om0(i)], RIC*rcpC)).';
    rpI(i,:) = (r0cI(i,:).' + RIC*rcpC).';
    RIP(:,:,i) = RIC;
    rp1JI(i,:) = (RIP(:,:,i)*[0.7;0.3;0]).';
end
plot(t,rpI(:,1),'-.',t,rpI(:,2),'-.')

% Making of the regression matrix
reg_x = zeros(1,6); Bx = 0;

for i=1:1:len_t
	R0I = RIP(:,:,i);
    R1I = RIP(:,:,i)*RP1(:,:,i);
	r1JI(i,:) = rpI(i,:) + rp1JI(i,:);

    term(i,:) = vpI(i,:) - cross([0,0,om0(i)], rpI(i,:));  %[-om0(i)*rpI(i,2),om0(i)*rpI(i,1),0];
	Va0I(i,:) = vpI(i,:);
    OMGa0I(i) = om0(i);

	OMGa1I(i) = om0(i)+om1(i);
	Va1I(i,:) = term(i,:) - cross([0,0,om1(i)], r1JI(i,:)) + cross([0,0,OMGa1I(i)],r1JI(i,:));  %[-om1(i)*r1JI(i,2), om1(i)*r1JI(i,1), 0] + [-OMGa1I(i)*r1JI(i,2), OMGa1I(i)*r1JI(i,1), 0];
	
	l0x = [Va0I(i,1) -OMGa0I(i)*R0I(2,2) -OMGa0I(i)*R0I(2,1)];
    l0y = [Va0I(i,2)  OMGa0I(i)*R0I(1,2)  OMGa0I(i)*R0I(1,1)];
    l1x = [Va1I(i,1) -OMGa1I(i)*R1I(2,2) -OMGa1I(i)*R1I(2,1)];
    l1y = [Va1I(i,2) OMGa1I(i)*R1I(1,2)  OMGa1I(i)*R1I(1,1)];
    reg_x = [reg_x; l0x l1x; l0y l1y];
    Bx = [Bx; Px(i); Py(i)];
end

reg_x(1,:)=[]; Bx(1)=[];

disp('rank of regression matrices')
r = rank(reg_x)
rref_reg_x = rref(reg_x);
cn = cond(reg_x)
% disp('Performing parameter evaluation')
% par = pinv(reg_x)*Bx;
% par_act = [1, 0.3, 0.2, 0, 0.5];
% disp('    Actual  Identified'); disp([par_act.', par])

regb = reg_x(:,1:3);
svb = svd(full(regb))
cnb = cond(regb)

regl = reg_x(:,4:6);
svl = svd(full(regl))
cnl = cond(regl)
% figure('Name','Error');plot(1:1:len_t,reg_x*(par)-reg_x*(par_act.'),1:1:len_t,reg_x*(par)-Bx); legend('E1','E2')

    