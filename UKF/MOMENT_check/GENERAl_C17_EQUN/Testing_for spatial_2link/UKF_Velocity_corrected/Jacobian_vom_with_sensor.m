function [Ib, Im, Ibm, Jbe, Jme, GJM, Jg2 ,MM] = Jacobian_vom(q,th,n,alp,a,b,bt,dx,dy,dz,m,Icxx,Icyy,Iczz,Icxy,Icyz,Iczx,ee,ane)


lee=length(ee);

% Finding Generalized Inertia Matrix
% zeros amd identity matrix
o3=eye(3);
z31=zeros(3,1);
z33=zeros(3,3);

p=zeros(6,n);
A=zeros(6,6,n);
Mt=zeros(6,6,n);
Qr=zeros(3,3,n);
Im=zeros(n-1,n-1);
Ibm=zeros(n-1,6);

Dxx=zeros(n,1);Dyy=zeros(n,1);Dzz=zeros(n,1);
Dxy=zeros(n,1);Dyz=zeros(n,1);Dzx=zeros(n,1);
Ixx=zeros(n,1);Iyy=zeros(n,1);Izz=zeros(n,1);
Ixy=zeros(n,1);Iyz=zeros(n,1);Izx=zeros(n,1);

Jbe=zeros(6*lee,6);
Jme=zeros(6*lee,n-1);

phi1=q(4);th1=q(5);si1=q(6);

Q1=[cos(phi1)*cos(si1)-sin(phi1)*sin(th1)*sin(si1)   -sin(phi1)*cos(th1)     cos(phi1)*sin(si1)+sin(phi1)*sin(th1)*cos(si1)
    sin(phi1)*cos(si1)+cos(phi1)*sin(th1)*sin(si1)    cos(phi1)*cos(th1)     sin(phi1)*sin(si1)-cos(phi1)*sin(th1)*cos(si1)
    -cos(th1)*sin(si1)              sin(th1)                                  cos(th1)*cos(si1)                         ];

%L1 in fixed frame of reference
% L1=[0   cos(phi1)  -sin(phi1)*cos(th1)
%     0   sin(phi1)   cos(phi1)*cos(th1)
%     1           0   sin(th1)  ];

MM=[-sin(si1)*cos(th1)     cos(si1)     0;
    sin(th1)               0            1;
    cos(si1)*cos(th1)      sin(si1)     0];
% Qr(1:3,1:3,1)=eye(3);
% P1=[z33 o3
%     o3  z33];

Qr(1:3,1:3,1)=Q1;
P1=[z33 Q1
    Q1  z33];

i=1;
dxxs=dx(i)*dx(i);dyys=dy(i)*dy(i);dzzs=dz(i)*dz(i);dxy=dx(i)*dy(i);dyz=dy(i)*dz(i);dzx=dz(i)*dx(i);
Dxx(i)=-m(i)*(dzzs+dyys);   Dyy(i)=-m(i)*(dzzs+dxxs);   Dzz(i)=-m(i)*(dxxs+dyys);
Dxy(i)=m(i)*dxy;            Dyz(i)=m(i)*dyz;            Dzx(i)=m(i)*dzx;
Ixx(i)=Icxx(i)-Dxx(i);      Iyy(i)=Icyy(i)-Dyy(i);      Izz(i)=Iczz(i)-Dzz(i);
Ixy(i)=Icxy(i)-Dxy(i);      Iyz(i)=Icyz(i)-Dyz(i);      Izx(i)=Iczx(i)-Dzx(i);
I1=[Ixx(1)  Ixy(1)    Izx(1)
    Ixy(1)  Iyy(1)    Iyz(1)
    Izx(1)  Iyz(1)    Izz(1)];

If1=Qr(1:3,1:3,1)*I1*Qr(1:3,1:3,1).';
d11=[dx(1); dy(1); dz(1)];
d1=Qr(1:3,1:3,1)*d11;
sd1=[0 -d1(3) d1(2); d1(3) 0 -d1(1); -d1(2) d1(1) 0];
M1=[If1        m(1)*sd1
    -m(1)*sd1  m(1)*o3];
Mt(1:6,1:6,1)=M1;

for i=2:n
    Qi=[ cos(th(i))              -sin(th(i))              0
        cos(alp(i))*sin(th(i))   cos(alp(i))*cos(th(i)) -sin(alp(i))
        sin(alp(i))*sin(th(i))   sin(alp(i))*cos(th(i))  cos(alp(i))];
    Qr(1:3,1:3,i)=Qr(1:3,1:3,bt(i))*Qi;
    ei=Qr(1:3,3,i);
    ao=[a(i)
      - b(i)*sin(alp(i))
        b(i)*cos(alp(i))];
    ao=Qr(1:3,1:3,bt(i))*ao;
    
    sao=[0 -ao(3) ao(2); ao(3) 0 -ao(1); -ao(2) ao(1) 0];
    
    A(1:6,1:6,i)=[o3    z33
                 -sao   o3];
    
    p(1:6,i)=[ei
             z31];
    dxxs=dx(i)*dx(i);dyys=dy(i)*dy(i);dzzs=dz(i)*dz(i);dxy=dx(i)*dy(i);dyz=dy(i)*dz(i);dzx=dz(i)*dx(i);
    Dxx(i)=-m(i)*(dzzs+dyys);   Dyy(i)=-m(i)*(dzzs+dxxs);   Dzz(i)=-m(i)*(dxxs+dyys);
    Dxy(i)=m(i)*dxy;            Dyz(i)=m(i)*dyz;            Dzx(i)=m(i)*dzx;
    Ixx(i)=Icxx(i)-Dxx(i);      Iyy(i)=Icyy(i)-Dyy(i);      Izz(i)=Iczz(i)-Dzz(i);
    Ixy(i)=Icxy(i)-Dxy(i);      Iyz(i)=Icyz(i)-Dyz(i);      Izx(i)=Iczx(i)-Dzx(i);
    
    Ii=[Ixx(i)  Ixy(i)    Izx(i)
        Ixy(i)  Iyy(i)    Iyz(i)
        Izx(i)  Iyz(i)    Izz(i)];
    Ifi=Qr(1:3,1:3,i)*Ii*Qr(1:3,1:3,i).';
    dii=[dx(i); dy(i); dz(i)];
    di=Qr(1:3,1:3,i)*dii;
    sdi=[0 -di(3) di(2); di(3) 0 -di(1); -di(2) di(1) 0];
    Mi=[Ifi        m(i)*sdi
        -m(i)*sdi  m(i)*o3];
    Mt(1:6,1:6,i)=Mi;
end
% Finding generalised inertia matrix(GIM) I
% DeNOC
for i=n:-1:2
    Mt(1:6,1:6,bt(i))=Mt(1:6,1:6,bt(i))+A(1:6,1:6,i).'*Mt(1:6,1:6,i)*A(1:6,1:6,i);
    psi=p(1:6,i).'*Mt(1:6,1:6,i);
    Im(i-1,i-1)=psi*p(1:6,i);
    j=i;
    while bt(j)~=1
        psi=psi*A(1:6,1:6,j);
        j=bt(j);
        Im(i-1,j-1)=psi*p(1:6,j);
        Im(j-1,i-1)=Im(i-1,j-1);
    end
    Ibm(i-1,1:6)=psi*A(1:6,1:6,j)*P1;
end
Ib=P1.'*Mt(1:6,1:6,1)*P1;
% Finding generalised jacobian matrix(GJM) J
% DeNOC
for i=1:lee
    anei=Qr(1:3,1:3,ee(i))*ane(1:3,i);
    sanei=[0 -anei(3) anei(2); anei(3) 0 -anei(1); -anei(2) anei(1) 0];
    Aei=[o3    z33
        -sanei   o3];
    j=ee(i);
    Nl(6*i-5:6*i, 6*j-5:6*j)=Aei;
    j=ee(i);
    while bt(j)~=0
        Nl(6*i-5:6*i, 6*bt(j)-5:6*bt(j))=Nl(6*i-5:6*i, 6*j-5:6*j)*A(1:6,1:6,j);
        Jme(6*i-5:6*i,j-1)=Nl(6*i-5:6*i, 6*j-5:6*j)*p(1:6,j);
        j=bt(j);
    end
    Jbe(6*i-5:6*i,1:6)=Nl(6*i-5:6*i,1:6)*P1;
end
Jg2=Jbe/Ib;
Ibm = Ibm.';
GJM=Jme-Jg2*Ibm;
% % GJM1=Jme-Jbe*inv(Ib)*Ibm.';
% % GJM2=Jme-Jbe*inv(Ib)*Ibm.';
% Jme
% Jbe
% GJM=[GJM1 zeros(6,3); zeros(6,3) GJM2];


