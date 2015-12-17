% Generates input coumn data and binary output for sp z-classification
bg=20;
PSFampl=80;
numPSF=PSF.zframes;
numPoisson=100;
SPTargets8=zeros(1,numPSF*numPoisson);
ii=0;
for j=1:numPSF
    for i = 1:numPoisson
        ii=ii+1;
        pppnp=poissonPSF(PSF.array,j,PSFampl,bg);
        pppnp=pppnp-min(mean(pppnp));
        SPInput8(:,ii)=pppnp(:);
        SPTargets8(1,ii)= zind2coord(j,PSF.zrange,PSF.zframes);
%         tmp=SPsearch(pppnp,debug,framethreshold,photonlimit,minzcorr,PSF,params);

%         if tmp(1,1)>0
%             foundparticle(i+ii,:)=tmp;
%         else
%             ii=-1;
%         end
    end
%     deviations(j,:)=[std(foundparticle(:,3))*1000,std(foundparticle(:,4))*1000,std(foundparticle(:,5))];
%     photons(j)=mean(foundparticle(:,2));
%     %%
%     fprintf('\n');
%      
%     hold on
%     scatter3(foundparticle(:,3),foundparticle(:,4),foundparticle(:,5));
end
%%
% 
% meanphotons=mean(photons(:));
% FWHMs=2.355*deviations;
% figure
% plot(zind2coord([7:26],PSF.zrange,PSF.zframes),FWHMs(7:end,1));
% xlabel('z, nm');
% ylabel('deviation FWHM, nm');
% hold on
% 
% plot(zind2coord([7:26],PSF.zrange,PSF.zframes),FWHMs(7:end,2));
% plot(zind2coord([7:26],PSF.zrange,PSF.zframes),FWHMs(7:end,3));
% legend({'x','y','z'});
% title(sprintf('Mean photon number = %1.0f, PSFampl = %d, bg = %d',meanphotons,PSFampl,bg));
% subplot
% hold off