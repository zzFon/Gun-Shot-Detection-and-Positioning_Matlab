

% first run FileReading & SegmentExtraction
clear all;
close all;
FileReading;close all;
SegmentExtraction;close all;

Spk_num = 3; %˵���˸���
Tra_start = 1;
Tra_end = 6;  %ÿ��˵��������ѵ����������Ŀ

ncentres = 16; %��ϳɷ���Ŀ
% fs = 16000; %����Ƶ��


% -- ѵ�� ---
% load tra_data.mat; 
% load bkg.mat;
% load gun.mat
cnt = 0;
for spk_cyc = 1:Spk_num    % ����˵����
  fprintf('training for speaker %i\n',spk_cyc);
  tag1=1;tag2=1; %���ڻ��ܴ洢mfcc
  
  for sph_cyc = Tra_start:Tra_end  % ��������
     % speech = tdata{spk_cyc}{sph_cyc}; 
     % size(background)
     fprintf('pre-processing data %d\n',sph_cyc);
     if spk_cyc == 1
      	%speech = segments_gun(sph_cyc,:);
%         if sph_cyc <= 6
            speech = piece_gun{1,sph_cyc};
%         else
%             speech = piece_explosion{1,sph_cyc-6};
%         end
        figure(90);
        subplot(3,4,sph_cyc);plot(speech);
     elseif spk_cyc == 2
        %speech = segments_horn(sph_cyc,:);
        speech = piece_explosion{1,sph_cyc};
        figure(91);
        subplot(3,4,sph_cyc);plot(speech);
     elseif spk_cyc == 3
        speech = piece_horn{1,sph_cyc};
        figure(92);
        subplot(3,4,sph_cyc);plot(speech);
     end
     cnt = cnt+1;
%      figure(90);
%      subplot(4,3,cnt);plot(speech);
     
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
     %size(c)
     cc=c(:,1:end-1)';
     tag2=tag1+size(cc,2);
     cof(:,tag1:tag2-1)=cc;
     tag1=tag2;
     
     if spk_cyc == 1
        figure(101);
        subplot(3,4,sph_cyc);plot(c);title('MFCC');
     elseif spk_cyc == 2
        figure(102);
        subplot(3,4,sph_cyc);plot(c);title('MFCC');
     elseif spk_cyc == 3
        figure(103);
        subplot(3,4,sph_cyc);plot(c);title('MFCC');
     end
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
fprintf('FINISHED!\n\n',spk_cyc);
save speaker.mat speaker;


% -- ʶ�� ---
% clear all;
% load rec_data.mat;  % �����ʶ������
% load speaker.mat;   % ����ѵ���õ�ģ��
% Spk_num = 3; %˵���˸���
Tes_start = 1;
Tes_end = 6;  %ÿ��˵���˴�ʶ���������Ŀ
% fs=16000; %����Ƶ��
% ncentres=16; %��ϳɷ���Ŀ

% load bkg.mat;
% load gun.mat;
for spk_cyc=1:Spk_num    % ����˵����
  for sph_cyc = Tes_start:Tes_end  % ��������
     fprintf('detecting speaker %i, record %i\n',spk_cyc,sph_cyc); 
     %speech = rdata{spk_cyc}{sph_cyc};
     %speech = background(spk_cyc*sph_cyc,:);
     if spk_cyc == 1
      	%speech = segments_gun(sph_cyc,:);
%         if sph_cyc <= 6
            speech = piece_gun{1,sph_cyc};
%         else
%             speech = piece_explosion{1,sph_cyc-6};
%         end
     elseif spk_cyc == 2
        %speech = segments_horn(sph_cyc,:);
         speech = piece_explosion{1,sph_cyc};
     elseif spk_cyc == 3
         speech = piece_horn{1,sph_cyc};
     end
     
     fprintf('pre-processing...\n');
     %---Ԥ����,������ȡ--
     %pre_sph=filter([1 -0.97],1,speech);
     pre_sph = speech;
     win_type='M'; %������
     cof_num=20; %����ϵ������
     frm_len=fs*0.02; %֡����20ms
     fil_num=20; %�˲��������
     frm_off=fs*0.01; %֡�ƣ�10ms
     c=melcepst(pre_sph,fs,win_type,cof_num,fil_num,frm_len,frm_off); %(֡��)*(cof_num)
     cof=c(:,1:end-1); %N*Dάʸ��
     
     fprintf('detecting...\n');
     %----ʶ��---
     MLval=zeros(size(cof,1),Spk_num);
     for b=1:Spk_num %˵����ѭ��
     pai=speaker{b}.pai;
     for k=1:ncentres 
       mu=speaker{b}.mu(k,:);
       sigma=speaker{b}.sigma(:,:,k);
       pdf=mvnpdf(cof,mu,sigma);
       MLval(:,b)=MLval(:,b)+pdf*pai(k); %������Ȼֵ
     end
    end
    logMLval=log((MLval)+eps);
    sumlog=sum(logMLval,1);
    [maxsl,idx]=max(sumlog); % �о����������Ȼֵ��Ӧ�����idx��Ϊʶ����
    %sumlog
    sum(MLval,1)
    fprintf('result: this is speaker %i, ',idx);
    if idx == spk_cyc
        fprintf('Right!\n');
    else
        fprintf('Wrong!\n');
    end
     
  end
end







