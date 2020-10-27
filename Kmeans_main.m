clear all;

% Load data
name = 'Player_Data2016b.csv';
data2 = csvread(name,2,0);
data = [data2(:,3),data2(:,2)];

% Perform K-means clustering.
% The function provides visualization 
% to support up to 2clusters.
%%out = A3_452_P1(data);
Kmeans(data, 4);