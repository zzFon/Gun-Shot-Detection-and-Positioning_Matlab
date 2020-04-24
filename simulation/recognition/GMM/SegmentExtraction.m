

% first run FileReading
% so that data_gun, data_explosion ara loaded
% num_gun, num_explosion are defined in FileReading

for ii = 1:num_gun
    
    figure(1);
    p2 = abs(fft(data_gun(ii,:))/length(data_gun(ii,:)));
    gun_fft = p2(1:length(data_gun(ii,:))/2+1);
    gun_fft(2:end-1) = 2*gun_fft(2:end-1);
    f = fs*(0:(length(data_gun(ii,:))/2))/length(data_gun(ii,:));
    subplot(4,3,ii);plot(data_gun(ii,:));xlabel('t / s');title('signal');
    %subplot(4,3,6+ii);plot(f,gun_fft);title('spectrum');xlabel('frequency / Hz');

    % ��ʱ��������
    N = 300; % �������ſ˸գ�
    inc = 100; % ֡�ƣ��ſ˸գ�
    win = hamming(N);
    [frameout,t,energy]=enframe(data_gun(ii,:),win,inc);
    t = t';
    
    % ����Ӧ��ʱ������ֵ�ָ�
    threshold = min(energy)+0.2*(max(energy)-min(energy));
    processed_energy = energy;
    for i = 1:length(energy)
        processed_energy(i) = 0;
        if energy(i) >= threshold 
            processed_energy(i) = 1;
        end
    end
    
    % ����ʱ�����
    thr = 30; % ����������
    cnt = 0;
    for i = 1:length(processed_energy)
        if processed_energy(i) == 1
            if cnt > 0
                cnt = cnt+1; %�������ۼ�
            elseif cnt == 0
                cnt = 1; %��ʼ��������
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
    segments_gun = data_gun(ii,floor(min_seg-N/2):ceil(max_seg+N/2));
    
end