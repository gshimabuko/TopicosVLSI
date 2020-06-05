fs=100;
T=1/fs;
L=1000;

file = "data_in.txt";
fid = fopen(file, "w");
tic
%t=0:T:L;
for (n = 1:L)
    t(n) = n*T;
    yp1(n) = 0.8*sin(0.75*2*pi*t(n)/1);
    yp2(n) = 0.7*sin(0.75*2*2*pi*t(n)/1-0.8);
    y(n)= yp1(n) + yp2(n);
    %y(n)=(y(n)+abs(y(n)))/2;
    fdisp(fid,y(n));

end;
fclose(fid);
toc
figure
    plot(t, y)
figure
    subplot(2,1,1)
        plot(t, yp1)
    subplot(2,1,2)
        plot(t, yp2)
