clear all;
Spk_num=2; %说话人个数
Tra_num=6;  %每个说话人用于训练的语音数目

ncentres=16; %混合成分数目
fs=16000; %采样频率


% -- 训练 ---
load tra_data.mat; 
load bkg.mat;
load gun.mat
for spk_cyc=1:Spk_num    % 遍历说话人
  fprintf('training for speaker %i\n',spk_cyc);
  tag1=1;tag2=1; %用于汇总存储mfcc
  
  cnt = 0;
  for sph_cyc=1:Tra_num  % 遍历语音
     % speech = tdata{spk_cyc}{sph_cyc}; 
     % size(background)
     fprintf('pre-processing data %d\n',sph_cyc);
     if spk_cyc == 1
      	speech = bkg(sph_cyc,:);
     elseif spk_cyc == 2
        speech = gun(sph_cyc,:);
     end
     
     
      %---预处理,特征提取--
     pre_sph=filter([1 -0.97],1,speech); % 预加重
     win_type='M'; %汉明窗
     cof_num=20; %倒谱系数个数
     frm_len=fs*0.02; %帧长：20ms
     fil_num=20; %滤波器组个数
     frm_off=fs*0.01; %帧移：10ms
     
%      figure(spk_cyc);
%      subplot(3,2,sph_cyc);plot(speech);
%      player = audioplayer(pre_sph,fs);
%      player.play;
%      pause(3);
     
     c=melcepst(pre_sph,fs,win_type,cof_num,fil_num,frm_len,frm_off); % mfcc特征提取
     cc=c(:,1:end-1)';
     tag2=tag1+size(cc,2);
     cof(:,tag1:tag2-1)=cc;
     tag1=tag2;
  end
   
  %--- 训练GMM模型---
  kiter=5; %Kmeans的最大迭代次数
  emiter=30; %EM算法的最大迭代次数
  fprintf('initializing GMM...\n');
  mix=gmm_init(ncentres,cof',kiter,'full'); % GMM的初始化
  fprintf('training GMM...\n');
  [mix,post,errlog]=gmm_em(mix,cof',emiter); % GMM的参数估计
  speaker{spk_cyc}.pai=mix.priors;
  speaker{spk_cyc}.mu=mix.centres;
  speaker{spk_cyc}.sigma=mix.covars;

  clear cof mix;
end
fprintf('FINISHED！\n',spk_cyc);
save speaker.mat speaker;











