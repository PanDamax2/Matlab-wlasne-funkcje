% Dokumentacja https://github.com/PanDamax2/Matlab-wlasne-funkcje

classdef lichkosz
    methods(Static)
        %% ------Konwertuje liczbę binarną na dziesiętną
        function dec = binarnaNaDziesietna(bin)
            % Sprawdzenie poprawności wejścia (musi być string '0' i '1')
            if ~ischar(bin) || isempty(regexp(bin, '^[01]+$', 'once'))
                error('Błąd: Wejście musi być poprawnym ciągiem znaków 0 i 1 zapisanym w pojedynczych cudzysłowach ''.');
            end
            dec = bin2dec(bin);
        end

        %% ------Konwertuje liczbę dziesiętną na binarną
        function bin = dziesietnaNaBinarna(dec)
            % Sprawdzenie poprawności wejścia (musi być liczbą dziesiętną nieujemną)
            if ~isscalar(dec) || ~isnumeric(dec) || dec < 0 || floor(dec) ~= dec
                error('Błąd: Wejście musi być liczbą dziesiętną nieujemną.');
            end
            bin = dec2bin(dec);
        end

        %% ------Konwertuje liczbę szesnastkową na dziesiętną
        function dec = hexNaDziesietna(hex)
            % Sprawdzenie poprawności wejścia (musi być stringiem z cyframi 0-9, A-F zapisanym w pojedynczych cudzysłowach '')
            if ~ischar(hex) || isempty(regexp(hex, '^[0-9A-Fa-f]+$', 'once'))
                error('Błąd: Wejście musi być poprawnym ciągiem znaków z cyframi 0-9, A-F zapisanym w pojedynczych cudzysłowach ''.');
            end
            dec = hex2dec(hex);
        end

        %% ------Konwertuje liczbę dziesiętną na szesnastkową
        function hex = dziesietnaNaHex(dec)
            % Sprawdzenie poprawności wejścia (musi być liczbą dziesiętną nieujemną)
            if ~isscalar(dec) || ~isnumeric(dec) || dec < 0 || floor(dec) ~= dec
                error('Błąd: Wejście musi być liczbą dziesiętną nieujemną.');
            end
            hex = upper(dec2hex(dec));
        end

        %% ------Konwertuje liczbę binarną na szesnastkową
        function hex = binarnaNaHex(bin)
            % Sprawdzenie poprawności wejścia (musi być string '0' i '1')
            if ~ischar(bin) || isempty(regexp(bin, '^[01]+$', 'once'))
                error('Błąd: Wejście musi być poprawnym ciągiem znaków 0 i 1 zapisanym w pojedynczych cudzysłowach ''.');
            end
            hex = upper(dec2hex(bin2dec(bin)));
        end

        %% ------Konwertuje liczbę szesnastkową na binarną
        function bin = hexNaBinarna(hex)
            % Sprawdzenie poprawności wejścia (musi być stringiem z cyframi 0-9, A-F zapisanym w pojedynczych cudzysłowach '')
            if ~ischar(hex) || isempty(regexp(hex, '^[0-9A-Fa-f]+$', 'once'))
                error('Błąd: Wejście musi być poprawnym ciągiem znaków z cyframi 0-9, A-F zapisanym w pojedynczych cudzysłowach ''.');
            end
            bin = dec2bin(hex2dec(hex));
        end

        %% ------Konwertuje liczbę rzeczywistą na IEEE 754 (32-bit)
        function ieee = dziesietnaNaIEEE754(dec)
             % Sprawdzenie poprawności wejścia (musi być liczbą rzeczywistą)
            if ~isscalar(dec) || ~isnumeric(dec)
                error('Błąd: Wejście musi być liczbą rzeczywistą.');
            end
            ieee = dec2bin(typecast(single(dec), 'uint32'), 32);
        end
        
        %% ------Konwertuje liczbę zmiennoprzecinkową na system binarny (0 < a < 1)
        function bin = zmiennoprzecinkowaNaBinarna(a, precision)
            % Sprawdzenie poprawności wejścia (liczba musi być z zakresu 0 < a < 1)
            if a <= 0 || a >= 1
                error('Błąd: Wejście musi być liczbą z zakresu 0 < a < 1.');
            end
            
            % Sprawdzenie poprawności dokładności
            if ~isscalar(precision) || ~isnumeric(precision) || precision <= 0 || floor(precision) ~= precision
                error('Błąd: Precyzja musi być liczbą całkowitą dodatnią.');
            end
            
            % Rozpocznij konwersję
            bin = '0.';  % Początkowy ciąg w binarnym
            for i = 1:precision
                a = a * 2;  % Mnożymy przez 2
                if a >= 1
                    bin = [bin '1'];  % Dodajemy '1' do wyniku, gdy liczba >= 1
                    a = a - 1;  % Odejmujemy '1' po dodaniu do wyniku
                else
                    bin = [bin '0'];  % Dodajemy '0' do wyniku
                end
            end
        end

        %% ------ Interpolacja jednomianami (Vandermonde)
        function wspolczynniki = interpolacjaVandermonde(x, y)
            if length(x) ~= length(y)
                error('Wektory x i y musza miec taka sama dlugosc.');
            end
            
            n = length(x);
            V = zeros(n);
            for i = 1:n
                for j = 1:n
                    V(i, j) = x(i)^(n - j);
                end
            end
            wspolczynniki = V \ y(:);
        end
        %% ------ Obliczanie wartosci wielomianu (Horner)
        function wartosc = obliczWartoscWielomianu(wspolczynniki, x)
            if isempty(wspolczynniki)
                error('Wektor wspolczynnikow nie moze byc pusty.');
            end
            
            wartosc = wspolczynniki(1);
            for i = 2:length(wspolczynniki)
                wartosc = wartosc * x + wspolczynniki(i);
            end
        end
        
        %% ------ Interpolacja metoda Lagrange’a
        function wartosc = interpolacjaLagrange(xWezly, yWezly, x)
            if length(xWezly) ~= length(yWezly)
                error('Wektory xWezly i yWezly musza miec taka sama dlugosc.');
            end
            
            n = length(xWezly);
            wartosc = 0;
            for i = 1:n
                L = 1;
                for j = 1:n
                    if i ~= j
                        L = L * (x - xWezly(j)) / (xWezly(i) - xWezly(j));
                    end
                end
                wartosc = wartosc + yWezly(i) * L;
            end
        end
        
        %% ------ Ilorazy roznicowe Newtona
        function f = ilorazyRoznicoweNewton(xWezly, yWezly)
            if length(xWezly) ~= length(yWezly)
                error('Wektory xWezly i yWezly musza miec taka sama dlugosc.');
            end
            
            n = length(xWezly);
            F = zeros(n, n);
            F(:, 1) = yWezly(:);
            for j = 2:n
                for i = 1:(n - j + 1)
                    F(i, j) = (F(i+1, j-1) - F(i, j-1)) / (xWezly(i+j-1) - xWezly(i));
                end
            end
            f = F(1, :);
        end
        
        %% ------ Interpolacja metoda Newtona
        function wartosc = interpolacjaNewtona(xWezly, yWezly, x)
            if length(xWezly) ~= length(yWezly)
                error('Wektory xWezly i yWezly musza miec taka sama dlugosc.');
            end
            
            f = lichkosz.ilorazyRoznicoweNewton(xWezly, yWezly);
            n = length(xWezly);
            wartosc = f(1);
            for i = 2:n
                term = f(i);
                for j = 1:(i-1)
                    term = term * (x - xWezly(j));
                end
                wartosc = wartosc + term;
            end
        end
        
        %% ------ Wyznaczanie wezlow Czebyszewa
        function wezly = wezlyCzebyszewa(a, b, n)
            if a >= b
                error('Wartosc a musi byc mniejsza od b.');
            end
            if n < 1
                error('Liczba wezlow n musi byc wieksza od zera.');
            end
            
            k = 1:n;
            wezly = 0.5 * (a + b) + 0.5 * (b - a) * cos(((2 * k - 1) * pi) / (2 * n));
        end
        
        %% ------ Interpolacja danych (urodziny) metoda Newtona
        function [yInterpolowana, bladAbs, bladWzgledny] = interpolacjaNewtonUrodziny(xWezly, yWezly, x, y)
            if length(xWezly) ~= length(yWezly)
                error('Wektory xWezly i yWezly musza miec taka sama dlugosc.');
            end
            if ~isscalar(x) || ~isscalar(y)
                error('x i y musza byc skalarami.');
            end
            
            yInterpolowana = lichkosz.interpolacjaNewtona(xWezly, yWezly, x);
            bladAbs = abs(yInterpolowana - y);
            bladWzgledny = (bladAbs / y) * 100;
        end

        %% ------ Mnożenie macierzy przez skalar
        function C = mnozenie_przez_skalar(A, skalar)
            if ~ismatrix(A) || ~isscalar(skalar)
                error('Zla podana wartosc! A musi byc macierza, a skalar liczba.');
            end

            [wiersze, kolumny] = size(A);
            C = zeros(wiersze, kolumny);
            for i = 1:wiersze
                for j = 1:kolumny
                    C(i, j) = A(i, j) * skalar;
                end
            end
        end

        %% ------ Transpozycja macierzy
        function B = transponowanie_macierzy(A)
            if ~ismatrix(A)
                error('Zla podana wartosc! A musi byc macierza.');
            end

            [wiersze, kolumny] = size(A);
            B = zeros(kolumny, wiersze);
            for i = 1:wiersze
                for j = 1:kolumny
                    B(j, i) = A(i, j);
                end
            end
        end

        %% ------ Dodawanie/Odejmowanie macierzy
        function C = dodaj_odejmij_macierze(A, B, operacja)
            if ~ismatrix(A) || ~ismatrix(B)
                error('Zla podana wartosc! A i B musza byc macierzami.');
            end

            [wierszeA, kolumnyA] = size(A);
            [wierszeB, kolumnyB] = size(B);

            if wierszeA ~= wierszeB || kolumnyA ~= kolumnyB
                error('Macierze musza miec ten sam rozmiar!');
            end

            if ~ischar(operacja) || ~ismember(operacja, {'+', '-'})
                error('Nieznana operacja! Uzyj "+" lub "-".');
            end

            C = zeros(wierszeA, kolumnyA);
            for i = 1:wierszeA
                for j = 1:kolumnyA
                    if operacja == "+"
                        C(i, j) = A(i, j) + B(i, j);
                    else
                        C(i, j) = A(i, j) - B(i, j);
                    end
                end
            end
        end

        %% ------ Mnożenie macierzy A * B za pomocą potrójnej pętli
        function C = mnozenie_macierzy(A, B)
            if ~ismatrix(A) || ~ismatrix(B)
                error('Zla podana wartosc! A i B musza byc macierzami.');
            end

            [wierszeA, kolumnyA] = size(A);
            [wierszeB, kolumnyB] = size(B);

            if kolumnyA ~= wierszeB
                error('Liczba kolumn A musi byc rowna liczbie wierszy B!');
            end

            C = zeros(wierszeA, kolumnyB);
            for i = 1:wierszeA
                for j = 1:kolumnyB
                    for k = 1:kolumnyA
                        C(i, j) = C(i, j) + A(i, k) * B(k, j);
                    end
                end
            end
        end

        %% ------ Macierz trójkątna górna i wyznacznik
        function [U, wyznacznik] = trojkatna_gorna_i_wyznacznik(A)
            if ~ismatrix(A) || ~isnumeric(A)
                error('Zla podana wartosc! A musi byc macierza liczbową.');
            end

            [wiersze, kolumny] = size(A);

            if wiersze ~= kolumny
                error('Macierz musi byc kwadratowa!');
            end

            U = A;
            for k = 1:wiersze-1
                for i = k+1:wiersze
                    if U(k, k) ~= 0
                        czynnik = U(i, k) / U(k, k);
                        for j = k:kolumny
                            U(i, j) = U(i, j) - czynnik * U(k, j);
                        end
                    end
                end
            end

            wyznacznik = 1;
            for i = 1:wiersze
                wyznacznik = wyznacznik * U(i, i);
            end
        end

        %% ------ Mnożenie elementowe A(i, j) * B(i, j)
        function C = mnozenie_elementowe(A, B)
            if ~ismatrix(A) || ~ismatrix(B)
                error('Zla podana wartosc! A i B musza byc macierzami.');
            end

            [wierszeA, kolumnyA] = size(A);
            [wierszeB, kolumnyB] = size(B);

            if wierszeA ~= wierszeB || kolumnyA ~= kolumnyB
                error('Macierze musza miec ten sam rozmiar!');
            end

            C = zeros(wierszeA, kolumnyA);
            for i = 1:wierszeA
                for j = 1:kolumnyA
                    C(i, j) = A(i, j) * B(i, j);
                end
            end
        end

        %% ------ Wartości własne macierzy
        function wartosci_wlasne = wyznaczanie_wartosci_wlasnych(A)
            if ~ismatrix(A) || ~isnumeric(A)
                error('Zla podana wartosc! A musi byc macierza liczbową.');
            end

            [wiersze, kolumny] = size(A);

            if wiersze ~= kolumny
                error('Macierz musi byc kwadratowa!');
            end

            syms lambda;
            I = eye(wiersze);
            wielomian_charakterystyczny = det(A - lambda * I);
            wspolczynniki = coeffs(wielomian_charakterystyczny, lambda);
            wartosci_wlasne = roots(double(wspolczynniki));
        end

        %% ------ Obliczanie błędu średniokwadratowego (MSE)
        function mse = bladSredniokwadratowy(y, x)
            % Sprawdzenie poprawności wejścia (wektory o tej samej długości)
            if ~isvector(y) || ~isvector(x)
                error('Błąd: Wejścia muszą być wektorami.');
            end
            if length(y) ~= length(x)
                error('Błąd: Wektory y i x muszą mieć tę samą długość.');
            end
        
            n = length(y);
            suma = 0;
            % Iteracyjne sumowanie kwadratów błędów
            for i = 1:n
                suma = suma + (y(i) - x(i))^2;
            end
            % Obliczanie średniej z sumy kwadratów
            mse = suma / n;
        end






        
    end
end
