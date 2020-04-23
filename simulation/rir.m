function h = rir( fs,mic,n,r,rm,src )
    % 单声源单传音器房间回响的IMAGE模型

    % 采样频率fs
    % 麦克风位置mic
    % 反射阶数n：考虑反射和3个空间维度总共有(2n+1)^3个声源（虚拟+原来）    
    % 墙壁反射系数r
    % 房间尺寸rm
    % 声源位置src
    % example：h = rir(100,[9,15,1.5],1,0.4,[40,40,3],[21,25,1.5])
    
    nn = [-n:1:n]; % 1个维度里（虚拟+原来）声源个数nn
    rms = nn+0.5-0.5*(-1).^nn; % (9-1)(9-2)中x_r的系数
    srcs = (-1).^(nn); % (9-1)(9-2)中x_s的系数
    % i j k 分别为 x y z 轴上的虚拟声源序号，i=0为真声源
    xm = mic(1);ym = mic(2);zm = mic(3); % 传声器位置，分解到3个1维
    xs = src(1);ys = src(2);zs = src(3); % 声源位置
    xr = rm(1);yr = rm(2);zr = rm(3); % 房间尺寸
    xi = [srcs*xs+rms*xr-xm]; % (9-2)
    yj = [srcs*ys+rms*yr-ym]; % (9-3) y维度
    zk = [srcs*zs+rms*zr-zm]; % (9-4) z维度
    
    % 以下计算各波的延迟点数
    [i,j,k] = meshgrid(xi,yj,zk); 
    d = sqrt(i.^2+j.^2+k.^2); % 各声源-原点距离
    time = round(fs*(d/343))+1; % (9-6)延迟点数time，波速343m/s
    
    % 以下计算各声源的amplitude系数，这是因为考虑墙壁反射衰减amplitude
    [e,f,g] = meshgrid(nn,nn,nn); % 枚举（虚拟+原来）声源
    c = r.^(abs(e)+abs(f)+abs(g)); % (9-9)墙壁总反射系数
    e = c./d; % (9-10)回响amplitude系数e
    
    % 冲激响应（声源发出一个冲激，传声器输出的响应）
    h = full(sparse(time(:),1,e(:))); % 参见sparse(i,j,v)
    % 对于元组(time(:),1)，如果多行的这个元组相同
    % 那么(time(:),1,e(:))的e累加，使得这多元组合并为1个元组
    % 也就是将声源-传声器距离相同的声源的amplitude系数e合并
    
    % plot(h);title('response of Mic w.r.t. an impulse from source');
    
end
