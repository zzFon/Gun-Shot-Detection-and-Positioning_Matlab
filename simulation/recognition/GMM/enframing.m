function frameout = enframe(x,win,inc)
    % �Ӵ��ڷ�֡
    
    % ���������ź�x
    % ֡����/������win
    % ֡��inc
    
    nx = length(x); % �źų���nx
    nwin = length(win); % ���ڳ���nwin
    if(nwin == 1) 
        len = win; % ���ڳ���Ϊ1˵��û�����ô�����
    else
        len = nwin; % ���ڳ���nwin
    end
    if(nargin<3)
        inc = len; % ���֡��incȱʡ
    end
    nf = fix((nx-len+inc)/inc); %ͼ(4-1)֡��nf��(nx-len)/inc+1
    frameout = zeros(nf,len); % ֡��nf x ֡��len
    indf = inc*(0:(nf-1)).'; % ��¼֡����ʼ��indf
    inds = (1:len); % ÿ֡���ݳ���ռ�ĵ�
    frameout(:) = x(indf(:,ones(1,len))+inds(ones(nf,1),:));
    if(nwin>1)
        w = win(:)';
        frameout = frameout.*w(ones(nf,1),:);
    end
end