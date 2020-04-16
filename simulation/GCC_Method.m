function [Cxy,origin] = GCC_Method(m,s1,s2,wnd,inc)
    % 广义互相关时延估计
    % 用2个mic接收到的信号进行广义互相关，从而进行2个mic间的时延估计
    
    % 广义互相关的加权函数类型m：'standard' 'roth' 'scot' 'phat' 'ml'
    % mic1接收到信号s1
    % mic2接收到信号s2
    % hamming窗长度wnd
    % 帧移inc
    % 互相关函数Cxy
    
    N = wnd; % 帧长/窗长
    wnd = hamming(N); % (4-3)hamming窗
    x = enframe(s1,wnd,inc); % 分帧
    y = enframe(s2,wnd,inc); % 分帧
    n_frame = size(x,1); % 帧数量
    
    % figure(2);mesh(x);figure(3);mesh(y);
    
    switch lower(m)
        case 'standard'
%             for i = 1:n_frame
%                 x = s1(i:i+N); % 取1帧
%                 y = s2(i:i+N);
%                 X = fft(x,2*N-1); % 求Fourier变换
%                 Y = fft(y,2*N-1);
%                 Sxy = X.*conj(Y); % 互功率谱密度
%                 gain = 1;
%                 Cxy = fftshift(ifft(Sxy.*gain)); % 互相关函数
%                 [Gvalue(i),G(i)] = max(Cxy); % 峰值检测
%             end
                X = fft(s1,max(length(s1),length(s2))); % 求Fourier变换
                Y = fft(s2,max(length(s1),length(s2)));
                figure(1);
                subplot(2,2,2);plot(abs(fftshift(X)));xlabel('f/Hz');
                title('Amplitude response s1 at mic 1');
                subplot(2,2,4);plot(fftshift(abs(Y)));xlabel('f/Hz');
                title('Amplitude response s2 at mic 2');
                Sxy = X.*conj(Y); % 互功率谱密度
                Cxy = fftshift(ifft(Sxy)); % 互相关函数
                figure(3);
                subplot(2,1,1);plot(Cxy);
                [m,origin] = max(fftshift(ifft(X.*conj(X))));
        otherwise error('Method not defined');
    end
