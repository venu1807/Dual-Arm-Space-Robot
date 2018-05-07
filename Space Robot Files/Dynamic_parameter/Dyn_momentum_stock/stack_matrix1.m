n=301;
h=zeros(n*3,1);
index1=0;
% for i=1:3:3*n
%    h(i,:)=ones(1,3);
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
% end
load L_M.dat
k=L_M;
l=size(k);
% k=ones(301,5);
for i=1:3:3*n
     
     index1=index1+1;
        
     h(i,1)  =k(index1,1);
     h(i+1,1)=k(index1,2);
     h(i+2,1)=k(index1,3);
%      h(i+3,1)=k(index1,4);
%      h(i+4,1)=k(index1,5);
   
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
    
end   

load A.dat
j=A;
v=size(j);
g=zeros(n*3,12);
index2=0;
for i=1:3:3*n
     
     index2=index2+1;
        
     g(i,1:12)  =j(index2,1:12);
     g(i+1,1:12)=j(index2,13:24);
     g(i+2,1:12)=j(index2,25:36);
     
%    g(i+3,1:6)=j(index2,19:24);
%    g(i+4,1:6)=j(index2,25:30);
   
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
    
end

C=lsqr(g,h)