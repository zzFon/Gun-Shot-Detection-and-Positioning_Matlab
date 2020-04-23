function frameout = enframe(x,win,inc)
    % 加窗口分帧
    
    % 输入语音信号x
    % 帧长度/窗函数win
    % 帧移inc
    
    nx = length(x); % 信号长度nx
    nwin = length(win); % 窗口长度nwin
    if(nwin == 1) 
        len = win; % 窗口长度为1说明没有设置窗函数
    else
        len = nwin; % 窗口长度nwin
    end
    if(nargin<3)
        inc = len; % 如果帧移inc缺省
    end
    nf = fix((nx-len+inc)/inc); %图(4-1)帧数nf，(nx-len)/inc+1
    frameout = zeros(nf,len); % 帧数nf x 帧长len
    indf = inc*(0:(nf-1)).'; % 记录帧移起始点indf
    inds = (1:len); % 每帧数据长度占的点
    frameout(:) = x(indf(:,ones(1,len))+inds(ones(nf,1),:));
    if(nwin>1)
        w = win(:)';
        frameout = frameout.*w(ones(nf,1),:);
    end
end