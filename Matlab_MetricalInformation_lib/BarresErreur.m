%% Barres d'Erreur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Script for calculating standard error of MaxInformation and Tcritique
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Q = zeros(1,21);
for q = 1:21
    Q(q)=(q-1)/100;
end


%%Calculs pour jeux de 10 repetitions
Max = zeros(1,21);
Temps = zeros(1,21);
load('Data/10/10repet1.mat');
for k = 1:21
	Max(1,k)=MaxInformation(k);
	Temps(1,k)=Tcritique(k);
end


for k = 2:10
	MaxTemporaire = zeros(1,21);
	TempsTemporaire = zeros(1,21);
	datafilename = strcat('Data/10/10repet',num2str(k),'.mat');
	load(datafilename);
	for l = 1:21
		MaxTemporaire(1,l)=MaxInformation(l);
		TempsTemporaire(1,l)=Tcritique(l);
	end
	Max=vertcat(Max,MaxTemporaire);
	Temps=vertcat(Temps,TempsTemporaire);
end

%% Intermediate calculations
MeanMaxInfo = mean(Max);
MeanTemps = mean(Temps);
%Sample standard deviations
SSDM = zeros(1,21);
SSDT = zeros(1,21);
for k = 1:21
	for l = 1:10
		SSDM(k)=SSDM(k)+(Max(l)-MeanMaxInfo(k))*(Max(l)-MeanMaxInfo(k));
		SSDT(k)=SSDT(k)+(Max(l)-MeanTemps(k))*(Max(l)-MeanTemps(k));
	end
	SSDM(k)=sqrt(SSDM(k)/10);
	SSDT(k)=sqrt(SSDT(k)/10);
end
%Standard error of mean
SEMM = (1/sqrt(10))*SSDM;
SEMT = (1/sqrt(10))*SSDT;

%%Ca ne semble pas marcher pour l'instant!!!

%%Calculs pour jeux de 20 repetitions
Max2 = zeros(1,21);
Temps2 = zeros(1,21);
load('Data/20/20repet1.mat');
for k = 1:21
	Max2(1,k)=MaxInformation(k);
	Temps2(1,k)=Tcritique(k);
end


for k = 2:5
	MaxTemporaire = zeros(1,21);
	TempsTemporaire = zeros(1,21);
	datafilename = strcat('Data/20/20repet',num2str(k),'.mat');
	load(datafilename);
	for l = 1:21
		MaxTemporaire(1,l)=MaxInformation(l);
		TempsTemporaire(1,l)=Tcritique(l);
	end
	Max2=vertcat(Max2,MaxTemporaire);
	Temps2=vertcat(Temps2,TempsTemporaire);
end

%%Graphiques - ecarts types
figure
subplot(2,2,1)
x = Q;
y1 = std(Max);
bar(x,y1);

ylabel('Ecart type - information maximale') 
xlabel('Valeur de q en /ms') 
title('Pour 10 jeux de 10 répétitions')

subplot(2,2,2)
x = Q;
y2 = std(Max2);
bar(x,y2);

ylabel('Ecart type - information maximale') 
xlabel('Valeur de q en /ms') 
title('Pour 5 jeux de 20 répétitions') 

subplot(2,2,3)
x = Q;
y3 = std(Temps);
bar(x,y3);

ylabel('Ecart type - temps critique (ms)') 
xlabel('Valeur de q en /ms') 
title('Pour 10 jeux de 10 répétitions')

subplot(2,2,4)
x = Q;
y4 = std(Temps2);
bar(x,y4);

ylabel('Ecart type - temps critique (ms)') 
xlabel('Valeur de q en /ms') 
title('Pour 5 jeux de 20 répétitions') 

%%Graphiques - coefficients de variations
figure
subplot(2,2,1)
x = Q;
y5 = std(Max)./MeanMaxInfo;
bar(x,y5);

ylabel('CdV - information maximale') 
xlabel('Valeur de q en /ms') 
title('Pour 10 jeux de 10 répétitions')

subplot(2,2,2)
x = Q;
y6 = std(Max2)./mean(Max2);
bar(x,y6);

ylabel('CdV - information maximale') 
xlabel('Valeur de q en /ms') 
title('Pour 5 jeux de 20 répétitions') 

subplot(2,2,3)
x = Q;
y7 = std(Temps)./MeanTemps;
bar(x,y7);

ylabel('CdV - temps critique') 
xlabel('Valeur de q en /ms') 
title('Pour 10 jeux de 10 répétitions')

subplot(2,2,4)
x = Q;
y8 = std(Temps2)./mean(Temps2);
bar(x,y8);

ylabel('CdV - temps critique') 
xlabel('Valeur de q en /ms') 
title('Pour 5 jeux de 20 répétitions') 