-- Reverter uma lista sem acumulador (explicado nos slides)
reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]



-- Reverter uma lista com acumulador (explicado nos slides)
reverseAcc :: [a] -> [a]
reverseAcc [] = []                  -- reverse de uma lista vazia é lista vazia
reverseAcc lista = aux lista []     -- caso contrario usamos a função auxiliar aux
  where
    aux [] acumulado = acumulado                    -- caso base
    aux (x:xs) acumulado = aux xs (x:acumulado)     -- caso recursivo



pertence :: Eq a => a -> [a] -> Bool
-- pertence recebe um valor de tipo a e uma lista de valores do mesmo tipo.
-- Devolve True se o valor existir na lista e False caso contrário.
-- Eq a => significa que os valores de tipo a têm de poder ser comparados com ==.

pertence _ [] = False
-- Caso base:
-- numa lista vazia não existe nenhum elemento.
-- O _ representa o valor procurado, que não precisamos de usar aqui.

pertence valor (x:xs)
    | valor == x = True
    -- Se o valor procurado for igual ao primeiro elemento x,
    -- já encontrámos o elemento e podemos devolver True.

    | otherwise  = pertence valor xs
    -- Caso contrário, procuramos recursivamente no resto da lista xs.
    -- O problema diminui porque xs tem menos um elemento.



-- Versão alternativa, usando || em vez de guards.
pertence2 :: Eq a => a -> [a] -> Bool
pertence2 _ [] = False
pertence2 valor (x:xs) = (valor == x) || pertence2 valor xs
-- A expressão fica True se valor == x
-- OU se o valor pertencer ao resto da lista.



removePrimeiro :: Eq a => a -> [a] -> [a]
-- removePrimeiro recebe um valor e uma lista.
-- Devolve a lista depois de remover apenas a primeira ocorrência desse valor.

removePrimeiro _ [] = []
-- Caso base:
-- se a lista estiver vazia, não há nada para remover.

removePrimeiro valor (x:xs)
    | valor == x = xs
    -- Se x for o valor que queremos remover,
    -- devolvemos diretamente xs.
    -- Não fazemos outra chamada recursiva aqui:
    -- assim removemos APENAS a primeira ocorrência.

    | otherwise = x : removePrimeiro valor xs
    -- Se x não for o valor procurado, mantemos x no resultado
    -- e tentamos remover o valor no resto da lista xs.



-- Versão alternativa usando if/then/else.
removePrimeiro2 :: Eq a => a -> [a] -> [a]
removePrimeiro2 _ [] = []
removePrimeiro2 valor (x:xs) =
    if valor == x
        then xs
        else x : removePrimeiro2 valor xs



contaOcorrencias :: Eq a => a -> [a] -> Int
-- contaOcorrencias recebe um valor e uma lista.
-- Devolve o número de vezes que esse valor aparece na lista.

contaOcorrencias _ [] = 0
-- Caso base:
-- numa lista vazia existem 0 ocorrências.

contaOcorrencias valor (x:xs)
    | valor == x = 1 + contaOcorrencias valor xs
    -- Se x for igual ao valor procurado,
    -- contamos esta ocorrência (+1)
    -- e continuamos a procurar no resto da lista.

    | otherwise  = contaOcorrencias valor xs
    -- Se x for diferente, não contamos nada
    -- e continuamos no resto da lista.



-- Versão alternativa usando if/then/else.
contaOcorrencias2 :: Eq a => a -> [a] -> Int
contaOcorrencias2 _ [] = 0
contaOcorrencias2 valor (x:xs) =
    if valor == x
        then 1 + contaOcorrencias2 valor xs
        else contaOcorrencias2 valor xs



-- DESAFIO:
quicksort :: Ord a => [a] -> [a]
-- quicksort recebe uma lista de elementos ordenáveis
-- e devolve essa lista ordenada por ordem crescente.

quicksort [] = []
-- Caso base:
-- uma lista vazia já está ordenada.

quicksort (x:xs) =
    quicksort menores ++ [x] ++ quicksort maiores
  where
    menores = [y | y <- xs, y <= x]
    -- menores contém todos os elementos do resto da lista
    -- que são menores ou iguais ao pivô x.

    maiores = [y | y <- xs, y > x]
    -- maiores contém todos os elementos do resto da lista
    -- que são maiores do que o pivô x.