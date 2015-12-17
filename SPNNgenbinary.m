% Generates input coumn data and binary output for sp z-classification
bg=140;
PSFamplmin=100;
PSFamplmax=100;
% numPSF=PSF.zframes;
numPSF=200;
numPoisson=100;
stepPSF=1;
startPSF=200;
SPTargets=zeros(numPSF,numPSF*numPoisson);
SPInput=zeros(PSF.cropsizex*PSF.cropsizey,numPSF*numPoisson);
SPSoftTargets=zeros(1,numPSF*numPoisson);
SPTrainImages=cell(1,numPSF*numPoisson);
%generate gaussian filter

x = -16:1:15;
norm = normpdf(x,0,5);
filter=norm' * norm;
filter(17,17)=0;
%

% PSf shift
[x,y]=meshgrid(1:32,1:32);
% img2=interp2(x,y,img,x+0.5,y-1.3);

ii=0;
ij=0;
for j=startPSF:stepPSF:startPSF+numPSF*stepPSF-1
    ij=ij+1;
    for i = 1:numPoisson
        ii=ii+1;
%         PSFamp=randi([100 100],1,1);
        pppnp=poissonPSF(PSF.array,j,PSFamplmin,PSFamplmax,bg);
%         pppnp=pppnp-min(mean(pppnp));
%         pppnpf=filterpsf(pppnp,filter);
%         pppnpf=pppnpf/max(pppnpf(:));
        SPInput(:,ii)=pppnp(:);
        SPTargets(ij,ii)= 1;
        SPSoftTargets(1,ii)=ij/numPSF;
        SPTrainImages{1,ii}=pppnp;
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