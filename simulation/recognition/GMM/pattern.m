







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
% wp=[0.5*2*pi/Fs,50*2*pi/Fs];                %����ͨ�����ֽ�Ƶ��
% ws=[0.25*2*pi/Fs,55*2*pi/Fs];                %����������ֽ�Ƶ��
% [N,Wn]=buttord(wp,ws,Rp,Rs,'s');        %�������˹�˲�������N�ͽ�ֹƵ��Wn
% %�����Ǹ�ͨ����ͨ�ʹ����˲���������������ն���Ч��һ����ֹƵ��ΪWn�ĵ�ͨ�˲���(������Ҳ���Ǻ����Ϊɶ���������Ͼ���Ҳ�ǸսӴ��˲���)
% fprintf('������˹�˲��� N= %4d\n',N);    %��ʾ�˲�������
% [bb,ab]=butter(N,Wn,'s');               %�������˹�˲���ϵ���������亯���ķ��Ӻͷ�ĸ��ϵ������
% b2=filter(bb,ab,b);                     %filter���ܽ���IIR�˲����ܽ���FIR�˲�

windowSize = 5000; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;

subplot(3,1,3);plot(filter(b,a,y));