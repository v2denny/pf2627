module Ficha1 where

-- (1)
-- Recebe dois pares de inteiros.
-- Soma os primeiros elementos e multiplica os segundos.
combinaPares :: (Int, Int) -> (Int, Int) -> (Int, Int)
combinaPares (a, b) (c, d) = (a + c, b * d)


-- (2)
-- Recebe três inteiros.
-- Devolve (maior, segundoMaior).
maiorESegundo :: Int -> Int -> Int -> (Int, Int)
maiorESegundo x y z
    | x >= y && y >= z = (x, y)
    | x >= z && z >= y = (x, z)
    | y >= x && x >= z = (y, x)
    | y >= z && z >= x = (y, z)
    | z >= x && x >= y = (z, x)
    | otherwise        = (z, y)


-- (3)
-- Recebe um triplo de inteiros e devolve-o por ordem decrescente.
ordenaTriplo :: (Int, Int, Int) -> (Int, Int, Int)
ordenaTriplo (x, y, z)
    | x >= y && y >= z = (x, y, z)
    | x >= z && z >= y = (x, z, y)
    | y >= x && x >= z = (y, x, z)
    | y >= z && z >= x = (y, z, x)
    | z >= x && x >= y = (z, x, y)
    | otherwise        = (z, y, x)


-- (4)
-- Verifica se três comprimentos podem ser os lados de um triângulo.
-- Além das desigualdades do triângulo, exigimos comprimentos positivos.
formaTriangulo :: Double -> Double -> Double -> Bool
formaTriangulo a b c =
    a > 0 && b > 0 && c > 0 &&
    a + b > c &&
    a + c > b &&
    b + c > a


-- (5)
-- Recebe um nome completo e devolve primeiro nome + apelido.
-- Assume que a String contém pelo menos uma palavra.
abrev :: String -> String
abrev nome =
    let nomes = words nome
    in unwords [head nomes, last nomes]
