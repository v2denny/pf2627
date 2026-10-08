module MyMath where


-- Exponenciação com if/then/else

potencia :: Int -> Int -> Int
potencia x y =
    if y == 0
        then 1
        else x * potencia x (y - 1)


-- Fibonacci com if/then/else

fib :: Int -> Int
fib n =
    if n == 0
        then 0
        else
            if n == 1
                then 1
                else fib (n - 1) + fib (n - 2)


-- Factorial sem if/then/else

fact :: Int -> Int
fact 0 = 1
fact n = n * fact (n - 1)


-- Exponenciação sem if/then/else

potencia' :: Int -> Int -> Int
potencia' x 0 = 1
potencia' x y = x * potencia' x (y - 1)


-- Fibonacci sem if/then/else

fib' :: Int -> Int
fib' 0 = 0
fib' 1 = 1
fib' n = fib' (n - 1) + fib' (n - 2)


-- Distância percorrida por uma bola

bouncy :: Double -> Double -> Int -> Double
bouncy h b 0 = h
bouncy h b 1 = h + h * b
bouncy h b n = h + h * b + bouncy (h * b) b (n - 1)


-- Primeiro e último elemento

primeiroUltimo :: [a] -> (a, a)
primeiroUltimo xs = (head xs, last xs)


-- Comprimento implementado recursivamente

comprimento :: [a] -> Int
comprimento [] = 0
comprimento (_:xs) = 1 + comprimento xs


-- Lista e respetivo comprimento

listaComprimento :: [a] -> ([a], Int)
listaComprimento xs = (xs, comprimento xs)


-- Soma implementada recursivamente

soma :: [Double] -> Double
soma [] = 0
soma (x:xs) = x + soma xs


-- Média

media :: [Double] -> Double
media xs = soma xs / fromIntegral (comprimento xs)