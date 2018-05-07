function[]=energy()
load statevar.dat;
load timevar.dat;
Y=statevar;T=timevar;
let=length(T);
kine=zeros(let,1);
pote=zeros(let,1);

[n nq alp a b bt dx dy dz al alt m g  Icxx Icyy Iczz Icxy Icyz Iczx]=inputs();
for k =1:let
    q=Y(k,1:6)';
    th=Y(k,6:6+n-1)';
    nqn=6+n;
    dq=Y(k,nqn:nqn+6-1)';
    dth=Y(k,nqn+6-1:2*(n+6-1))';
    [sof stf scf vc tt ]=forward_kine(q,th, dq, dth, n, alp, a, b, bt, dx, dy, dz,al, alt);
    KE=0;
    PE=0;
    for j=1:n
        % FINDING W=M*dt+W*M*E*T+wg  
        It=[Icxx(j) Icxy(j)    Iczx(j)
            Icxy(j)  Icyy(j)    Icyz(j)
            Iczx(j)  Icyz(j)    Iczz(j)]; 
       PE=PE+m(j)*g'*scf(:,j);
       KE=KE+0.5*(m(j)*vc(:,j)'*vc(:,j)+tt(:,j)'*It'*tt(:,j));
    end
    kine(k)=KE;
    pote(k)=PE;
end
GE=Y(:,2*(n+6-1)+1);
AE=Y(:,2*(n+6-1)+2);
TE=kine+pote+GE+AE;

fh1=figure(13);
set(fh1, 'color', 'white'); % sets the color to white 
subplot(2,1,1)
plot(T,TE,T,pote);
set (gca,'fontsize',8,'fontweight','bold','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% title(' ENERGY BALANCE OF SIMULATION THROUGH LSIM ','FontSize',14);
xlabel('time (s)','FontSize',8);
ylabel('Energy (J)','FontSize',8);
h=legend('Total','PE');
set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','best','fontsize',8,'fontweight','bold','fontname','times new romans','linewidth',0.5)
subplot(2,1,2)
plot(T,AE,T,GE,T,kine);
set (gca,'fontsize',8,'fontweight','bold','fontname','times new romans','linewidth',0.5,'Box', 'off','TickDir','out' );
% title(' ENERGY BALANCE OF SIMULATION THROUGH LSIM ','FontSize',14);
xlabel('time (s)','FontSize',8);
ylabel('Energy (J)','FontSize',8);
h=legend('Actuators','Ground','KE');
set(h,'Orientation','horizontal','Color', 'none','Box', 'off','Location','best','fontsize',8,'fontweight','bold','fontname','times new romans','linewidth',0.5)

accumulated_error=(sum(TE-TE(1))*100)/TE(1)
maximum_ele_error=(max(abs(TE-TE(1)))*100)/TE(1)
