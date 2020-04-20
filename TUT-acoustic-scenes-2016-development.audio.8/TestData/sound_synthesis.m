

% 先运行 files_reading.m

bkg = background(1,1:end/5); % 源背景声太长了

figure(1);
subplot(3,1,1);plot(bkg(1,:));
fprintf('length of bkg = %f\n',length(bkg(1,:)));
insert = round((length(bkg(1,:)-length(gun0)))*rand(1));
fprintf('length of gun0 = %f\n',length(gun0));
fprintf('insert = %f\n',insert);
mixed = bkg(1,:);
for i = 1:1:length(bkg(1,:))
    if 0 < i-insert && i-insert <= length(gun0)
        mixed(i) = mixed(i)+gun0(i-insert);
    end
end
% mixed = 
subplot(3,1,2);plot(gun0);
subplot(3,1,3);plot(mixed);
player = audioplayer(mixed,fs);
player.play;