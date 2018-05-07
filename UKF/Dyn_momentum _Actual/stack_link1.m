n=301;
% h=zeros(n*3,1);
h=zeros(n*2,1);
index1=0;
% for i=1:3:3*n
%    h(i,:)=ones(1,3);
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
% end
load L_M_link1.dat
k=L_M_link1;
l=size(k);
% k=ones(301,5);
% for i=1:3:3*n
for i1=1:2:2*n
     
     index1=index1+1;
        
     h(i1,1)  =k(index1,1);
%       h(i,1)  =k(index1,1);
     
     h(i1+1,1)=k(index1,2);
%      h(i+2,1)=k(index1,3);
%      h(i+3,1)=k(index1,4);
%      h(i+4,1)=k(index1,5);
   
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
    
end   

load A_link1.dat
j=A_link1;
v=size(j);
g=zeros(n*2,6);
index2=0;
% for i=1:3:3*n
for i2=1:2:2*n
    
     index2=index2 +1;
        
%      g(i,1:3)  =j(index2,1:3);
%      g(i,4:6)  =j(index2,5:7);
%      g(i,7:9)  =j(index2,9:11);
     
      
%      g(i,1)  =j(index2,1);
%      g(i,2)  =j(index2,4);
%      g(i,3)  =j(index2,7);
% %      g(i,4)  =j(index2,10);
%      g(i,5)  =j(index2,13);
%      g(i,6)  =j(index2,16);
%      g(i,7)  =j(index2,19);
% %      g(i,8)  =j(index2,22);
%      g(i,9)  =j(index2,25);
%      g(i,10)  =j(index2,28);
%      g(i,11)  =j(index2,31);
% %      g(i,12)  =j(index2,34);
     
     
     g(i2,1)  =j(index2,1);
     g(i2,2)  =j(index2,4);
     g(i2,3)  =j(index2,7);
     
%      g(i,4)  =j(index2,10);

     g(i2,4)  =j(index2,13);
     g(i2,5)  =j(index2,16);
     g(i2,6)  =j(index2,19);
     
%      g(i,8)  =j(index2,22);

%      g(i2,7)  =j(index2,25);
%      g(i2,8)  =j(index2,28);
%      g(i2,9)  =j(index2,31);
     
%      g(i,12)  =j(index2,34);
     
     
%      g(i+1,1:3)=j(index2,13:15);
%      g(i+1,4:6)=j(index2,17:19);
%      g(i+1,7:9)=j(index2,21:23);
     
     
     g(i2+1,1)  =j(index2,2);
     g(i2+1,2)  =j(index2,5);
     g(i2+1,3)  =j(index2,8);
%      g(i+1,4)  =j(index2,11);
     g(i2+1,4)  =j(index2,14);
     g(i2+1,5)  =j(index2,17);
     g(i2+1,6)  =j(index2,20);
%      g(i+1,8)  =j(index2,23);
%      g(i2+1,7)  =j(index2,26);
%      g(i2+1,8)  =j(index2,29);
%      g(i2+1,9)  =j(index2,32);
%      g(i+1,12)  =j(index2,35);
     
     
%       g(i+1,1)  =j(index2,2);
%      g(i+1,2)  =j(index2,5);
%      g(i+1,3)  =j(index2,8);
% %      g(i+1,4)  =j(index2,11);
%      g(i+1,5)  =j(index2,14);
%      g(i+1,6)  =j(index2,17);
%      g(i+1,7)  =j(index2,20);
% %      g(i+1,8)  =j(index2,23);
%      g(i+1,9)  =j(index2,26);
%      g(i+1,10)  =j(index2,29);
%      g(i+1,11)  =j(index2,32);
% %      g(i+1,12)  =j(index2,35);
     
     
     
     
%      g(i+2,1:3)=j(index2,25:27 );
%      g(i+2,4:6)=j(index2,29:31);
%      g(i+2,7:9)=j(index2,33:35);
     
     
%      g(i+2,1)  =j(index2,3);
%      g(i+2,2)  =j(index2,6);
%      g(i+2,3)  =j(index2,9);
%      g(i+2,4)  =j(index2,12);
%      g(i+2,5)  =j(index2,15);
%      g(i+2,6)  =j(index2,18);
%      g(i+2,7)  =j(index2,21);
%      g(i+2,8)  =j(index2,24);
%      g(i+2,9)  =j(index2,27);
%      g(i+2,10) =j(index2,30);
%      g(i+2,11) =j(index2,33);
%      g(i+2,12) =j(index2,36);
     
     
     
     
%    g(i+3,1:6)=j(index2,19:24);
%    g(i+4,1:6)=j(index2,25:30);
   
%    h(i+1,:)=ones(1,3);
%    h(i+2,:)=ones(1,3);
    
end
%  w=cov(g',1);
%  size(w)
% w=[17;25;93;47;56;667;766;866;977];
%  w=[1;1;1;1;1;1;1;1;1];
%   C=lsqr(g,h);
%   [b,se_b,mse,S]=lscov(g,h)

% [m,n]=size(g);

%  V = .2*ones(m)'
%  [bg,sew_b,mseg] = lscov(X,y,V)
 g1=[g(:,1) g(:,2) g(:,3) g(:,5) g(:,6)];

  C=pinv(g1)*(h-g(:,4))

% C=( (pinv(g)*h) + ( (eye(9)- pinv(g)*g)*w ) )

