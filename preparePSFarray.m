%% Preapare PSF array from zstack

%
clear PSF;
PSF.zstepnm=10;
PSF.tframes=3;
tic;
fprintf('Setting z-step %d nm\n',PSF.zstepnm);
fprintf('Setting timeframe %d \n',PSF.tframes);
% [image,status]=load_stack_data_v7('D:\REsultats microscopy HR\2015-09-10-beads\beads iXon sp 3 sep 10 frames 200 step 8 mW 100 ms EM200_1\beads iXon sp 3 sep 10 frames 200 step 8 mW 100 ms EM200_1_MMStack_Pos0.ome.tif');
% [image,status]=load_stack_data_v7('C:\Users\Andrey\BitTorrent Sync\resultats Andrey\14 oct beads\beads SP 8 oct dm 100 ms 32x_2\Pos0.tif');
[image,status]=load_stack_data_v7('C:\Users\Andrey\BitTorrent Sync\resultats Andrey\06 nov sp 3 nov beads\001 100 ms 32x 10 step 3 pass_1\001 100 ms 32x 10 step 3 pass_1_MMStack_Pos0.ome.tif');
if status
    
    PSF.stacksize=size(image.data);
    fprintf('Read %d-frame stack \n',PSF.stacksize);
    %%
    PSF.zframes=PSF.stacksize(3)/PSF.tframes;
    fprintf('Set PSFzframes = %d\n',PSF.zframes);

    PSF.zrange = PSF.zstepnm*(PSF.zframes-1); % .2 z step in the stack
    PSF.av=zeros(PSF.stacksize(1),PSF.stacksize(2));
    for i=1:PSF.zframes
        tmp=image.data(:,:,i);
        if PSF.tframes>1
            for j=2:PSF.tframes
                tmp=tmp+image.data(:,:,i+PSF.zframes*(j-1));
            end
            tmp=tmp/PSF.tframes;
            PSF.photons(i)=sum(tmp(:));
        end
        PSF.av=PSF.av+tmp;
%         PSF.array(:,:,i)= gpuArray(  tmp-min(mean(tmp)));
        PSF.array(:,:,i)= (  tmp-min(mean(tmp)));
        PSF.maxvector(i)=max(tmp(:));
        PSF.meanvector(i)=mean(tmp(:));
    end
    PSF.av=PSF.av/PSF.zframes;
    %%
    PSF.cropsizex=PSF.stacksize(1);
    PSF.cropsizey=PSF.stacksize(2);

    PSF.av=gpuArray(PSF.av);
    PSF.xxx=reshape(PSF.array,PSF.cropsizey,PSF.cropsizex*PSF.zframes);
    %%
    figure;
    imnum=16;
    for i=1:imnum
        subplot(sqrt(imnum),sqrt(imnum),i);
        imagesc(PSF.array(:,:,floor(PSF.zframes/imnum*i)));
      
        title(sprintf('z stack %d',floor(PSF.zframes/imnum*i)));

    end
    %%
    clear histo;
    figure;
    subplot(1,2,1);
    imagesc(PSF.av);
    title('Mean PSF');
    %%
    subplot(1,2,2);
    [PSF.photonshisto, PSF.photonsfwhm] = getlinehisto(PSF.photons, 1, .01);

    bar(PSF.photonshisto(:,1),PSF.photonshisto(:,2))
    title('PSF number of photons x100');
    clear tmp j imnum i 
else
    fprintf('Error reading data (%d)\n',status);
end
%%
%zstackxcorr;
t=toc;
fprintf('%1.1f sec\n',t);

% genPSFAC;

