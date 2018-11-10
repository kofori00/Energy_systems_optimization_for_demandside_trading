%Initial minimization 

clc
clear all
close all

min = fminunc(@FMin,[1;1])
function[K] = FMin(a)
measurements = table2array(readtable('measurements.csv'));
Qin = measurements(:,2);
Qout = measurements(:,3);
T = measurements(:,4);
Tamb = measurements(:,5);
E1 = 6;
delta = 3600;
A = 1 - delta*a(1);
B = [-delta*a(2), delta*a(2)];
tempArray = zeros(1,100+E1);
for k = 1:length(100+E1)   
    ck = delta*a(1)*Tamb(k);  
    tempArray(k) = (T(k+1) - (A*T(k) + B*[Qout(k);Qin(k)] + ck))^2;
    K = sum(tempArray);
end
end


% Energy Trade Minimization 
clc
clear all
close all

% Different E-values
E1 = 6;
E2 = 1;
E3 = 9;

%Read in files
heatDemand = table2array(readtable('heatDemand.csv'));
inputPrices = table2array(readtable('inputPrices.csv'));
measurements = table2array(readtable('measurements.csv'));

%Parameters
a1 = 1.96e-7;
a2 = 3.8e-9;
delta = 3600;
T1 = 330 + E3;
Tmin = 315;
Qmax = (100 + E2) * 1000;
Tamb = 275 + E1;

Qout = heatDemand(:,2);
Lambda = inputPrices(1:360,2);
f = [Lambda / 1e6; zeros(360,1)];

%Make matrix A
deel1 = zeros(360,360);
deel2 = deel1;
deel1(1,1) = -delta*a2;
deel2(1,1) = 1;
for i=2:1:360
    deel1(i,i) = -delta*a2;
    deel2(i,i) = 1;
    deel2(i,i-1) = delta*a1-1;
end
A=[deel1 deel2];

%Make vector b
deel1b = zeros(360,1);
deel1b(1) = -delta*a2*Qout(1) + delta*a1*Tamb + (1-delta*a1)*T1;
for i = 2:1:360
    deel1b(i) = -delta*a2*Qout(i) + delta*a1*Tamb;
end
b=[deel1b];

%Make upper and lower bounds
deel1Lb = zeros(360,1);
deel2Lb = deel1Lb;
deel1Ub = deel1Lb;
deel2Ub = deel1Lb;

deel1Ub = deel1Ub + Qmax;
deel2Lb = deel2Lb + Tmin;
deel2Ub = deel2Ub + inf;

Lb = [deel1Lb ; deel2Lb];
Ub = [deel1Ub ; deel2Ub];

o = optimoptions('linprog','Algorithm','dual-simplex');
[X, Fval, flag] = linprog(f,[],[],A,b,Lb,Ub,[],o);

%Exercise 2.4
Tref = 323;
ecost = (0.1+E2/10)/360;
Tmax = 368;
Ub2 = Ub;
Ub2(361:720) = Tmax;
H = zeros(720,720);
H(720,720) = ecost;
f2 = f;
f2(720,1) = -2*Tref*ecost;
[X2, Fval2, flag2] = quadprog(H,f,[],[],A,b,Lb,Ub,[]);
res = Fval2 - Tref*ecost;
