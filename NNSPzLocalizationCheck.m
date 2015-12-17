clear SPres SPdif SPprec SPdifperz;
SPres=deepnet(SPInput);
ii=0;
zind=1;
SPdif=zeros(size(SPres,2),1);
SPprec=zeros(size(SPres,2),1);
SPdifperz=zeros(numPSF,1);
for i=1:size(SPres,2)
    [~,b]=max(SPTargets(:,i));
    [am,a]=max(SPres(:,i));
    SPdif(i,1)=a-b;
    SPprec(i,1)=am;
    ii=ii+1;
    if ii== numPoisson
       SPdifperz(zind)=2.4*std(SPdif(i-numPoisson+1:i,1));
       zind=zind+1;
       ii=0;
    end
   
end
%%
figure
h=histogram((SPres-SPTargets)*stepPSF*10*numPSF);
xlabel('z error, nm')

%%
figure
plot(SPdif,SPprec,'.');
xlabel('z error, index');ylabel('prediction certanty (0-1)');

figure
plot((-numPSF/2+1:numPSF/2)*PSF.zstepnm*stepPSF, SPdifperz*PSF.zstepnm); xlabel('z , nm'); ylabel(sprintf('FWHM of localization error, nm'));

figure
imagesc(SPres);

