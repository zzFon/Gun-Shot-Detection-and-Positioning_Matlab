% -- ʶ�� ---
clear all;
load rec_data.mat;  % �����ʶ������
load speaker.mat;   % ����ѵ���õ�ģ��
Spk_num=2; %˵���˸���
Tes_num=3;  %ÿ��˵���˴�ʶ���������Ŀ
fs=16000; %����Ƶ��
ncentres=16; %��ϳɷ���Ŀ

load bkg.mat;
load gun.mat;
for spk_cyc=1:Spk_num    % ����˵����
  for sph_cyc=1:Tes_num  % ��������
     fprintf('detecting speaker %i, record %i, ',spk_cyc,sph_cyc); 
     %speech = rdata{spk_cyc}{sph_cyc};
     %speech = background(spk_cyc*sph_cyc,:);
     if spk_cyc == 1
      	speech = bkg(sph_cyc,:);
     elseif spk_cyc == 2
        speech = gun(sph_cyc,:);
     end
     
     file_name = 's1.wav';
     fprintf('checking %s...\n',file_name);
     [speech,fffff] = audioread(file_name);
     
     fprintf('pre-processing...\n');
     %---Ԥ����,������ȡ--
     pre_sph=filter([1 -0.97],1,speech);
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
    fprintf('result: this is speaker %i, ',idx);
    if idx == spk_cyc
        fprintf('Right!\n');
    else
        fprintf('Wrong!\n');
    end
     
  end
end