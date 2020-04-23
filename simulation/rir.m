function h = rir( fs,mic,n,r,rm,src )
    % ����Դ����������������IMAGEģ��

    % ����Ƶ��fs
    % ��˷�λ��mic
    % �������n�����Ƿ����3���ռ�ά���ܹ���(2n+1)^3����Դ������+ԭ����    
    % ǽ�ڷ���ϵ��r
    % ����ߴ�rm
    % ��Դλ��src
    % example��h = rir(100,[9,15,1.5],1,0.4,[40,40,3],[21,25,1.5])
    
    nn = [-n:1:n]; % 1��ά�������+ԭ������Դ����nn
    rms = nn+0.5-0.5*(-1).^nn; % (9-1)(9-2)��x_r��ϵ��
    srcs = (-1).^(nn); % (9-1)(9-2)��x_s��ϵ��
    % i j k �ֱ�Ϊ x y z ���ϵ�������Դ��ţ�i=0Ϊ����Դ
    xm = mic(1);ym = mic(2);zm = mic(3); % ������λ�ã��ֽ⵽3��1ά
    xs = src(1);ys = src(2);zs = src(3); % ��Դλ��
    xr = rm(1);yr = rm(2);zr = rm(3); % ����ߴ�
    xi = [srcs*xs+rms*xr-xm]; % (9-2)
    yj = [srcs*ys+rms*yr-ym]; % (9-3) yά��
    zk = [srcs*zs+rms*zr-zm]; % (9-4) zά��
    
    % ���¼���������ӳٵ���
    [i,j,k] = meshgrid(xi,yj,zk); 
    d = sqrt(i.^2+j.^2+k.^2); % ����Դ-ԭ�����
    time = round(fs*(d/343))+1; % (9-6)�ӳٵ���time������343m/s
    
    % ���¼������Դ��amplitudeϵ����������Ϊ����ǽ�ڷ���˥��amplitude
    [e,f,g] = meshgrid(nn,nn,nn); % ö�٣�����+ԭ������Դ
    c = r.^(abs(e)+abs(f)+abs(g)); % (9-9)ǽ���ܷ���ϵ��
    e = c./d; % (9-10)����amplitudeϵ��e
    
    % �弤��Ӧ����Դ����һ���弤���������������Ӧ��
    h = full(sparse(time(:),1,e(:))); % �μ�sparse(i,j,v)
    % ����Ԫ��(time(:),1)��������е����Ԫ����ͬ
    % ��ô(time(:),1,e(:))��e�ۼӣ�ʹ�����Ԫ��ϲ�Ϊ1��Ԫ��
    % Ҳ���ǽ���Դ-������������ͬ����Դ��amplitudeϵ��e�ϲ�
    
    % plot(h);title('response of Mic w.r.t. an impulse from source');
    
end
