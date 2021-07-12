function [tab,categories,noms]=chargement_bdd()

    %Charge les images de la base 
    %tab{i,j} : jè image de la iè classe
    %categories(i) : nom de la iè classe
    %noms(i,j) : nom de la jè image de la iè classe

    %Localisation de la base de données
    
    if not(exist('DB_Dir.mat','file'))
        DB_Dir='';
    else
        load('DB_Dir.mat');
    end

    if not(exist(DB_Dir,'file'))
        warning('Image Database Directory Not Found ! Prompting User To Find A New One');
        DB_Dir=uigetdir('','Select Image Database Directory');
        save('DB_Dir.mat','DB_Dir')
    end

    %Chargement en mémoire
    
    categories=dir(DB_Dir);
    categories=categories(3:end);  %pour enlever les repertoires non-voulus '.', '..'
    for i=1:size(categories,1)
        nom_classe=categories(i).name;
        rep=dir(sprintf('%s\\%s',DB_Dir,nom_classe));
        rep=rep(3:end);
        taille=size(rep,1);
        for j=1:taille
            nom_img=sprintf('%s (%d).png',nom_classe,j);
            noms{i,j}=nom_img;
            img=imread(sprintf('%s\\%s\\%s (%d).png',DB_Dir,nom_classe,nom_classe,j)); %MERCI POUR LE FORMATAGE
            tab{i,j}=img;
            
        end
    end
end
