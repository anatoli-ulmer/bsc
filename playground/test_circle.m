o=scatterObjects.sphere();
N=128
dx=16
o.radius=50;
f=o.prepareSliceMethod(N,dx,false);
figure(5);
imagesc(f(0));
a=arrayfun(@(x)sum(sum(f(x))),-N/2*dx:dx/4:N/2*dx);
figure(6)
plot(-N/2*dx:dx/4:N/2*dx,a)