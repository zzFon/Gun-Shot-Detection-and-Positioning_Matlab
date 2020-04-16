

% 声源
source = [200,200,1.5];fprintf('source = (%f,%f,%f)\n',source(1),source(2),source(3));
% mic线阵列
mic1 = [0,0,1.5];fprintf(' mic 1 = (%f,%f,%f)\n',mic1(1),mic1(2),mic1(3));
mic2 = [0.1,0,1.5];fprintf(' mic 2 = (%f,%f,%f)\n',mic2(1),mic2(2),mic2(3));
% 房间
rm = [500,500,10];

fs = 10000; % mic采样频率
n = 0; % 反射阶数
r = 0; % 墙面反射率
figure(1);
% mic 1
h1 = 100*rir( fs,mic1,n,r,rm,source);
s1 = h1+0.05*rand(length(h1),1);
subplot(2,2,1);plot(s1);
title('response at mic 1');xlabel('delay/sampling points');axis auto;
% mic 2
h2 = 100*rir( fs,mic2,n,r,rm,source);
s2 = h2+0.05*rand(length(h2),1);
subplot(2,2,3);plot(s2);
title('response at mic 2');xlabel('delay/sampling points');axis auto;


% 基于互相关的时延估计
wnd = 150; % hamming窗长度，采样频率10kHz下窗口取100-200个点比较合适
inc = (1/3)*wnd; % 帧移一般取帧长/窗长的0-1/2
[Cxy,origin] = GCC_Method('standard',s1,s2,wnd,inc);
[m,mp] = max(Cxy);
figure(3);
subplot(2,1,2);plot(-origin:-origin+length(Cxy)-1,Cxy);
xlabel('\tau');title('correlation R_{xy}(\tau)');
hold on;scatter(mp-origin,m,'r');hold off;
fprintf('theoretical delay = %f s\n',abs(sqrt((mic1(1)-source(1)).^2+(mic1(2)-source(2)).^2+(mic1(3)-source(3)).^2)-sqrt((mic2(1)-source(1)).^2+(mic2(2)-source(2)).^2+(mic2(3)-source(3)).^2))/343);
fprintf('relative delay = %f s\n',abs(mp-origin)*0.0001);

figure(2);
hold on; axis([0,500,0,500]);
scatter(mic1(1),mic1(2),'ro');
scatter(mic2(1),mic2(2),'ro');
scatter(source(1),source(2),'k*');
hold off;


