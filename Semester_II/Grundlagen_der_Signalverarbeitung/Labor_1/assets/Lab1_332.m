% Task 3.3.2: Vector multiplied with vector

% Reset
clear all;
close all;
clc;

% Given values
x = [1/16; 2/7; 3];
y = [4; 5; 6];

% Solutions
z_1 = x .* y
z_2 = x' * y
z_3 = x * y'