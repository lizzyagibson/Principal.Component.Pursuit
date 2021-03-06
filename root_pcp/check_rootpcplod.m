% demo_mixtures
clear;

addpath('/Users/lizzy/Principal.Component.Pursuit');
load('/Users/lizzy/Principal.Component.Pursuit/Data/mixtures_data.mat');

%X = [pm25 pm1 Al As Ba bc Br Ca Cl Cr Cu Fe K Mn Ni Pb S Se Si Ti V Zn];
X = [Al As Ba bc Br Ca Cl Cr Cu Fe K  Mn  Ni  Pb  S  Se  Si Ti  V Zn];
n = [ 1  2  3  4  5  6  7  8  9 10 11 12  13  14  15 16  17 18 19 20];
% [] makes a vector, take columns from data set, put into matrix as columns

numMissingPerRow = sum( isnan(X), 2 ); 
%get rid of rows with NANs
goodRows = find( numMissingPerRow == 0 ); 
% good rows without missing data

X = X(goodRows,:); 
%semicolon means it doesnt output the results

[m,p] = size(X);
% m and n become the number of rows and columns

Xmissing = X;
Xmissing(1,1) = NaN;

Xlod = X;
Xlod(10:20,5:10) = -1;

Xmissinglod = X;
Xmissinglod(1:10,1:5) = NaN;
Xmissinglod(10:20,5:10) = -1;

lambda = 1/sqrt(m); 
mu = sqrt(p/(2*log(m*p)));

%% Run models

disp("Nonnegative, NA, LOD, no missing or <LOD")
[L1,S1] = root_pcp_with_nan_nonnegL_LOD(X, lambda, mu, 0); 
norm(L1, "Fro")
norm(S1, "Fro")

disp("Nonnegative, NA, LOD, with missing")
[Ly,Sy] = root_pcp_with_nan_nonnegL_LOD(Xmissing, lambda, mu, 0); 
norm(Ly, "Fro")
norm(Sy, "Fro")

disp("Nonnegative, NA, LOD, with <LOD")
[L3,S3] = root_pcp_with_nan_nonnegL_LOD(Xlod, lambda, mu, 0); 
norm(L3, "Fro")
norm(S3, "Fro")

disp("Nonnegative, NA, LOD, with missing & <LOD")
[L4,S4] = root_pcp_with_nan_nonnegL_LOD(Xmissinglod, lambda, mu, 0); 
norm(L4, "Fro")
norm(S4, "Fro")
