clc;
clear all;
%function [Mt, Jt]=Eqn_matrix_T(It,rtb)

syms mt1 mt2 rx1 ry1 rz1 rx2 ry2 rz2 px1 py1 px2 py2 Itxx1 Ityy1 Itzz1  Itxx2 Ityy2 Itzz2

%mt=50; Itxx=1;Ityy=1; Itzz=1;
%Target EOM

Jt=vpa(zeros(6,6));
Mt=vpa(zeros(6,6));
It1=[Itzz1];
It2=[Itzz2];
Mt(1,1)=It1;
Mt(2,2)=It2;
Mt(3,3)=mt1;
Mt(4,4)=mt1;
Mt(5,5)=mt2;
Mt(6,6)=mt2;

rb1=[rx1;ry1]
rb2=[rx2;ry2]
pbe1=[0;0];%[px1;py1]
pbe2=[0;0];%[px2;py2]
rtb1=pbe1-rb1
rtb2=pbe2-rb2

Rtb1(2,1)=-rtb1(1)
Rtb1(1,1)=rtb1(2)


Rtb2(2,1)=-rtb2(1)
Rtb2(1,1)=rtb2(2)

Jt(2:3,1)=Rtb1
Jt(1,1)=1;
Jt(2,2)=1;
Jt(3,3)=1;
Jt(5:6,4)=Rtb2
Jt(4,4)=1;
Jt(5,5)=1;
Jt(6,6)=1;
