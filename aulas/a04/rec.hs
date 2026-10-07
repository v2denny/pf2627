fatorial :: Int -> Int
fatorial 0 = 1
fatorial n = n * fatorial (n - 1)


soma :: [Int] -> Int
soma [] = 0
soma (x:xs) = x + soma xs


comprimento :: [a] -> Int
comprimento [] = 0
comprimento (_:xs) = 1 + comprimento xs


produto :: [Int] -> Int
produto [] = 1
produto (x:xs) = x * produto xs


duplica :: [Int] -> [Int]   
-- duplica recebe uma lista de Int e devolve uma lista de Int.

duplica [] = []              
-- Caso base: duplicar os elementos de uma lista vazia dá uma lista vazia.

duplica (x:xs) = (2 * x) : duplica xs
-- Caso recursivo:
-- x é o primeiro elemento da lista e xs é o resto da lista.
-- Multiplicamos x por 2.
-- Depois usamos : para colocar esse valor à frente da lista resultante de duplica xs.
-- A chamada duplica xs trata recursivamente o resto da lista.


contaPositivos :: [Int] -> Int
-- contaPositivos recebe uma lista de Int e devolve um Int,
-- correspondente ao número de elementos positivos da lista.

contaPositivos [] = 0
-- Caso base: numa lista vazia existem 0 elementos positivos.

contaPositivos (x:xs)
    | x > 0     = 1 + contaPositivos xs
    -- Se o primeiro elemento x for positivo, contamos 1
    -- e continuamos a contar os positivos no resto da lista xs.

    | otherwise = contaPositivos xs
    -- Caso contrário, não contamos x
    -- e continuamos apenas com o resto da lista.


todosPositivos :: [Int] -> Bool
todosPositivos [] = True
todosPositivos (x:xs)
    | x > 0     = todosPositivos xs
    | otherwise = False


existeZero :: [Int] -> Bool
-- existeZero recebe uma lista de Int e devolve um Bool:
-- True se existir pelo menos um zero e False caso contrário.

existeZero [] = False
-- Caso base: numa lista vazia não existe nenhum zero.

existeZero (x:xs)
    | x == 0    = True
    -- Se o primeiro elemento x for 0, já encontrámos um zero,
    -- por isso podemos devolver imediatamente True.

    | otherwise = existeZero xs
    -- Caso contrário, procuramos um zero recursivamente
    -- no resto da lista xs.


replica :: Int -> a -> [a]
-- replica recebe um Int e um valor de qualquer tipo a,
-- e devolve uma lista de valores desse mesmo tipo.

replica 0 _ = []
-- Caso base: se quisermos repetir o valor 0 vezes,
-- o resultado é uma lista vazia.
-- O _ significa que o valor recebido não é utilizado neste caso.

replica n x = x : replica (n - 1) x
-- Caso recursivo:
-- x é o valor que queremos repetir.
-- : coloca x à frente da lista resultante.
-- replica (n - 1) x trata recursivamente das restantes repetições.
-- Em cada chamada, n diminui 1 até chegar ao caso base n = 0.