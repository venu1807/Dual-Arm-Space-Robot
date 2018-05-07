v=10:10:80;
f=[27 50 70 89  450 678 890 1000];
figure

% loglog(v,f)
hold on
vf=0:100;
ff=0.2741*vf.^1.9842;

 loglog(v,f,'d',vf,ff,':')