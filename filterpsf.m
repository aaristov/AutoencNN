function pppnpf = filterpsf(pppnp,filter)
pppnpf=ifft2(fftshift(fftshift(fft2(pppnp)).*filter));
end
