function exitWave=thibault(wavelength,objects,N,dx,deltaz,gpu,margin,debug)
    % calculate exitWave after scene following Thibault 2006
    % "Reconstruction of a yeast cell from X-ray diffraction data"
    % wavelength (in nm),objects (cell arra),N,dx,distanceDetektor,gpu (bool use gpu),debug (bool show progress)
  
    if nargin<6||isempty(gpu);gpu=parallel.gpu.GPUDevice.isAvailable();end
    if nargin<7||isempty(margin);margin=0.95;end
    
    k=2*pi/wavelength;
    Lz=dx*N/2; %max z values are half of N because Nx,Ny must be padded
      
    if gpu
        %input wave
        waveF=ft2(gpuArray.ones(N,N))/(dx^2);
        zero=@()gpuArray.zeros(N,N);
    else
        waveF=ft2(ones(N,N))/(dx^2);
        zero=@()zeros(N,N);
    end
    
    %prepare Objects and retrieve slice functions
    for nobj=length(objects):-1:1
        slicefun{nobj}=objects{nobj}.prepareSliceMethod(N,dx,gpu);
    end
    
    %Propagator in fourier space for single step
    [propagator,factor]=getPropagatorAndFactor;
    
    for z=-Lz/2:deltaz:Lz/2
        
        %get slices deltan
        dnSlice=zero();
        for nobj=1:length(objects)
            bd=-objects{nobj}.delta+1i*objects{nobj}.beta;
            dnSlice=dnSlice+slicefun{nobj}(z)*bd;
        end
        
        %multislice, vgl thibault
        if any(dnSlice(:))
            delta=dnSlice.*(ift2(waveF)*(dx^2));
            waveF=(waveF+factor.*(ft2(delta)/dx^2)).*propagator;
        else
            waveF=(waveF.*propagator);
        end
        
        if nargin>7&&isa(debug,'function_handle')
            debug(ift2(waveF)*dx^2,z);
        end
    end
    
    exitWave=ift2(waveF)*dx^2;
    
    %check intensity, should be close to 1 without absorption
    %fprintf('Check= %f (should be ~1 w/o absorption)\n',  sum(abs(exitWave(:)))/(N*N));
    
    if gather(any(isnan(exitWave)))
        warning 'NaN occured'
    end
    
    %unlock objects
    for nobj=length(objects):-1:1
        objects{nobj}.unlock();
    end
    
    function [propagator,factor]=getPropagatorAndFactor
        %propagator and factor as in thibault
        %seperate function to create namespace for tmp variables
        k=2*pi/wavelength;
        
        if gpu
            range=gpuArray.linspace(-N/2,N/2-1,N)*(2*pi/(dx*N));
        else
            range=linspace(-N/2,N/2-1,N)*(2*pi/(dx*N));
        end
        [qx,qy]=meshgrid(range);
        
        evanescence_mask=k^2*margin>(qx.^2+qy.^2);         %0.8 is safety margin
        kdiff=sqrt(complex(k^2-(qx.^2+qy.^2)))-k;
        propagator=exp(1i*deltaz*kdiff);
        factor=1i*k*deltaz./sqrt(complex(1-(qx.^2+qy.^2)/k^2)).*evanescence_mask;
    end
    
    function out=window(N)
        %super gaussian window for N
        if gpu
            [nx, ny] = meshgrid(gpuArray.linspace(-N/2,N/2-1,N));
        else
            [nx, ny] = meshgrid(linspace(-N/2,N/2-1,N));
        end
        nsq = nx.^2 + ny.^2;
        wt = 0.25*N;
        out = exp(-nsq.^8/wt^16);
    end
    
end

