function out=icorrectoffsetspan(x,ref,ids,offset)
    %Correct scaling (and offset if offset=true) of 2d x with regards to ref, only
    %points with ids=true are considered. Uses gpu.
    if (nargin<4);offset=false;end
    
    if parallel.gpu.GPUDevice.isAvailable
        xo=gpuArray(single(x(ids)));
        ref=gpuArray(single(ref(ids)));
    else
        xo=x(ids);
        ref=ref(ids);
    end
    
    if ~offset
        %span only
        param= fminsearch(@(p) errabs(p),1,optimset('Display','off','TolX',1e-35,'TolFun',1e-35));
        out=x*param;
        
    else
        % allow additional constant offset
        start=min(x(ids));
        param= fminsearch(@(p) errabs_offset([p(1),p(2),p(3)]),[start,1,start],optimset('Display','off','TolX',1e-35,'TolFun',1e-35));
        out=(x-param(1))*param(2)+param(3);
    end
    
    function out=errabs(p)
        out=abs(gather(mean(abs(single(((xo*p)-ref)./ref)))));
    end
    
    function out=errabs_offset(p)
        v=(xo-p(1))*p(2)+p(3);
        out=abs(gather(mean(abs(single((v-ref)./ref)))))+gather(1e3*sum(abs(min(v(:),0))));
    end
    
end