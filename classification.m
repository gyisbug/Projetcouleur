%% I Chargement de la base de données 
clear all; close all; clc;

%% Données histo 
load histo.mat
%%
% Z=cell(7,1);
% Z{1}=X{1,1};
% for i=2:72
%     Z{1}=Z{1}+X{1,i};
% end
% Z{1}=Z{1}./72;
% 
% Z{2}=X{2,1};
% for i=2:72
%     Z{2}=Z{2}+X{2,i};
% end
% Z{2}=Z{2}./72;
% 
% Z{3}=X{3,1};
% for i=2:72
%     Z{3}=Z{3}+X{3,i};
% end
% Z{3}=Z{3}./72;
% 
% Z{4}=X{4,1};
% for i=2:72
%     Z{4}=Z{4}+X{4,i};
% end
% Z{4}=Z{4}./72;
% 
% Z{5}=X{5,1};
% for i=2:72
%     Z{5}=Z{5}+X{5,i};
% end
% Z{5}=Z{5}./72;
% 
% Z{6}=X{6,1};
% for i=2:72
%     Z{6}=Z{6}+X{6,i};
% end
% Z{6}=Z{6}./72;
% 
% Z{7}=X{7,1};
% for i=2:72
%     Z{7}=Z{7}+X{7,i};
% end
% Z{7}=Z{7}./72;
%% Données rapport
load rapport.mat

tab_data_final=cell(3,504);
tab_data_final{1,1}=rapport(1,1);
for i=2:72
    tab_data_final{1,i}=rapport(i,1);
end
j=1;
for i=73:144 
    tab_data_final{1,i}=rapport(j,2);
    j=j+1;
end

j=1;
for i=145:216
    tab_data_final{1,i}=rapport(j,3);
    j=j+1;
end

j=1;
for i=217:288
    tab_data_final{1,i}=rapport(j,4);
    j=j+1;
end

j=1;
for i=289:360
    tab_data_final{1,i}=rapport(j,5);
    j=j+1;
end

j=1;
for i=361:432
    tab_data_final{1,i}=rapport(j,6);
    j=j+1;
end

j=1;
for i=433:504
    tab_data_final{1,i}=rapport(j,7);
    j=j+1;
end

tab_data_final=tab_data_final'

%Transposée
hist=hist'

%%
tab_data_final{1,2}=hist{1,1};
for i=2:72
    tab_data_final{i,2}=hist{i,1};
end
j=1;
for i=73:144 
    tab_data_final{i,2}=hist{j,2};
    j=j+1;
end

j=1;
for i=145:216
    tab_data_final{i,2}=hist{j,3};
    j=j+1;
end

j=1;
for i=217:288
    tab_data_final{i,2}=hist{j,4};
    j=j+1;
end

j=1;
for i=289:360
    tab_data_final{i,2}=hist{j,5};
    j=j+1;
end

j=1;
for i=361:432
    tab_data_final{i,2}=hist{j,6};
    j=j+1;
end

j=1;
for i=433:504
    tab_data_final{i,2}=hist{j,7};
    j=j+1;
end

%% Données LBP 
load lbp.mat
%%
for i=1:72
   tab_data_final{i,3}=lbp_class{1};
end

for i=73:144
   tab_data_final{i,3}=lbp_class{2};
end

for i=145:216
   tab_data_final{i,3}=lbp_class{3};
end

for i=217:288
   tab_data_final{i,3}=lbp_class{4};
end

for i=289:360
   tab_data_final{i,3}=lbp_class{5};
end

for i=361:432
   tab_data_final{i,3}=lbp_class{6};
end

for i=433:504
   tab_data_final{i,3}=lbp_class{7};
end
%% Classification data
figure;
for i=1:504
plot3(tab_data_final{i,1},tab_data_final{i,2},tab_data_final{i,3},'b.'), hold on;
title 'Classification Data';
xlabel 'Moyenne histo des images'; 
ylabel 'Rapport longueur largeur';
zlabel 'Moyenne des LBP';
end

%% Expected classification

figure;
for i=1:72
plot3(tab_data_final{i,1},tab_data_final{i,2},tab_data_final{i,3},'b.'), hold on;
title 'Perfect Classification';
xlabel 'Moyenne histo des images'; 
ylabel 'Rapport longueur largeur';
zlabel 'Moyenne des LBP';
end
for i=73:144
plot3(tab_data_final{i,1},tab_data_final{i,2},tab_data_final{i,3},'y.'), hold on;
end
for i=145:216
plot3(tab_data_final{i,1},tab_data_final{i,2},tab_data_final{i,3},'r.'), hold on;
end
for i=217:288
plot3(tab_data_final{i,1},tab_data_final{i,2},tab_data_final{i,3},'k.'), hold on;
end
for i=289:360
plot3(tab_data_final{i,1},tab_data_final{i,2},tab_data_final{i,3},'m.'), hold on;
end
for i=361:432
plot3(tab_data_final{i,1},tab_data_final{i,2},tab_data_final{i,3},'g.'), hold on;
end
for i=433:504
plot3(tab_data_final{i,1},tab_data_final{i,2},tab_data_final{i,3},'c.'), hold on;
end
%%
ZZ=zeros(504,3);
%%
ZZ=cell2mat(tab_data_final);
%% k-means classification 
[idx,C] = kmeans(ZZ,7);
%%
figure;
plot3(ZZ(idx==1,1),ZZ(idx==1,2),ZZ(idx==1,3),'b.','MarkerSize',10)
hold on
plot3(ZZ(idx==2,1),ZZ(idx==2,2),ZZ(idx==2,3),'y.','MarkerSize',10)
hold on
plot3(ZZ(idx==3,1),ZZ(idx==3,2),ZZ(idx==3,3),'r.','MarkerSize',10)
hold on
plot3(ZZ(idx==4,1),ZZ(idx==4,2),ZZ(idx==4,3),'k.','MarkerSize',10)
hold on
plot3(ZZ(idx==5,1),ZZ(idx==5,2),ZZ(idx==5,3),'m.','MarkerSize',10)
hold on
plot3(ZZ(idx==6,1),ZZ(idx==6,2),ZZ(idx==6,3),'g.','MarkerSize',10)
hold on
plot3(ZZ(idx==7,1),ZZ(idx==7,2),ZZ(idx==7,3),'c.','MarkerSize',10)
plot3(C(:,1),C(:,2),C(:,3),'kx',...
     'MarkerSize',10,'LineWidth',1) 
%legend('Cluster 1','Cluster 2','Centroids',...
%     'Location','NW')
title 'Cluster Assignments and Centroids'
hold off

%% Verité 

verite=zeros(504,1);

for i=1:72
verite(i)=1;
end
for i=73:144
verite(i)=2;
end
for i=145:216
verite(i)=3;
end
for i=217:288
verite(i)=4;
end
for i=289:360
verite(i)=5;
end
for i=361:432
verite(i)=6;
end
for i=433:504
verite(i)=7;
end

