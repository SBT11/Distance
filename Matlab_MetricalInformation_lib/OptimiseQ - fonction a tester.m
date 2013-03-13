function ValeurOptimale = OptimiseQ(vi,vf,p);

%%vi = valeur initiale de q
%%vf = valeur finale
%%p = pas

a = round((vf - vi)./p)

MaxInformation = zeros(a,1);
Tcritique = zeros(a,1);
Q = zeros(a,1);
for q = vi: p: vf
   Result=MainAnalysisFunc('ST.dat','out_testing',10,q,-2,0,1);
   l=length(Result);
   p=round(q./p + 1);
   MaxInformation(p) = Result(l);
   Q(p) = q;
   k=1;
   while abs(Result(k) - MaxInformation(p))./MaxInformation(p) > 0.05
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

set(get(AX(1),'Ylabel'),'String','Temps critique') 
set(get(AX(2),'Ylabel'),'String','Information maximale') 

xlabel('Valeur de q en /ms') 
title('Pour 10 répétition') 

set(H1,'LineStyle','--')
set(H2,'LineStyle','-')

end