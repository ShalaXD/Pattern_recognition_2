close all;
clear all;

load('assign2 2017.mat');
%% probability of error for case 1
mu_a1 = [0,0]';
sigma_a1 = [1,0; 0,1];
mu_b1 = [3,0]';
sigma_b1 = [1,0; 0,1];

%% using MED
syms a b;
c = [a;b];
eqn1 = ((c - mu_a1)' * (c - mu_a1));
eqn2 = ((c - mu_b1)' * (c - mu_b1));
[med1] = solve(eqn1 - eqn2);  
med1 = double(med1);
a1_med = 1 - mvncdf([-Inf,-Inf],[med1,Inf],mu_a1',sigma_a1)
b1_med = 1 - mvncdf([med1,-Inf],[Inf,Inf],mu_b1',sigma_b1)

%fun = @(x,y) 1/(2*pi)*exp(-(1/2)*(x.^2+y.^2));
%a1_med = integral2(fun,1.5,inf,-inf,inf)

%% using GED
syms a b;
c = [a;b];
eqn1 = (c - mu_a1)' * sigma_a1^-1 * (c - mu_a1);
eqn2 = (c - mu_b1)' * sigma_b1^-1 * (c - mu_b1);
[ged1]= solve(eqn1 - eqn2);

ged1 = double(ged1);
a1_ged = 1 - mvncdf([-Inf,-Inf],[ged1,Inf],mu_a1',sigma_a1)
b1_ged = 1 - mvncdf([ged1,-Inf],[Inf,Inf],mu_b1',sigma_b1)

%% probability of error for case 2
mu_a2 = [-1,0]';
sigma_a2 = [4,3; 3,4];
mu_b2 = [1,0]';
sigma_b2 = [4,3; 3,4];

%% using MED
syms a b;
c = [a;b];
eqn1 = ((c - mu_a2)' * (c - mu_a2));
eqn2 = ((c - mu_b2)' * (c - mu_b2));
[med2] = solve(eqn1 - eqn2);  
med2 = double(med2);
a2_med = 1 - mvncdf([-Inf,-Inf],[med2,Inf],mu_a2',sigma_a2)
b2_med = 1 - mvncdf([med2,-Inf],[Inf,Inf],mu_b2',sigma_b2)

%% using GED
syms a b;
c = [a;b];
eqn1 = (c - mu_a2)' * sigma_a2^-1 * (c - mu_a2);
eqn2 = (c - mu_b2)' * sigma_b2^-1 * (c - mu_b2);
eqn3 = eqn1 - eqn2;
[x3] = solve(eqn3,'ReturnConditions',true);

%fun = @(x,y) 1/(sigma_a2^2 *(2*pi))*exp(-(1/(2*sigma_a2^2))*((x-mu_a2(1)).^2+(y-mu_a2(2)).^2));
%fun = @(x) 1/(sigma_a2*sqrt(2*pi))*exp(-(x-mu_a2')^2/(2*sigma_a2^2));
%funy = @(x) 4/3*x;
%a2_ged = integral2(fun,-inf,inf,funy,inf)
%% probability of error for case 3
mu_a3 = [0,0]';
sigma_a3 = [3,1; 1,2];
mu_b3 = [3,0]';
sigma_b3 = [7,-3; -3,4];

syms a b;
c = [a;b];
eqn1 = ((c - mu_a3)' * (c - mu_a3));
eqn2 = ((c - mu_b3)' * (c - mu_b3));
[med3] = solve(eqn1 - eqn2);  
med3 = double(med3);
a3_med = 1 - mvncdf([-Inf,-Inf],[med3,Inf],mu_a3',sigma_a3)
b3_med = 1 - mvncdf([med3,-Inf],[Inf,Inf],mu_b3',sigma_b3)

