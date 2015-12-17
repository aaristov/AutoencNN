%% poisson  noise PSF test

function img = poissonfPSF(PSF_array,PSF_index,signal_counts_min,signal_counts_max,bg_counts,filter)

     ppp=PSF_array(:,:,PSF_index);
     pppn=(ppp)/max(ppp(:));
%     pppnp=imnoise(uint8(pppn*signal_counts),'poisson');

    img=double(imnoise(uint8(pppn*randi([signal_counts_min signal_counts_max],1,1)+bg_counts),'poisson'));
    img=ifft2(fftshift(fftshift(fft2(img)).*filter));
    img=img-min(mean(img));
    img=max(img,0);
    img=img/max(img(:));
    % pppnpbg=imnoise(uint8(ones(size(pppn)*60),'poisson'));
end


