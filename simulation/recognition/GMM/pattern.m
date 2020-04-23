







[y,fs] = audioread('gun3.wav');
T = 1;
t = 1;
% u = [];
v = y;

% while 1
%     u = [u,t];
%     v = [v,y(t)];
%     t = t+T;
%     if t >= length(y)
%         break;
%     end
% end
subplot(3,1,1);plot(v);

p2 = fft(v/length(v));
p1 = abs(p2);
v_fft = p1(1:length(v)/2+1);
v_fft(2:end-1) = 2*v_fft(2:end-1);
% for i = 5000:30000
%     v_fft(i) = 0;
% end
figure(2);
hold off;
subplot(3,1,2);plot(v_fft);


% Fs=512;
% wp=[0.5*2*pi/Fs,50*2*pi/Fs];                %设置通带数字角频率
% ws=[0.25*2*pi/Fs,55*2*pi/Fs];                %设置阻带数字角频率
% [N,Wn]=buttord(wp,ws,Rp,Rs,'s');        %求巴特沃斯滤波器阶数N和截止频率Wn
% %无论是高通、带通和带阻滤波器，在设计中最终都等效于一个截止频率为Wn的低通滤波器(我现在也不是很理解为啥是这样，毕竟我也是刚接触滤波器)
% fprintf('巴特沃斯滤波器 N= %4d\n',N);    %显示滤波器阶数
% [bb,ab]=butter(N,Wn,'s');               %求巴特沃斯滤波器系数，即求传输函数的分子和分母的系数向量
% b2=filter(bb,ab,b);                     %filter既能进行IIR滤波又能进行FIR滤波

windowSize = 5000; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

subplot(3,1,3);plot(filter(b,a,y));