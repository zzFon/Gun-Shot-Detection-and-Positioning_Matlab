

%[x,fs] = audioread('s1.wav');

% %%% ∑÷÷° %%%
% N = 800; % ÷°≥§/¥∞≥§
% inc = round(N/3); % ÷°“∆
% wnd = hamming(N); % (4-3)hamming¥∞
% frames = enframe(x',wnd,inc); % ∑÷÷°
% fprintf('frames: \n');
% size(frames)

%%% draw x %%%
p2 = abs(fft(x/length(gun0)));
x_fft = p2(1:length(x)/2+1);
x_fft(2:end-1) = 2*x_fft(2:end-1);
subplot(2,1,1);plot(x);subplot(2,1,2);plot(x_fft);

pre_sph = filter([1-0.97],1,x);
win_type = 'm';
cof_num = 20;
frm_len = fs*0.02;
fil_num = 20;
frm_off = fs*0.01;
c = melcepst(pre_sph,fs,win_type,cof_num,fil_num,frm_len,frm_off);
cof = c(:,1:end-1);


