function [Cxy,origin] = GCC_Method(m,s1,s2,wnd,inc)
    % ���廥���ʱ�ӹ���
    % ��2��mic���յ����źŽ��й��廥��أ��Ӷ�����2��mic���ʱ�ӹ���
    
    % ���廥��صļ�Ȩ��������m��'standard' 'roth' 'scot' 'phat' 'ml'
    % mic1���յ��ź�s1
    % mic2���յ��ź�s2
    % hamming������wnd
    % ֡��inc
    % ����غ���Cxy
    
    N = wnd; % ֡��/����
    wnd = hamming(N); % (4-3)hamming��
    x = enframe(s1,wnd,inc); % ��֡
    y = enframe(s2,wnd,inc); % ��֡
    n_frame = size(x,1); % ֡����
    
    % figure(2);mesh(x);figure(3);mesh(y);
    
    switch lower(m)
        case 'standard'
%             for i = 1:n_frame
%                 x = s1(i:i+N); % ȡ1֡
%                 y = s2(i:i+N);
%                 X = fft(x,2*N-1); % ��Fourier�任
%                 Y = fft(y,2*N-1);
%                 Sxy = X.*conj(Y); % ���������ܶ�
%                 gain = 1;
%                 Cxy = fftshift(ifft(Sxy.*gain)); % ����غ���
%                 [Gvalue(i),G(i)] = max(Cxy); % ��ֵ���
%             end
                X = fft(s1,max(length(s1),length(s2))); % ��Fourier�任
                Y = fft(s2,max(length(s1),length(s2)));
                figure(1);
                subplot(2,2,2);plot(abs(fftshift(X)));xlabel('f/Hz');
                title('Amplitude response s1 at mic 1');
                subplot(2,2,4);plot(fftshift(abs(Y)));xlabel('f/Hz');
                title('Amplitude response s2 at mic 2');
                Sxy = X.*conj(Y); % ���������ܶ�
                Cxy = fftshift(ifft(Sxy)); % ����غ���
                figure(3);
                subplot(2,1,1);plot(Cxy);
                [m,origin] = max(fftshift(ifft(X.*conj(X))));
        otherwise error('Method not defined');
    end
