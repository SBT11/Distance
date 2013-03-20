function [MaxInformation,Tcritique] = OptimiseQ(vi,vf,h,FileName,nb)

%%vi = valeur initiale de q
%%vf = valeur finale
%%h = pas
%%nb = nb de repetitions

a = round((vf - vi)/h);

MaxInformation = zeros(a,1);
Tcritique = zeros(a,1);
Q = zeros(a,1);
for q = vi: h: vf
   Result=MainAnalysisFunc(FileName,'out_testing',10,q,-2,0,1);
   p=round(q/h + 1);
   MaxInformation(p) = max(Result);
   Q(p) = q;
   k=1;
   while abs(Result(k) - MaxInformation(p))/MaxInformation(p) > 0.05
       k=k+1;
   end
   Tcritique(p) = 10.*k;
end

%%Representation graphique

figure
x = Q;
y1 = Tcritique;
y2 = MaxInformation;
[AX,H1,H2] = plotyy(x,y1,x,y2,'plot');

set(get(AX(1),'Ylabel'),'String','Temps critique (ms)') 
set(get(AX(2),'Ylabel'),'String','Information maximale') 

xlabel('Valeur de q en /ms') 
title(strcat('Pour', ' ', num2str(nb), ' répétitions')) 

set(H1,'LineStyle','--','LineWidth',1)
set(H2,'LineStyle','-','LineWidth',1)

end