[data time temp]=textread('28-0000054b45c6.txt','%s %s\t%s');
database=[data time temp];
ini=17916;
%fin=length(database);
fin=18096;
i=ini:fin;
plot(i,str2num(cell2mat(database(ini:fin,3))));
saveas(gcf,'28-0000054b45c6.jpg');
close;