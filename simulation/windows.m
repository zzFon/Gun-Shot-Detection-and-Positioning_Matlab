

N = 32;nn = 0:(N-1);
% rectangular window
w = boxcar(N);subplot(3,1,1);stem(nn,w);
xlabel('points');ylabel('Amplitude');title('rectangular window');
wvtool(w);
% hamming window
w = hamming(N);subplot(3,1,2);stem(nn,w);
xlabel('points');ylabel('Amplitude');title('hamming window');
wvtool(w);
% hanning window
w = hanning(N);subplot(3,1,3);stem(nn,w);
xlabel('points');ylabel('Amplitude');title('hanning window');
wvtool(w);