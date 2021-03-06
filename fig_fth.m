% Draws images for FTH illustration showing effect of the reference

addpath('helper');
input=imread('reconstruction/input/input_klein-tu.png');
outpath='Tex/images/src/';
saveimage=@(filename) save_image(fullfile(outpath,filename));

input=padarray(double(squeeze(input(:,:,1)))./255,[256,256]);
refoff=700;
refsize=10;
[xx,yy]=meshgrid(1:size(input,1),1:size(input,2));
ref=(xx-refoff).^2+(yy-refoff).^2<refsize^2;
inputHolo=input+double(ref);
scatterHolo=(abs(ft2(inputHolo))).^2;
scatter=(abs(ft2(input))).^2;
reconHolo=ift2(scatterHolo);
recon=ift2(scatter);
cross=reconHolo(1:280,1:280);
figure(1);
imagesc(inputHolo);
colormap(flipud(colormap(gray)));
saveimage('fth_inputHolo.png');
figure(2);
imagesc(scatterHolo);
colormap(flipud(colormap(gray)));
caxis([0,1e6]);
saveimage('fth_scatterHolo.png');
figure(3);
imagesc(reconHolo);
colormap(flipud(colormap(gray)));
caxis([min(cross(:)),max(cross(:))])
saveimage('fth_reconHolo.png');

figure(4);
imagesc(input);
colormap(flipud(colormap(gray)));
saveimage('fth_input.png');
figure(5);
imagesc(scatter);
colormap(flipud(colormap(gray)));
caxis([0,1e6]);
saveimage('fth_scatter.png');
figure(6);
imagesc(recon);
colormap(flipud(colormap(gray)));
saveimage('fth_recon.png');
