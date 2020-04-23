

[gun0,fs] = wavread('gun0.wav'); % 单声道
background = [];
for i = 1:10
    file_name = strcat('a',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y,fs] = audioread(file_name);   
    background = [background;((y(:,1)+y(:,2))/2)']; % 多声道，只要一个
end
fprintf('size of gun0: ');
gun0 = gun0';size(gun0)
fprintf('\n');
fprintf('size of background: ');
size(background)
fprintf('\n');
