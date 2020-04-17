

[gun,fs] = wavread('gun0.wav');
figure(1);
hold on;
plot(fftshift(fft(gun)));
for i = 1:10
    file = strcat('a',num2str(i));
    [y,fs] = wavread(file);   
    plot(fftshift(abs(fft(y))));
end
hold onf
audioplayer(y,fs);