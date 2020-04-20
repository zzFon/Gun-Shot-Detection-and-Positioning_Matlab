function frameout = enframing(x,win,inc)


nx = length(x);
nwin = length(win);


nf = fix((nx-nwin+inc)/inc); %ͼ(4-1)֡��nf��(nx-nwin)/inc+1
frameout = zeros(nf,nwin); % ֡��nf x ֡��len
indf = inc*(0:(nf-1)).'; % ��¼֡����ʼ��indf [0,inc,2inc,...,(nf-1)inc]
inds = (1:nwin); % ÿ֡���ݳ���ռ�ĵ� [1,2,3,...,800]

fprintf('size of x\n');
size(x)
fprintf('number of frames = %f\n',nf);
fprintf('size of indf:\n');
size(indf)
fprintf('size of inds:\n');
size(inds)

size(indf(:,ones(1,nwin)))
size(inds(ones(nf,1),:))

frameout(:) = x(indf(:,ones(1,nwin))+inds(ones(nf,1),:));

% frameout = [];
% for i = 1:nx
%     if i+nwin-1 <= nx
%         frameout = [frameout;x(1,i:i+nwin-1)];
%         i = i+inc
%     else
%         break;
%     end
% end