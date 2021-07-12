function [sig]=signature(img,numsig)

 switch numsig 
     case 'mean2_1'
         sig=mean2(img(:,:,1));
     case 'std2'
         sig=std2(img) ; 
     case 'mean2_3'
         sig=mean2(img(:,:,3)) ; 
     case 'mean2_L'
         sig=mean2(img);
     case 'entropy_1'
         sig=entropy(img(:,:,1));
     case 'entropy_2'
         sig=entropy(img(:,:,2));
     case 'entropy_3'
         sig=entropy(img(:,:,3));    
     case 'std2_L'
         sig=std2(img);
     case 'histo_1'
         % histogramme marginal plan 1
         sig = imhist(img(:,:,1));
     case 'histo_2'
         % histogramme marginal plan 2
         sig = imhist(img(:,:,2));    
     case 'histo_3'
         % histogramme marginal plan 3
         sig = imhist(img(:,:,3));
     case 'histo_L'
         % histogramme de luminance
         sig = imhist(0.2126*img(:,:,1)+0.7152*img(:,:,2)+0.0722*img(:,:,3));
     case 'histo_3D'
         % histogramme vectoriel
         H=zeros(256,256,256); 
         s=size(img);
         for i=1:s(1)
             for j=1:s(2)
                 r=uint8(img(i,j,1))+1;
                 g=uint8(img(i,j,2))+1;
                 b=uint8(img(i,j,3))+1;
                 H(r,g,b)=H(r,g,b)+1;
             end
         end
         sig=H; 
     case 'histo_64'
         %histogramme Swain et Ballard sur 64 couleurs
        quant=4;
        nb_bin=quant^3 ; 
        Iq = floor(img.*256/nb_bin) ; 
        Iq = Iq( :, :,1) + quant*Iq( :, :,2) + quant*quant*Iq( :, :,3) ; 
        sig=hist(Iq(:),nb_bin);
 
     case 'LBP'
         sig=LBP(img);
     case 'HOG'
         seuil=0;
        sig = histogrammeGradientsOrientes(img,seuil);
     
        
 
end
 
     
 
 
