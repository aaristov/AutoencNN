%% prepare image series



clear images;
% [frames,status]=load_stack_data_v7('100nmsteps100ms_1_MMStack_Pos0.ome.tif');
%[images.frames,images.status]=load_stack_data_v7('C:\Users\Andrey\BitTorrent Sync\resultats Andrey\21jul\100frames200step60ms128x_2\100frames200step60ms128x_2_MMStack_Pos0.ome.tif');
[images.ram,images.status]=load_stack_data_v7('D:\REsultats microscopy HR\2015-09-10-beads\beads iXon sp 3 sep 10 frames 200 step 8 mW 100 ms EM200_1\beads iXon sp 3 sep 10 frames 200 step 8 mW 100 ms EM200_1_MMStack_Pos0.ome.tif');
%%
if images.status
    images.framesize=size(images.ram.data);
    images.length=images.framesize(3);
    fprintf('%d frames read\n',images.length);
    %%
%     fprintf('Start gpuArray\n');
%     fprintf('Start bg substaction\n');
    clear imageseries imageseriesram;
    %imageseries=gpuArray(frames.data);
%     for i=1:images.length
%         tmp=images.frames.data(:,:,i);
% 
% 
%         images.ram(:,:,i)= (tmp-mean(tmp(:)));
% 
%     end
    %images.array=gpuArray(images.ram);
    % out
    % clear frames
    % imageserieslength=imageserieslength;
    fprintf('%d images processed\n',images.length);
else
    fprintf('error loading images (status=%d)\n',images.status);
end

%%
images.zsteps = 1;


