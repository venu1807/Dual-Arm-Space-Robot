clear all;
clc;

n=3;    % n degree of freedom
joint=[1 1 1 1 1 1]
syms th1 th2 th3 th4 th5 th6     l1 l2 l3 l4 l5 l6

th=[th2 th3 th4 th5 th6];
d=[0 0 0 0 0 0];
a=[l2 l3 l4 l5 l6];
alp=[0 0 0 0 0 0];

temp=eye(4,4);

for i=1:n
    A=[cos(th(i)) -sin(th(i))*cos(alp(i)) sin(th(i))*sin(alp(i)) a(i)*cos(th(i))
       sin(th(i)) cos(th(i))*cos(alp(i)) -cos(th(i))*sin(alp(i)) a(i)*sin(th(i))
       0 sin(alp(i)) cos(alp(i)) d(i)
       0 0 0 1];
   T=temp*A;
   z(1:3,i+1)=T(1:3,3);
   o(1:3,i+1)=T(1:3,4);
   temp=T;
end
z(1:3,1)=[0;0;1];
o(1:3,1)=[0;0;0];
for k=1:n
    if joint(k)==1
J(1:3,k)=cross(z(:,k),(o(1:3,n+1)-o(1:3,k)))
    J(4:6,k)=z(:,k);
    else
         J(1:3,k)=z(:,k)
    end
end

jacob=simplify(J)