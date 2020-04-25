

maxlen = 0;
num_gun = 6;
num_explosion = 6;
for i = 1:num_gun
    file_name = strcat('dataset_gun',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('checking %s...\n',file_name);
    [y1,fs] = audioread(file_name);
    if maxlen < length(y1(:,1))
        maxlen = length(y1(:,1));
    end
end
for i = 1:num_explosion
    file_name = strcat('dataset_explosion',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('checking %s...\n',file_name);
    [y2,fs] = audioread(file_name);
    if maxlen < length(y2(:,1))
        maxlen = length(y2(:,1));
    end
end
fprintf('\n');

close all;
data_gun = 0.02*rand(num_gun,maxlen+400);
for i = 1:num_gun   
    file_name = strcat('dataset_gun',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y1,fs] = audioread(file_name);  
    sz = size(y1);
    data_gun(i,300:300+(length(y1(:,1))-1)) = data_gun(i,300:300+(length(y1(:,1))-1))+(y1(:,1))'; % ������
    %figure;plot(data_gun(i,:));
end

data_explosion = 0.02*rand(num_explosion,maxlen+400);
for i = 1:num_explosion
    file_name = strcat('dataset_explosion',num2str(i));
    file_name = strcat(file_name,'.wav');
    fprintf('reading %s...\n',file_name);
    [y2,fs] = audioread(file_name);  
    sz = size(y2);
    data_explosion(i,300:300+(length(y2(:,1))-1)) = data_explosion(i,300:300+(length(y2(:,1))-1))+(y2(:,1))'; % ������
end
fprintf('\n');

fprintf('size of data_gun: ');
size(data_gun)
fprintf('\n');
fprintf('size of data_explosion: ');
size(data_explosion)
fprintf('\n');



