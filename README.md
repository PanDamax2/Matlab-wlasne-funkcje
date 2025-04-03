# Klasa `lichkosz` – Konwersja liczb w MATLAB

## Opis

Funkcje do zamiany liczb między systemami binarnym, dziesiętnym i szesnastkowym.

## Funkcje

### `binarnaNaDziesietna(bin)`

**'1010'** --> **10**  
Zamienia liczbę binarną na dziesiętną.  
Bin musi być stringiem `'0'` i `'1'`.

### `dziesietnaNaBinarna(dec)`

**10** --> **'1010'**  
Zamienia liczbę dziesiętną na binarną.  
Dec musi być liczbą `dziesiętną nieujemną`.

### `hexNaDziesietna(hex)`

**'A'** --> **10**  
Zamienia liczbę szesnastkową na dziesiętną.  
Hex musi być stringiem ze znakami `'0-9'`, `'A-F'`.

### `dziesietnaNaHex(dec)`

**10** --> **'A'**  
Zamienia liczbę dziesiętną na szesnastkową.  
Dec musi być liczbą `dziesiętną nieujemną`.

### `binarnaNaHex(bin)`

**'1010'** --> **'A'**  
Zamienia liczbę binarną na szesnastkową.  
Bin musi być stringiem `'0'` i `'1'`.

### `hexNaBinarna(hex)`

**'A'** --> **'1010'**  
Zamienia liczbę szesnastkową na binarną.  
Hex musi być stringiem `'0-9'`, `'A-F'`.

### `dziesietnaNaIEEE754(dec)`

**-15** --> **'1 10000010 11100000000000000000000'**
Konwertuje liczbę rzeczywistą na IEEE 754 (32-bit).
Dec musi być liczbą `wymierną`.

### `zmiennoprzecinkowaNaBinarna(a, precision)`

**0.875** --> **'0.1110000000'**
Konwertuje liczbe zmiennoprzecinkową na binarną z precyzją do ilu miejsc.
A musi być liczbą `od 0 do 1`. Precision musi być liczbą `naturalną`.

### `interpolacjaVandermonde(x, y)`
**Opis:*
Rozwiazuje problem interpolacji jednomianami korzystajac z macierzy Vandermonde’a.

**Parametry:**  
- `x` – wektor węzłów interpolacji.  
- `y` – wektor wartości funkcji.

**Wyjście:**  
- `wspolczynniki` – wektor współczynników wielomianu interpolacyjnego.

**Przykład użycia w MATLAB:**
```matlab
x = [1 2 3 6];
y = [6 25 74 521];
wspolczynniki = lichkosz.interpolacjaVandermonde(x, y);
disp(wspolczynniki);
```

### `obliczWartoscWielomianu(wspolczynniki, x)`
**Opis:**
Oblicza wartość wielomianu dla podanej wartości x, stosując schemat Hornera.

**Parametry:**  
- `wspolczynniki` – wektor współczynników wielomianu.
- `x` – punkt, w którym obliczamy wartość.

**Wyjście:**  
- `wartosc` – wartość wielomianu w punkcie x.

**Przykład użycia w MATLAB:**
```matlab
wspolczynniki = [2 -3 5];  % 2x^2 - 3x + 5
x = 4;
wynik = lichkosz.obliczWartoscWielomianu(wspolczynniki, x);
disp(wynik);
```

### `interpolacjaLagrange(xWezly, yWezly, x)`
**Opis:**
Interpolacja wielomianowa metodą Lagrange’a.

**Parametry:**  
- `xWezly` – wektor węzłów interpolacji.
- `yWezly` – wektor wartości funkcji.
- `x` – punkt, w którym obliczamy wartość interpolacji.

**Wyjście:**  
- `wartosc` – wartość wielomianu interpolacyjnego w punkcie x.

**Przykład użycia w MATLAB:**
```matlab
xWezly = [1 2 3 4];
yWezly = [2 4 9 16];
x = 2.5;
wynik = lichkosz.interpolacjaLagrange(xWezly, yWezly, x);
disp(wynik);
```

### `ilorazyRoznicoweNewton(xWezly, yWezly)`
**Opis:**
Oblicza ilorazy różnicowe potrzebne do interpolacji Newtona.

**Parametry:**  
- `xWezly` – wektor węzłów interpolacji.
- `yWezly` –  wektor wartości funkcji.

**Wyjście:**  
- `f` – wektor ilorazów różnicowych.

**Przykład użycia w MATLAB:**
```matlab
xWezly = [1 2 3 4];
yWezly = [2 4 9 16];
ilorazy = lichkosz.ilorazyRoznicoweNewton(xWezly, yWezly);
disp(ilorazy)
```

### `interpolacjaNewtona(xWezly, yWezly, x)`
**Opis:**
Interpolacja wielomianowa metodą Newtona.

**Parametry:**  
- `xWezly` – wektor węzłów interpolacji.
- `yWezly` –  wektor wartości funkcji.
- `x` – punkt, w którym obliczamy wartość interpolacji.

**Wyjście:**  
- `wartosc` – wartość wielomianu interpolacyjnego w punkcie x.

**Przykład użycia w MATLAB:**
```matlab
xWezly = [1 2 3 4];
yWezly = [2 4 9 16];
x = 2.5;
wynik = lichkosz.interpolacjaNewtona(xWezly, yWezly, x);
disp(wynik);
```

### `wezlyCzebyszewa(a, b, n)`
**Opis:**
Oblicza węzły Czebyszewa w przedziale [a, b].

**Parametry:**  
- `a, b` – granice przedziału interpolacji.
- `n` –  liczba węzłów.

**Wyjście:**  
- `wezly` – wektor węzłów Czebyszewa.

**Przykład użycia w MATLAB:**
```matlab
a = -1;
b = 1;
n = 5;
wezly = lichkosz.wezlyCzebyszewa(a, b, n);
disp(wezly);
```

### `mnozenie_przez_skalar(A, skalar)`

**`A = [1 2; 3 4]`, `skalar = 5`**  
--> **`[5 10; 15 20]`**  
Mnoży macierz `A` przez skalar `skalar`.  
- `A` musi być macierzą.  
- `skalar` musi być liczbą.  

### `transponowanie_macierzy(A)`

**`A = [1 2 3; 4 5 6]`**  
--> **`[1 4; 2 5; 3 6]`**  
Zwraca macierz transponowaną `A`.  
- `A` musi być macierzą.  

### `dodaj_odejmij_macierze(A, B, operacja)`

**`A = [1 2; 3 4]`, `B = [5 6; 7 8]`, `operacja = '+'`**  
--> **`[6 8; 10 12]`**  
Dodaje lub odejmuje macierze `A` i `B`, w zależności od parametru `operacja`.  
- `operacja` może być `'+'` lub `'-'`.  
- `A` i `B` muszą mieć ten sam rozmiar.  

### `mnozenie_macierzy(A, B)`

**`A = [1 2; 3 4]`, `B = [5 6; 7 8]`**  
--> **`[19 22; 43 50]`**  
Mnoży macierze `A` i `B` za pomocą potrójnej pętli.  
- Liczba kolumn `A` musi być równa liczbie wierszy `B`.  

### `trojkatna_gorna_i_wyznacznik(A)`

**`A = [2 -1 3; 4 2 1; -2 1 5]`**  
--> **Górna macierz trójkątna i jej wyznacznik**  
Przekształca macierz `A` do postaci trójkątnej górnej i oblicza jej wyznacznik.  
- `A` musi być macierzą kwadratową.  

### `mnozenie_elementowe(A, B)`

**`A = [1 2; 3 4]`, `B = [5 6; 7 8]`**  
--> **`[5 12; 21 32]`**  
Mnoży elementy `A(i,j)` przez `B(i,j)`.  
- `A` i `B` muszą mieć ten sam rozmiar.  

### `wyznacz_wartosci_wlasne(A)`

**`A = [2 -1; -1 2]`**  
--> **Wartości własne macierzy `A`**  
Oblicza wartości własne macierzy `A` metodą charakterystycznego wielomianu.  
- `A` musi być macierzą kwadratową.  


## Uwaga

- Bin i hex muszą być stringami zapisanymi w pojedynczych `'` cudzysłowach.
- Liczby dziesiętne muszą być całkowite i nieujemne.
