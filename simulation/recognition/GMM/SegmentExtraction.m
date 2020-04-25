

% first run FileReading
% so that data_gun, data_explosion ara loaded
% num_gun, num_explosion are defined in FileReading

close all;
% 提取枪声
segments_gun = zeros(num_gun,maxlen);
for ii = 1:num_gun
    
    figure(1);
    p2 = abs(fft(data_gun(ii,:))/length(data_gun(ii,:)));
    gun_fft = p2(1:length(data_gun(ii,:))/2+1);
    gun_fft(2:end-1) = 2*gun_fft(2:end-1);
    f = fs*(0:(length(data_gun(ii,:))/2))/length(data_gun(ii,:));
    subplot(4,3,ii);plot(data_gun(ii,:));xlabel('t / s');title('signal');
    %subplot(4,3,6+ii);plot(f,gun_fft);title('spectrum');xlabel('frequency / Hz');

    % 短时能量分析
    N = 300; % 窗宽（张克刚）
    inc = 100; % 帧移（张克刚）
    win = hamming(N);
    [frameout,t,energy]=enframe(data_gun(ii,:),win,inc);
    t = t';
    
    % 自适应短时能量阈值分割
    threshold = min(energy)+0.2*(max(energy)-min(energy));
    processed_energy = energy;
    for i = 1:length(energy)
        processed_energy(i) = 0;
        if energy(i) >= threshold 
            processed_energy(i) = 1;
        end
    end
    
    % 持续时间分析
    thr = 30; % 持续采样点
    cnt = 0;
    for i = 1:length(processed_energy)
        if processed_energy(i) == 1
            if cnt > 0
                cnt = cnt+1; %计数器累加
            elseif cnt == 0
                cnt = 1; %初始化计数器
            end
            if i == length(processed_energy) && cnt < thr
                processed_energy((i-cnt):i) = 0;
            end
        elseif processed_energy(i) == 0
            if cnt > 0
                if cnt < thr
                    processed_energy((i-cnt):i) = 0;
                end
            end
            cnt = 0;
        end
        %fprintf('%f, %f\n',i,processed_energy(i));
    end
    
    figure(1);
    subplot(4,3,6+ii); plot(energy,'b');title('energy');
    hold on;plot(threshold*ones(size(energy)),'g');hold off;
    subplot(4,3,6+ii);hold on;plot(processed_energy*max(energy),'r');hold off;
    %subplot(3,2,5);hold on;plot(processed_energy,'r');hold off;
    
    segments = processed_energy.*t;
    min_seg = length(segments);
    max_seg = 0;
    for i = 1:length(segments)
        if 0 < segments(i) && segments(i) < min_seg
            min_seg = segments(i);
        end
        if max_seg < segments(i)
            max_seg = segments(i);
        end
    end
    
    figure(1);
    subplot(4,3,ii);
%     segments_gun = zeros(size(data_gun(ii,:)));
%     segments_gun(floor(min_seg-N/2):ceil(max_seg+N/2)) = 1;
%     seg = data_gun(ii,:).*segments_gun;
    hold on;
    plot(floor(min_seg-N/2):ceil(max_seg+N/2),data_gun(ii,floor(min_seg-N/2):ceil(max_seg+N/2)),'r');
    hold off;
    st = floor(min_seg-N/2);
    en = ceil(max_seg+N/2);
    segments_gun(ii,5000:5000+length(data_gun(ii,st:en))-1) = data_gun(ii,st:en);
%     figure(3);
%     subplot(4,3,ii);plot(segments_gun(ii,:));
end

% 提取爆炸
segments_explosion = zeros(num_explosion,maxlen);
for ii = 1:num_explosion
    
    figure(2);
    p2 = abs(fft(data_explosion(ii,:))/length(data_explosion(ii,:)));
    explosion_fft = p2(1:length(data_explosion(ii,:))/2+1);
    explosion_fft(2:end-1) = 2*explosion_fft(2:end-1);
    f = fs*(0:(length(data_explosion(ii,:))/2))/length(data_explosion(ii,:));
    subplot(4,3,ii);plot(data_explosion(ii,:));xlabel('t / s');title('signal');
    %subplot(4,3,6+ii);plot(f,explosion_fft);title('spectrum');xlabel('frequency / Hz');

    % 短时能量分析
    N = 300; % 窗宽（张克刚）
    inc = 100; % 帧移（张克刚）
    win = hamming(N);
    [frameout,t,energy]=enframe(data_explosion(ii,:),win,inc);
    t = t';
    subplot(4,3,6+ii);hold on;plot(energy,'b');title('energy');hold off;
    
     % 均值滤波
    wnd = 50; % 阶数
    b = (1/wnd)*ones(1,wnd);
    a = 1;
    figure(2);
    sm = filter(b,a,energy);
    subplot(4,3,6+ii);hold on;plot(sm,'k');hold off;
    energy = sm;
    
    % 自适应短时能量阈值分割
    threshold = min(energy)+0.2*(max(energy)-min(energy));
    processed_energy = energy;
    for i = 1:length(energy)
        processed_energy(i) = 0;
        if energy(i) >= threshold 
            processed_energy(i) = 1;
        end
    end
    
    % 持续时间分析
    thr = 30; % 持续采样点
    cnt = 0;
    for i = 1:length(processed_energy)
        if processed_energy(i) == 1
            if cnt > 0
                cnt = cnt+1; %计数器累加
            elseif cnt == 0
                cnt = 1; %初始化计数器
            end
            if i == length(processed_energy) && cnt < thr
                processed_energy((i-cnt):i) = 0;
            end
        elseif processed_energy(i) == 0
            if cnt > 0
                if cnt < thr
                    processed_energy((i-cnt):i) = 0;
                end
            end
            cnt = 0;
        end
        %fprintf('%f, %f\n',i,processed_energy(i));
    end
    
    figure(2);
    hold on;plot(threshold*ones(size(energy)),'g');hold off;
    subplot(4,3,6+ii);hold on;plot(processed_energy*max(energy),'r');hold off;
    %subplot(3,2,5);hold on;plot(processed_energy,'r');hold off;
    
    segments = processed_energy.*t;
    min_seg = length(segments);
    max_seg = 0;
    for i = 1:length(segments)
        if 0 < segments(i) && segments(i) < min_seg
            min_seg = segments(i);
        end
        if max_seg < segments(i)
            max_seg = segments(i);
        end
    end
    
    figure(2);
    subplot(4,3,ii);
%     segments_gun = zeros(size(data_gun(ii,:)));
%     segments_gun(floor(min_seg-N/2):ceil(max_seg+N/2)) = 1;
%     seg = data_gun(ii,:).*segments_gun;
    hold on;
    plot(floor(min_seg-N/2):ceil(max_seg+N/2),data_explosion(ii,floor(min_seg-N/2):ceil(max_seg+N/2)),'r');
    hold off;
    st = floor(min_seg-N/2);
    en = ceil(max_seg+N/2);
    segments_explosion(ii,5000:5000+length(data_explosion(ii,st:en))-1) = data_explosion(ii,st:en);
%     figure(3);
%     subplot(4,3,6+ii);plot(segments_explosion(ii,:));
end
