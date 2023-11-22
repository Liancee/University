%Vector times vector%
disp('1.2 Vector times vector')

x = [1/16; 2/7; 3]
y = [4; 5; 6]

z_1 = x .* y
z_2 = x' * y
z_3 = x * y'