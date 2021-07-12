%% -----------------------------------------------------------------------%%

                    %% HISTOGRAMME QUANTIFIE RGB %%
%% -----------------------------------------------------------------------%%
clear all; close all; clc;
[tab,categories,noms]=chargement_bdd();

%% affichage histos 
figure,
for i=1:72
n=5;
%subplot(2,5,i),title([' Image n° ' num2str(i)]),
[theText{n}, rawN{n}, x{n,i}]=nhist(tab{n,i},'color',[.8 .8 .3],'noerror','smooth','fsize',8), hold on; %%coca
n = 3;
[theText{n}, rawN{n}, x{n,i}]=nhist(tab{n,i},'color',[.8 .8 .8],'noerror','smooth','fsize',8), hold on; %%kitkat
n = 7;
[theText{n}, rawN{n}, x{n,i}]=nhist(tab{n,i},'color',[.3 .8 .3],'noerror','smooth','fsize',8), hold on;  %%paprika
n = 6;
[theText{n}, rawN{n}, x{n,i}]=nhist(tab{n,i},'color',[.8 .2 .3],'noerror','smooth','fsize',8), hold on;   %%sourcream
n = 4;
[theText{n}, rawN{n}, x{n,i}]=nhist(tab{n,i},'color',[.5 .4 .3],'noerror','smooth','fsize',8), hold on;   %%citron
n = 2;
[theText{n}, rawN{n}, x{n,i}]=nhist(tab{n,i},'color',[.4 .8 .3],'noerror','smooth','fsize',8), hold on; %%fruitrouges
n = 1;
[theText{n}, rawN{n}, x{n,i}]=nhist(tab{n,i} ,'color',[.7 .2 .9],'noerror','smooth','fsize',8); %%orange
end

%% Moyenne des histogrammes

for n=1:7
for i=1:72
hist{n,i}=mean(x{n,i});
end
end


%% -----------------------------------------------------------------------%%

                     %% RAPPORT LONGUEUR LARGEUR %%
        
%% ------------------------------------------------------------------------
clear all; close all; clc;
k=1;
nbIm=72;
% The orange
rep = 'mask4\the_orange\';
list=dir([rep '*.png']);
%nbIm=numel(list);

for n = 1:nbIm

img=imread(sprintf('%sthe_orange (%d).png',rep,n));
tab{n}=img;

[largeur{n}, lab]=imFeretDiameter(img,0);
[longueur{n}, Labe]=imFeretDiameter(img,90);
end

data_l{k}=longueur;
data_L{k}=largeur;
k=k+1;

%Fruits rouges
rep = 'mask4\the_fruits_rouges\';
list=dir([rep '*.png']);

for n = 1:nbIm

img=imread(sprintf('%sthe_fruits_rouges (%d).png',rep,n));

tab{n}=img;

[largeur{n}, lab]=imFeretDiameter(img,0);
[longueur{n}, Lab]=imFeretDiameter(img,90);
end

data_l{k}=longueur;
data_L{k}=largeur;
k=k+1;

% kitkat

rep = 'mask4\kitkat\';
list=dir([rep '*.png']);
%nbIm=numel(list);

for n = 1:nbIm

img=imread(sprintf('%skitkat (%d).png',rep,n));
tab{n}=img;

[largeur{n}, lab]=imFeretDiameter(img,0);
[longueur{n}, Labe]=imFeretDiameter(img,90);
end

data_l{k}=longueur;
data_L{k}=largeur;

k=k+1;
% The au citron

rep = 'mask4\the_au_citron\';
list=dir([rep '*.png']);
%nbIm=numel(list);

for n = 1:nbIm

img=imread(sprintf('%sthe_au_citron (%d).png',rep,n));
tab{n}=img;

[largeur{n}, lab]=imFeretDiameter(img,0);
[longueur{n}, Labe]=imFeretDiameter(img,90);
end

data_l{k}=longueur;
data_L{k}=largeur;
k=k+1;

% coca cola light

rep = 'mask4\coca_cola_light\';
list=dir([rep '*.png']);
%nbIm=numel(list);

for n = 1:nbIm

img=imread(sprintf('%scoca_cola_light (%d).png',rep,n));
tab{n}=img;

[largeur{n}, lab]=imFeretDiameter(img,0);
[longueur{n}, Labe]=imFeretDiameter(img,90);
end

data_l{k}=longueur;
data_L{k}=largeur;
k=k+1;

% Pringles sour cream

rep = 'mask4\pringles_sour_cream\';
list=dir([rep '*.png']);
%nbIm=numel(list);

for n = 1:nbIm

img=imread(sprintf('%springles_sour_cream (%d).png',rep,n));
tab{n}=img;

[largeur{n}, lab]=imFeretDiameter(img,0);
[longueur{n}, Labe]=imFeretDiameter(img,90);
end

data_l{k}=longueur;
data_L{k}=largeur;
k=k+1;

% Pringles_paprika

rep = 'mask4\pringles_paprika\';
list=dir([rep '*.png']);
%nbIm=numel(list);

for n = 1:nbIm

img=imread(sprintf('%springles_paprika (%d).png',rep,n));
tab{n}=img;

[largeur{n}, lab]=imFeretDiameter(img,0);
[longueur{n}, Labe]=imFeretDiameter(img,90);
end

data_l{k}=longueur;
data_L{k}=largeur;


%% Nuages des points - classes 
rapport=zeros(72,7);
%%
sc=10;
figure
longueur_1=cell2mat(data_l{1,1});
longueur_1=longueur_1';
largeur_1=cell2mat(data_L{1,1});
largeur_1=largeur_1';
rapport(:,1)=largeur_1./longueur_1;
scatter(longueur_1,largeur_1,sc,'r','filled');hold on;title('Rapport largeur longueur');
xlabel 'longueur ';
ylabel 'largeur';

longueur_2=cell2mat(data_l{1,2});
longueur_2=longueur_2';
largeur_2=cell2mat(data_L{1,2});
largeur_2=largeur_2';
rapport(:,2)=largeur_2./longueur_2;
scatter(longueur_2,largeur_2,sc,'b','filled');hold on;

longueur_3=cell2mat(data_l{1,3});
longueur_3=longueur_3';
largeur_3=cell2mat(data_L{1,3});
largeur_3=largeur_3';
rapport(:,3)=largeur_3./longueur_3;
scatter(longueur_3,largeur_3,sc,'y','filled');hold on;

longueur_4=cell2mat(data_l{1,4});
longueur_4=longueur_4';
largeur_4=cell2mat(data_L{1,4});
largeur_4=largeur_4';
rapport(:,4)=largeur_4./longueur_4;
scatter(longueur_4,largeur_4,sc,'g','filled');hold on;

longueur_5=cell2mat(data_l{1,5});
longueur_5=longueur_5';
largeur_5=cell2mat(data_L{1,5});
largeur_5=largeur_5';
rapport(:,5)=largeur_5./longueur_5;
scatter(longueur_5,largeur_5,sc,'m','filled');hold on;

longueur_6=cell2mat(data_l{1,6});
longueur_6=longueur_6';
largeur_6=cell2mat(data_L{1,6});
largeur_6=largeur_6';
rapport(:,6)=largeur_6./longueur_6;
scatter(longueur_6,largeur_6,sc,'c','filled');hold on;

longueur_7=cell2mat(data_l{1,7});
longueur_7=longueur_7';
largeur_7=cell2mat(data_L{1,7});
largeur_7=largeur_7';
rapport(:,7)=largeur_7./longueur_7;
scatter(longueur_7,largeur_7,sc,'k','filled');hold on;
legend('The orange','The fruits rouges','kitkat','The au citron','coca cola light','Pringles sour cream','Pringles_paprika');

%% -----------------------------------------------------------------------%%

                    %% LBP %%
%% -----------------------------------------------------------------------%%
clear all; close all; clc;

the_orangeLBP=cell(72,1);
for i=1:72
    img = imread(sprintf('Base de données projet/the_orange/the_orange (%d).png',i));
    t=imhist(img);
    the_orangeLBP{i}=LBP(img);
    
end

the_frLBP=cell(72,1);
for i=1:72
    img = imread(sprintf('Base de données projet/the_fruits_rouges/the_fruits_rouges (%d).png',i));
    t=imhist(img);
    the_frLBP{i}=LBP(img);
     
end

kitkatLBP=cell(72,1);
for i=1:72
    img = imread(sprintf('Base de données projet/kitkat/kitkat (%d).png',i));
    t=imhist(img);
    kitkatLBP{i}=LBP(img);
   
end


The_fpassionLBP=cell(72,1);
for i=1:72
    img = imread(sprintf('Base de données projet/the_au_citron/the_au_citron (%d).png',i));
    t=imhist(img);
    The_fpassionLBP{i}=LBP(img);
end

CocaColaLBP=cell(72,1);
for i=1:72
    img = imread(sprintf('Base de données projet/coca_cola_light/coca_cola_light (%d).png',i));
    t=imhist(img);
    CocaColaLBP{i}=LBP(img);
end

Pringles_sourcreamLBP=cell(72,1);
for i=1:72
    img = imread(sprintf('Base de données projet/pringles_sour_cream/pringles_sour_cream (%d).png',i));
    t=imhist(img);
    Pringles_sourcreamLBP{i}=LBP(img);
end

Pringles_paprikaLBP=cell(72,1);
for i=1:72
    img = imread(sprintf('Base de données projet/pringles_paprika/pringles_paprika (%d).png',i));
    t=imhist(img);
    Pringles_paprikaLBP{i}=LBP(img);
end


totLBP=cell(504,1);
totLBP=[the_orangeLBP;the_frLBP; kitkatLBP;The_fpassionLBP;CocaColaLBP;Pringles_sourcreamLBP;Pringles_paprikaLBP];

ref=cell(7,1);

mes_simthe_oranges=cell(504,2);
ref{1}=the_orangeLBP{1};
for i=2:72
    ref{1}=ref{1}+the_orangeLBP{i};
end

ref{1}=ref{1}./72;
plot(ref{1});hold on;
for j=1:504
    mes_simthe_oranges{j,1}= similarite(ref{1}, totLBP{j},'smith');
    mes_simthe_oranges{j,2} = j; % numero image correspondant
end
sim_the_orangesTrie = sortrows(mes_simthe_oranges,1);
sommethe_oranges =0;
for i=1:72
    if (sim_the_orangesTrie{i,2} <= 72)
        sommethe_oranges=sommethe_oranges +1;
    end
end
sommethe_oranges
the_oranges=sommethe_oranges/72


mes_simthe_fr=cell(504,2);
ref{2}=the_frLBP{1};
for i=2:72
    ref{2}=ref{2}+the_frLBP{i};
end
ref{2}=ref{2}./72;
plot(ref{2});hold on;
for j=1:504
    mes_simthe_fr{j,1}= similarite(ref{2}, totLBP{j},'smith');
    mes_simthe_fr{j,2} = j; % numÃ©ro image correspondant
end
sim_the_frTrie = sortrows(mes_simthe_fr,1);
sommethe_fr =0;
for i=1:72
    if (72 <sim_the_frTrie{i,2} && sim_the_frTrie{i,2} <= 144)
        sommethe_fr=sommethe_fr +1;
    end
end
sommethe_fr
the_fr=sommethe_fr/72

mes_sim_kitkat=cell(504,2);
ref{3}=kitkatLBP{1};
for i=2:72
    ref{3}=ref{3}+kitkatLBP{i};
end
ref{3}=ref{3}./72;
plot(ref{3});hold on;
for j=1:504
    mes_sim_kitkat{j,1}= similarite(ref{3}, totLBP{j},'smith');
    mes_sim_kitkat{j,2} = j; % numÃ©ro image correspondant
end
sim_kitkatTrie = sortrows(mes_sim_kitkat,1);
sommekitkat=0;
for i=1:72
    if (144 < sim_kitkatTrie{i,2} && sim_kitkatTrie{i,2} <= 216)
        sommekitkat=sommekitkat +1;
    end
end
sommekitkat
kitkat=sommekitkat/72


mes_simThe_fpassion=cell(504,2);
ref{4}=The_fpassionLBP{1};
for i=2:72
    ref{4}=ref{4}+The_fpassionLBP{i};
end
ref{4}=ref{4}./72;
plot(ref{4});hold on;
for j=1:504
    mes_simThe_fpassion{j,1}= similarite(ref{4}, totLBP{j},'smith');
    mes_simThe_fpassion{j,2} = j; % numÃ©ro image correspondant
end
sim_The_fpassionTrie = sortrows(mes_simThe_fpassion,1);
sommethe_passion =0;
for i=1:72
    if (216 <sim_The_fpassionTrie{i,2} && sim_The_fpassionTrie{i,2} <= 288)
        sommethe_passion=sommethe_passion +1;
    end
end
sommethe_passion
the_passion=sommethe_passion/72


mes_cocacola=cell(504,2);
ref{5}=CocaColaLBP{1};
for i=2:72
    ref{5}=ref{5}+CocaColaLBP{i};
end
ref{5}=ref{5}./72;
plot(ref{5});hold on;
for j=1:504
    mes_cocacola{j,1}= similarite(ref{5}, totLBP{j},'smith');
    mes_cocacola{j,2} = j; % numÃ©ro image correspondant
end
simCocacolaTrie = sortrows(mes_cocacola,1);
sommeCocacola =0;
for i=1:72
    if (288< simCocacolaTrie{i,2} && simCocacolaTrie{i,2} <= 360)
        sommeCocacola=sommeCocacola +1;
    end
end
sommeCocacola
CocaCola=sommeCocacola/72

mes_Pringles_sourcream=cell(504,2);
ref{6}=Pringles_sourcreamLBP{1};
for i=2:72
    ref{6}=ref{6}+Pringles_sourcreamLBP{i};
end
ref{6}=ref{6}./72;
plot(ref{6});hold on;
for j=1:504
    mes_Pringles_sourcream{j,1}= similarite(ref{6}, totLBP{j},'smith');
    mes_Pringles_sourcream{j,2} = j; % numÃ©ro image correspondant
end
sim_PringlesSC_Trie = sortrows(mes_Pringles_sourcream,1);
sommePringlesSC =0;
for i=1:72
    if (360 < sim_PringlesSC_Trie{i,2} && sim_PringlesSC_Trie{i,2} <= 432)
        sommePringlesSC=sommePringlesSC +1;
    end
end
sommePringlesSC
PringlesSC=sommePringlesSC./72;

mes_simPringlesPap=cell(504,2);
ref{7}=Pringles_paprikaLBP{1};
for i=2:72
    ref{7}=ref{7}+Pringles_paprikaLBP{i};
end
ref{7}=ref{7}./72;
plot(ref{7});hold on;
for j=1:504
    mes_simPringlesPap{j,1}= similarite(ref{7}, totLBP{j},'smith');
    mes_simPringlesPap{j,2} = j; % numÃ©ro image correspondant
end
simPringlesPapTrie = sortrows(mes_simPringlesPap,1);
sommePringlesPap =0;
for i=1:72
    if (432 < simPringlesPapTrie{i,2} && simPringlesPapTrie{i,2} <= 504)
        sommePringlesPap=sommePringlesPap +1;
    end
end
sommePringlesPap
PringlesPap=sommePringlesPap./72;

%%
c = linspace(1,10,length(i));
for i=1:72
   figure(2); title('LBP'); scatter(sim_the_orangesTrie{i,2},sim_the_orangesTrie{i,1},'red' ,'filled');hold on;
       
end
 for i=1:72
     scatter(sim_the_frTrie{i,2},sim_the_frTrie{i,1},'blue','filled');hold on;
       
 end 
for i=1:72
     scatter(sim_kitkatTrie{i,2},sim_kitkatTrie{i,1},'green','filled');hold on;
       
end 
for i=1:72
     scatter(sim_The_fpassionTrie{i,2},sim_The_fpassionTrie{i,1},'yellow','filled');hold on;
       
end 
for i=1:72
     scatter(simCocacolaTrie{i,2},simCocacolaTrie{i,1},'black','filled');hold on;
       
end

for i=1:72
     scatter(sim_PringlesSC_Trie{i,2},sim_PringlesSC_Trie{i,1},'magenta','filled');hold on;
       
end
for i=1:72
     scatter(simPringlesPapTrie{i,2},simPringlesPapTrie{i,1},'cyan','filled');hold on;
       
end
