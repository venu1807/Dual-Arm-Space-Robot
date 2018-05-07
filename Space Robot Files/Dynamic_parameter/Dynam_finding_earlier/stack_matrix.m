n=301;
h=zeros(n*5,1);
index1=0;
% for i=1:3:3*n
%    h(i,:)=ones(1,3);
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
% end
load Torque.dat
k=Torque;
l=size(k);
% k=ones(301,5);
for i=1:5:5*n
     
     index1=index1+1;
        
     h(i,1)  =k(index1,1);
     h(i+1,1)=k(index1,2);
     h(i+2,1)=k(index1,3);
     h(i+3,1)=k(index1,4);
     h(i+4,1)=k(index1,5);
   
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
    
end   

load Trac.dat
j=Trac;
v=size(j);
g=zeros(n*5,6);
index2=0;
for i=1:5:5*n
     
     index2=index2+1;
        
     g(i,1:6)  =j(index2,1:6);
     g(i+1,1:6)=j(index2,7:12);
     g(i+2,1:6)=j(index2,13:18);
     g(i+3,1:6)=j(index2,19:24);
     g(i+4,1:6)=j(index2,25:30);
   
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
    
end
 C=inv(g'*g)*g'*h
%  C=lsqr(g,h)