clc;


a = -1;
b = 1;
n = 5;
wezly = lichkosz.wezlyCzebyszewa(a, b, n);
disp(wezly);

yRzeczywiste = [1, 2, 3, 4, 5];
yPredykowane = [1.1, 1.9, 3.2, 3.8, 5.1];

mse = lichkosz.bladSredniokwadratowy(yRzeczywiste, yPredykowane);

fprintf('Błąd średniokwadratowy: %.4f\n', mse);