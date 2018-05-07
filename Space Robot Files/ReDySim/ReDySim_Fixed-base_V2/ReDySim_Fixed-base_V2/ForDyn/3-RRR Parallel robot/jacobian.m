function [J, dJ]=jacobian(th,dth)

% [n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx aj al]=inputs() 

%3-RRR Parallel robot
% Link lengths
% Subsystem I
a1=0.4; b1=0.6; d1=0.4;
% Subsystem II
a2=0.4; b2=0.6;
% Subsystem III
a3=0.4; b3=0.6;d3=0.4;

alp1 = th(1);
alp4 = th(1) + th(2);
alp7 = th(1) + th(2) + th(3);

alp2 = th(4);
alp5 = th(4) + th(5);

alp3 = th(6);
alp6 = th(6) + th(7);

dalp1 = dth(1);
dalp4 = dth(1) + dth(2);
dalp7 = dth(1) + dth(2) + dth(3);

dalp2 = dth(4);
dalp5 = dth(4) + dth(5);

dalp3 = dth(6);
dalp6 = dth(6) + dth(7);


%----------------%
J_1 = [-a1*sin(alp1)-b1*sin(alp4)-d1*sin(alp7)  -b1*sin(alp4)-d1*sin(alp7) -d1*sin(alp7)
        a1*cos(alp1)+b1*cos(alp4)+d1*cos(alp7)   b1*cos(alp4)+d1*cos(alp7)  d1*cos(alp7)];

J_2 = [ b2*sin(alp5)+a2*sin(alp2)  b2*sin(alp5)
       -b2*cos(alp5)-a2*cos(alp2) -b2*cos(alp5)];

J_3 = zeros(2,2);

J_4 = [-a1*sin(alp1)-b1*sin(alp4)-d3*sin(alp7+pi/3)  -b1*sin(alp4)-d3*sin(alp7+pi/3) -d3*sin(alp7+pi/3)
        a1*cos(alp1)+b1*cos(alp4)+d3*cos(alp7+pi/3)   b1*cos(alp4)+d3*cos(alp7+pi/3)  d3*cos(alp7+pi/3)];

J_5 = zeros(2,2);

J_6 = [ b3*sin(alp6)+a3*sin(alp3)  b3*sin(alp6)
       -b3*cos(alp6)-a3*cos(alp3) -b3*cos(alp6)];
J_mat = [J_1    J_2     J_3
         J_4    J_5     J_6];
     
J = J_mat;
     
J_1_d = [-a1*cos(alp1)*dalp1-b1*cos(alp4)*dalp4-d1*cos(alp7)*dalp7  -b1*cos(alp4)*dalp4-d1*cos(alp7)*dalp7  -d1*cos(alp7)*dalp7
         -a1*sin(alp1)*dalp1-b1*sin(alp4)*dalp4-d1*sin(alp7)*dalp7  -b1*sin(alp4)*dalp4-d1*sin(alp7)*dalp7  -d1*sin(alp7)*dalp7];

J_2_d = [b2*cos(alp5)*dalp5+a2*cos(alp2)*dalp2  b2*cos(alp5)*dalp5
         b2*sin(alp5)*dalp5+a2*sin(alp2)*dalp2  b2*sin(alp5)*dalp5];
     
J_3_d = zeros(2,2);

J_4_d = [-a1*cos(alp1)*dalp1-b1*cos(alp4)*dalp4-d3*cos(alp7+pi/3)*dalp7   -b1*cos(alp4)*dalp4-d3*cos(alp7+pi/3)*dalp7  -d3*cos(alp7+pi/3)*dalp7
         -a1*sin(alp1)*dalp1-b1*sin(alp4)*dalp4-d3*sin(alp7+pi/3)*dalp7  -b1*sin(alp4)*dalp4-d3*sin(alp7+pi/3)*dalp7  -d3*sin(alp7+pi/3)*dalp7];

J_5_d = zeros(2,2);

J_6_d = [b3*cos(alp6)*dalp6+a3*cos(alp3)*dalp3  b3*cos(alp6)*dalp6
         b3*sin(alp6)*dalp6+a3*sin(alp3)*dalp3  b3*sin(alp6)*dalp6];
     
J_mat_d = [J_1_d        J_2_d         J_3_d
           J_4_d        J_5_d         J_6_d];
dJ = J_mat_d;