n=301;
h=zeros(n*2,1);
load L_M1.dat
k=L_M1;
l=size(k);



load A.dat
j=A;
v=size(j);
g=zeros(n*2,9);
index2=0;
% for i=1:3:3*n
for i2=1:2:2*n
    
     index2=index2 +1;
     
     
     h(i2,1)  =k(index2,1);
     h(i2+1,1)=k(index2,2);
     
        
     g(i2,1)  =j(index2,1);
     g(i2,2)  =j(index2,4);
     g(i2,3)  =j(index2,7);
     g(i2,4)  =j(index2,13);
     g(i2,5)  =j(index2,16);
     g(i2,6)  =j(index2,19);
     g(i2,7)  =j(index2,25);
     g(i2,8)  =j(index2,28);
     g(i2,9)  =j(index2,31);
     

     g(i2+1,1)  =j(index2,2);
     g(i2+1,2)  =j(index2,5);
     g(i2+1,3)  =j(index2,8);
     g(i2+1,4)  =j(index2,14);
     g(i2+1,5)  =j(index2,17);
     g(i2+1,6)  =j(index2,20);
     g(i2+1,7)  =j(index2,26);
     g(i2+1,8)  =j(index2,29);
     g(i2+1,9)  =j(index2,32);
     
    
end

h;
g;

h1=[h(3:602,1)]
g1=[g(3:602,1:3) g(3:602,5:9)]


V=pinv(g1'*g1)*g1'*(g(3:602,4))




%  w=cov(g',1);
%  size(w)
% w=[17;25;93;47;56;667;766;866;977];
%  w=[1;1;1;1;1;1;1;1;1];
%   C=lsqr(g,h);
%   [b,se_b,mse,S]=lscov(g,h)

% [m,n]=size(g);

%  V = .2*ones(m)'
%  [bg,sew_b,mseg] = lscov(X,y,V)

%    C=pinv(g)*h

% C=( (pinv(g)*h) + ( (eye(9)- pinv(g)*g)*w ) )



% a=g-ones(602)*g*(1/602)
% 
% O=a'*a;
% V=O/602

%%% Rank finding %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Z=rank(g);


% s = svd(g);
% tol = max(size(g))*eps(max(s));
% r = sum(s > tol)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%