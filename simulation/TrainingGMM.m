

% first run FileReading & SegmentExtraction
% clear all;
% close all;

Spk_num = 2; %˵���˸���
Tra_num = 6;  %ÿ��˵��������ѵ����������Ŀ

ncentres = 4; %��ϳɷ���Ŀ
% fs = 16000; %����Ƶ��


% -- ѵ�� ---
% load tra_data.mat; 
% load bkg.mat;
% load gun.mat
cnt = 0;
for spk_cyc = 1:Spk_num    % ����˵����
  fprintf('training for speaker %i\n',spk_cyc);
  tag1=1;tag2=1; %���ڻ��ܴ洢mfcc
  
  for sph_cyc=1:Tra_num  % ��������
     % speech = tdata{spk_cyc}{sph_cyc}; 
     % size(background)
     fprintf('pre-processing data %d\n',sph_cyc);
     if spk_cyc == 1
      	speech = segments_gun(sph_cyc,:);
     elseif spk_cyc == 2
        speech = segments_horn(sph_cyc,:);
     end
     cnt = cnt+1;
     figure(10);
     subplot(4,3,cnt);plot(speech);
     
      %---Ԥ����,������ȡ--
     %pre_sph=filter([1 -0.97],1,speech); % Ԥ����
     pre_sph = speech;
     win_type='M'; %������
     cof_num=20; %����ϵ������
     frm_len=fs*0.02; %֡����20ms
     fil_num=20; %�˲��������
     frm_off=fs*0.01; %֡�ƣ�10ms
     
%      figure(spk_cyc);
%      subplot(3,2,sph_cyc);plot(speech);
%      player = audioplayer(pre_sph,fs);
%      player.play;
%      pause(3);
     
     c=melcepst(pre_sph,fs,win_type,cof_num,fil_num,frm_len,frm_off); % mfcc������ȡ
     size(c)
     cc=c(:,1:end-1)';
     tag2=tag1+size(cc,2);
     cof(:,tag1:tag2-1)=cc;
     tag1=tag2;
  end
   
  %--- ѵ��GMMģ��---
  kiter=5; %Kmeans������������
  emiter=30; %EM�㷨������������
  fprintf('initializing GMM...\n');
  mix=gmm_init(ncentres,cof',kiter,'full'); % GMM�ĳ�ʼ��
  fprintf('training GMM...\n');
  [mix,post,errlog]=gmm_em(mix,cof',emiter); % GMM�Ĳ�������
  speaker{spk_cyc}.pai=mix.priors;
  speaker{spk_cyc}.mu=mix.centres;
  speaker{spk_cyc}.sigma=mix.covars;

  clear cof mix;
end
fprintf('FINISHED!\n',spk_cyc);
save speaker.mat speaker;











