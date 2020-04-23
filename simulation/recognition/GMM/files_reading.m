



maxlen = 0;
num_data = 6;
for i = 1:num_data
    file_name = strcat('a',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('checking %s...\n',file_name);
    [y,fs] = audioread(file_name);
    if maxlen < length(y(:,1))
        maxlen = length(y(:,1));
    end
    
    file_name = strcat('gun',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('checking %s...\n',file_name);
    [y,fs] = audioread(file_name);
    if maxlen < length(y(:,1))
        maxlen = length(y(:,1));
    end
end
fprintf('\n');

bkg = 2*rand(num_data,2*maxlen);
gun = 2*rand(num_data,2*maxlen);
for i = 1:num_data
    file_name = strcat('a',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y,fs] = audioread(file_name);   
    sz = size(y);
    if sz(2) > 1
        bkg(i,5:5+(length(y(:,1))-1)) = ((y(:,1)+y(:,2))/2)'; % 多声道，只要一个
    elseif sz(1) == 1
        bkg(i,5:5+(length(y(:,1))-1)) = (y(:,1))'; % 单声道
    end
    
    file_name = strcat('gun',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y,fs] = audioread(file_name);   
    sz = size(y);
    if sz(2) > 1
        gun(i,5:5+(length(y(:,1))-1)) = ((y(:,1)+y(:,2))/2)'; % 多声道，只要一个
    elseif sz(1) == 1
        gun(i,5:5+(length(y(:,1))-1)) = (y(:,1))'; % 单声道
    end
end
fprintf('\n');

fprintf('size of bkg: ');
size(bkg)
fprintf('\n');
fprintf('size of gun: ');
size(gun)
fprintf('\n');
save bkg.mat bkg
save gun.mat gun
