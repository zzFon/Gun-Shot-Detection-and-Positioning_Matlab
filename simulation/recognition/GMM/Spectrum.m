

for i = 1:num_gun
    figure(1);
    subplot(2,3,i);plot(segments_gun(i,:),'r');
end

for i = 1:num_explosion
    figure(2);
    subplot(2,3,i);plot(segments_explosion(i,:),'r');
end

for i = 1:num_horn
    figure(3);
    subplot(2,3,i);plot(segments_horn(i,:),'r');
end