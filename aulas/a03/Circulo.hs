module Circulo where

-- diametro recebe o raio e devolve o diâmetro do círculo.
diametro :: Double -> Double
diametro r = 2 * r

-- perimetro recebe o raio e devolve o perímetro (circunferência) do círculo.
perimetro :: Double -> Double
perimetro r = 2 * pi * r

-- area recebe o raio e devolve a área do círculo.
area :: Double -> Double
area r = pi * r ^ 2

-- areaDaSuperficie recebe o raio e devolve a área da superfície de uma esfera.
-- Interpretação complementar: a ficha não explicita a fórmula.
areaDaSuperficie :: Double -> Double
areaDaSuperficie r = 4 * pi * r ^ 2

-- volume recebe o raio e devolve o volume de uma esfera.
-- Interpretação complementar: a ficha não explicita a fórmula.
volume :: Double -> Double
volume r = (4 / 3) * pi * r ^ 3
