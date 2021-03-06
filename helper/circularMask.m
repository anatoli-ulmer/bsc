function [ innermask,softmask,outermask ] = circularMask( N,maskScale,sigma )
    %create masks for simulation
    %softmask is gauss filtered mask, outermask is extended to affected area, innermask is unaffected area
    if maskScale==0
        innermask=true(N);
        softmask=ones(N);
        outermask=true(N);
    else
        [xx,yy]=meshgrid(-N/2:1:N/2-1);
        innermask=xx.^2+yy.^2>=(maskScale*max(N))^2;
        tmpmask=xx.^2+yy.^2>=(maskScale*max(N)+2*sigma)^2;
        if sigma>0
            softmask=imgaussfilt(double(tmpmask),sigma);
        else
            softmask=tmpmask;
        end
        softmask=softmask.*innermask;
        softmask(softmask>0.99)=1;
        outermask=softmask==1;
    end
end

