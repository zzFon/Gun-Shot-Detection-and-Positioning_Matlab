

% close all;
% for ii = 1:6
%     figure(1);
%     subplot(3,2,ii);
%     filename = strcat('dataset_gun',num2str(ii));
%     filename = strcat(filename,'.wav');
%     [Y,fs]=audioread(filename);  %��ȡ��Ƶ�ļ�lantian.wav
%         %YΪ������˫��������
%         %fsΪ����Ƶ��
%     info=audioinfo(filename)      %audioinfo ����������Ƶ����Ϣ�����
%     sound(Y,fs)   %��������
% 
%     Y1 = Y(:,1);        %YΪ˫�������ݣ�ȡ��2ͨ��
%     figure(1)
%     plot(Y1)          %��Y1����ͼ
%     title('gun')
%     grid on;
% 
%     figure(2)
%     subplot(3,2,ii);
%     spectrogram(Y1,256,128,256,16000,'yaxis');
%     %[S,F,T,P]=spectrogram(x,window,noverlap,nfft,fs)
%     % [S,F,T,P]=spectrogram(x,window,noverlap,F,fs)
%     %x---�����źŵ�������Ĭ������£���û�к������������x�����ֳ�8�ηֱ����任����
%     % ���x���ܱ�ƽ�ֳ�8�Σ�������ضϴ���Ĭ������£�����������Ĭ��ֵΪ
%     % window---��������Ĭ��Ϊnfft���ȵĺ�����Hamming,���windowΪһ��������ÿ�γ���Ϊwindow��ÿ��ʹ��Hamming�������Ӵ���
%     % noverlap---ÿһ�ε��ص���������Ĭ��ֵ���ڸ���֮�����50%���ص�,������Ϊһ��С��window��length(window)������
%     % nfft---��FFT�任�ĳ��ȣ�Ĭ��Ϊ256�ʹ���ÿ�γ��ȵ���С2����֮������ֵ��
%     % ���⣬�˲�������ʹ��һ�������⣬������ָ��һ��Ƶ������F
%     % fs---����Ƶ�ʣ�Ĭ��ֵ��һ��Ƶ��
%     % spectrogram(...,'freqloc')ʹ��freqloc�ַ������Կ���Ƶ������ʾ��λ�á�
%     % ��freqloc=xaxisʱ��Ƶ������ʾ��x���ϣ���freqloc=yaxisʱ��Ƶ������ʾ��y���ϣ�Ĭ������ʾ��x���ϡ������ָ��freqloc��ͬʱ�����������������freqloc�������ԡ�
%     % F---�����������ʹ��FƵ��������������ʹ��Goertzel����������Fָ����Ƶ�ʴ�����Ƶ��ͼ��
%     % ָ����Ƶ�ʱ��������뵽���źŷֱ�����ص������DFT����(bin)�С�����������ʹ��nfft
%     % �﷨�У���ʱ����Ҷ�任��������ʹ�á����ڷ���ֵ�е�F������Ϊ���������Ƶ�ʣ��䳤��
%     % ����S��������
%     % T---Ƶ��ͼ�����ʱ�̵㣬�䳤�ȵ������涨���k��ֵΪ���ָ��ε��е㡣
%     % P---�������ܶ�PSD(Power Spectral Density)������ʵ�źţ�P�Ǹ���PSD�ĵ������ڹ��ƣ�
%     xlabel('ʱ��(s)');
%     ylabel('Ƶ��(Hz)');
%     title('gun');
% end
% 
% for ii = 1:6
%     figure(3);
%     subplot(3,2,ii);
%     filename = strcat('dataset_explosion',num2str(ii));
%     filename = strcat(filename,'.wav');
%     [Y,fs]=audioread(filename);  %��ȡ��Ƶ�ļ�lantian.wav
%         %YΪ������˫��������
%         %fsΪ����Ƶ��
%     info=audioinfo(filename)      %audioinfo ����������Ƶ����Ϣ�����
%     sound(Y,fs)   %��������
% 
%     Y1 = Y(:,1);        %YΪ˫�������ݣ�ȡ��2ͨ��
%     figure(3)
%     plot(Y1)          %��Y1����ͼ
%     title('explosion')
%     grid on;
% 
%     figure(4);
%     subplot(3,2,ii);
%     spectrogram(Y1,256,128,256,16000,'yaxis');
%     %[S,F,T,P]=spectrogram(x,window,noverlap,nfft,fs)
%     % [S,F,T,P]=spectrogram(x,window,noverlap,F,fs)
%     %x---�����źŵ�������Ĭ������£���û�к������������x�����ֳ�8�ηֱ����任����
%     % ���x���ܱ�ƽ�ֳ�8�Σ�������ضϴ���Ĭ������£�����������Ĭ��ֵΪ
%     % window---��������Ĭ��Ϊnfft���ȵĺ�����Hamming,���windowΪһ��������ÿ�γ���Ϊwindow��ÿ��ʹ��Hamming�������Ӵ���
%     % noverlap---ÿһ�ε��ص���������Ĭ��ֵ���ڸ���֮�����50%���ص�,������Ϊһ��С��window��length(window)������
%     % nfft---��FFT�任�ĳ��ȣ�Ĭ��Ϊ256�ʹ���ÿ�γ��ȵ���С2����֮������ֵ��
%     % ���⣬�˲�������ʹ��һ�������⣬������ָ��һ��Ƶ������F
%     % fs---����Ƶ�ʣ�Ĭ��ֵ��һ��Ƶ��
%     % spectrogram(...,'freqloc')ʹ��freqloc�ַ������Կ���Ƶ������ʾ��λ�á�
%     % ��freqloc=xaxisʱ��Ƶ������ʾ��x���ϣ���freqloc=yaxisʱ��Ƶ������ʾ��y���ϣ�Ĭ������ʾ��x���ϡ������ָ��freqloc��ͬʱ�����������������freqloc�������ԡ�
%     % F---�����������ʹ��FƵ��������������ʹ��Goertzel����������Fָ����Ƶ�ʴ�����Ƶ��ͼ��
%     % ָ����Ƶ�ʱ��������뵽���źŷֱ�����ص������DFT����(bin)�С�����������ʹ��nfft
%     % �﷨�У���ʱ����Ҷ�任��������ʹ�á����ڷ���ֵ�е�F������Ϊ���������Ƶ�ʣ��䳤��
%     % ����S��������
%     % T---Ƶ��ͼ�����ʱ�̵㣬�䳤�ȵ������涨���k��ֵΪ���ָ��ε��е㡣
%     % P---�������ܶ�PSD(Power Spectral Density)������ʵ�źţ�P�Ǹ���PSD�ĵ������ڹ��ƣ�
%     xlabel('ʱ��(s)');
%     ylabel('Ƶ��(Hz)');
%     title('explosion');
% end
% 
for ii = 1:6
%     figure(5);
%     subplot(3,2,ii);
%     filename = strcat('a',num2str(ii));
%     filename = strcat(filename,'.wav');
    filename = 'horn.wav'
    [Y,fs]=audioread(filename);  %��ȡ��Ƶ�ļ�lantian.wav
        %YΪ������˫��������
        %fsΪ����Ƶ��
    info=audioinfo(filename)      %audioinfo ����������Ƶ����Ϣ�����
    sound(Y,fs)   %��������

    Y1 = Y(:,1);        %YΪ˫�������ݣ�ȡ��2ͨ��
    figure(5)
    plot(Y1)          %��Y1����ͼ
    title('background')
    grid on;

    figure(6);
    subplot(3,2,ii);
    spectrogram(Y1,256,128,256,16000,'yaxis');
    %[S,F,T,P]=spectrogram(x,window,noverlap,nfft,fs)
    % [S,F,T,P]=spectrogram(x,window,noverlap,F,fs)
    %x---�����źŵ�������Ĭ������£���û�к������������x�����ֳ�8�ηֱ����任����
    % ���x���ܱ�ƽ�ֳ�8�Σ�������ضϴ���Ĭ������£�����������Ĭ��ֵΪ
    % window---��������Ĭ��Ϊnfft���ȵĺ�����Hamming,���windowΪһ��������ÿ�γ���Ϊwindow��ÿ��ʹ��Hamming�������Ӵ���
    % noverlap---ÿһ�ε��ص���������Ĭ��ֵ���ڸ���֮�����50%���ص�,������Ϊһ��С��window��length(window)������
    % nfft---��FFT�任�ĳ��ȣ�Ĭ��Ϊ256�ʹ���ÿ�γ��ȵ���С2����֮������ֵ��
    % ���⣬�˲�������ʹ��һ�������⣬������ָ��һ��Ƶ������F
    % fs---����Ƶ�ʣ�Ĭ��ֵ��һ��Ƶ��
    % spectrogram(...,'freqloc')ʹ��freqloc�ַ������Կ���Ƶ������ʾ��λ�á�
    % ��freqloc=xaxisʱ��Ƶ������ʾ��x���ϣ���freqloc=yaxisʱ��Ƶ������ʾ��y���ϣ�Ĭ������ʾ��x���ϡ������ָ��freqloc��ͬʱ�����������������freqloc�������ԡ�
    % F---�����������ʹ��FƵ��������������ʹ��Goertzel����������Fָ����Ƶ�ʴ�����Ƶ��ͼ��
    % ָ����Ƶ�ʱ��������뵽���źŷֱ�����ص������DFT����(bin)�С�����������ʹ��nfft
    % �﷨�У���ʱ����Ҷ�任��������ʹ�á����ڷ���ֵ�е�F������Ϊ���������Ƶ�ʣ��䳤��
    % ����S��������
    % T---Ƶ��ͼ�����ʱ�̵㣬�䳤�ȵ������涨���k��ֵΪ���ָ��ε��е㡣
    % P---�������ܶ�PSD(Power Spectral Density)������ʵ�źţ�P�Ǹ���PSD�ĵ������ڹ��ƣ�
    xlabel('ʱ��(s)');
    ylabel('Ƶ��(Hz)');
    title('background');
end


