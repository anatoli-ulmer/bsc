N=32;
range1=floor(linspace(-N/4,N/4-1/2,N))*2;
range2=linspace(-N/2,N/2-1,N);
frange1=fftshift(fft(fftshift(range1)));
frange2=fftshift(fft(fftshift(range2)));
frange3=frange2;
frange3([1:N/4 3*N/4+1:end])=0;
range3=fftshift(ifft(fftshift(frange3)));
subplot(3,2,1)
plot(1:N,range1);
subplot(3,2,2)
plot(1:N,real(frange1),'b',1:N,imag(frange1),'r',1:N,abs(frange1),'g');
subplot(3,2,3)
plot(1:N,range2);
subplot(3,2,4)
plot(1:N,real(frange2),'b',1:N,imag(frange2),'r',1:N,abs(frange2),'g');
subplot(3,2,5)
plot(1:N,range3);
subplot(3,2,6)
plot(1:N,real(frange3),'b',1:N,imag(frange3),'r',1:N,abs(frange3),'g');