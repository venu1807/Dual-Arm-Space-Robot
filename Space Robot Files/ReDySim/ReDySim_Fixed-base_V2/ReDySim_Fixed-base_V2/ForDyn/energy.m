% ReDySim energy module. This module caculates energy 
% Contibutors: Dr. Suril Shah and Prof S. K. Saha @IIT Delhi

function[]=energy()
disp('------------------------------------------------------------------');
disp('Performing Energy balance');

load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
let=length(T);
kine=zeros(let,1);
pote=zeros(let,1);
[n dof type alp a b th bt r dx dy dz m g  Icxx Icyy Iczz Icxy Icyz Iczx]=inputs() ;

for k =1:let
    q=Y(k,1:n)';
    dq=Y(k,n+1:2*n)';
    [so sc vc tt ]=for_kine(q, dq, n, alp, a, b, th, bt, r, dx, dy, dz);
    Q=zeros(3,3,n);
    KE=0;
    PE=0;
    for j=1:n
        % FINDING W=M*dt+W*M*E*T+wg
        It=[Icxx(j) Icxy(j)    Iczx(j)
            Icxy(j)  Icyy(j)    Icyz(j)
            Iczx(j)  Icyz(j)    Iczz(j)];
        PE=PE+m(j)*-g'*sc(:,j);
        
        KE=KE+0.5*(m(j)*vc(:,j)'*vc(:,j)+tt(:,j)'*It'*tt(:,j));
    end
    kine(k)=KE;
    pote(k)=PE;
end
AE=Y(:,2*n+1);
TE=kine+pote+AE;

%OPENING DATA FILE
fomode='w';
fip4=fopen('envar.dat',fomode);%time
% disp('2:Writing data into file');
%FOR LOOP FOR READING & WRITING SOLUTIONS FOR EACH INSTANT
for j=1:let
    %WRITING SOLUTION FOR EACH INSTANT IN FILES
    fprintf(fip4,'%e ',pote(j), kine(j), AE(j), TE(j));
    fprintf(fip4,'\n');
end