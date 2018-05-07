function [ output_args ] = plot_tor( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
clear statevar;
clear timevar;
let=length(T);

[n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx]=inputs();
torque=zeros(let,n-1+6);
for k =1:let
    q=Y(k,1:6)';
    th=Y(k,6:6+n-1)';
    nqn=6+n;
    dq=Y(k,nqn:nqn+6-1)';
    dth=Y(k,nqn+6-1:2*(n+6-1))';
    
    %Joint Torque
    [tu_q tu_th] = torque(t, n, Tp, q, th, dq, dth);
    tue=[tu_q; tu_th];
    
    torque(k,:)=tue;
    
end

plot(T,torque)
end

