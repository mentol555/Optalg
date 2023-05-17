function [x, Ex] = queen(n)
    % Futási idő teszt:
    tic;
    [x, Ex] = szimulaltHutesNqueen(500)
    toc;
end

function [x, Ex] = szimulaltHutesNqueen(n)
    % Szimulált hűtéssel keressen egymást nem ütő n-királynő lerakást egy n*n-es táblán
    
    % Egy véletlenszerű kezdő állapot előállítása
    x = randperm(n);
    
    % Az állapot energia számítása
    Ex = energy(x);
    
    % A hőmérséklet kezdeti értéke
    T = 1;
    
    % A hőmérséklet csökkenési faktora
    cool = 0.99;
    
    % A hőmérséklet nullánál való leállításának feltétele
    stopTemp = 0.000001;
    
    % amíg nagyobb a hőmérséklet mint a min hőmérséklet
    while T > stopTemp
        % Új állapot előállítása az aktuális állapotból
        y = ujAllapot(x);
    
        % Az új állapot energia számítása
        Ey = energy(y);
    
        % A valószínűség számítása
        p = exp((Ex - Ey) / T);
    
        % Az új állapot elfogadása vagy elutasítása
        if rand < p
            x = y;
            Ex = Ey;
        end
    
        % A hőmérséklet csökkentése
        T = cool * T;
    
    end
end

function E = energy(x)
    % Az állapot energia számítása
    n = length(x);
    E = 0;
    for i = 1:n-1
        for j = i+1:n
            % Ütések/konfliktusok vizsgálása
            if x(i) == x(j) || abs(x(i) - x(j)) == abs(i - j)
                E = E + 1;
            end
        end
    end
end

function y = ujAllapot(x)
    % Egy új állapot előállítása az aktuális állapotból
    n = length(x);
    i = randi(n);
    j = randi(n);
    while j == x(i)
        j = randi(n);
    end
    y = x;
    y(i) = j;
end
