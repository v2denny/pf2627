ultimoPar :: (a, b) -> b
-- ultimoPar recebe um par (a,b) e devolve o segundo elemento, do tipo b.

ultimoPar (_, y) = y
-- Usamos pattern matching para decompor o par.
-- O primeiro elemento é representado por _, porque não precisamos dele.
-- y representa o segundo elemento, que é devolvido como resultado.


troca :: (a, b) -> (b, a)
-- troca recebe um par (a,b) e devolve um novo par com os elementos trocados.

troca (x, y) = (y, x)
-- Usamos pattern matching para obter os dois elementos do par.
-- x representa o primeiro elemento e y representa o segundo.
-- O resultado é construído na ordem inversa: (y,x).


primeiro :: [a] -> a
-- primeiro recebe uma lista de elementos de qualquer tipo a
-- e devolve o primeiro elemento da lista.

primeiro (x:_) = x
-- (x:_) representa uma lista não vazia.
-- x é o primeiro elemento da lista.
-- _ representa o resto da lista, que não é necessário nesta função.
-- A função devolve simplesmente x.
--
-- Atenção: primeiro [] não está definido, porque uma lista vazia
-- não tem primeiro elemento.


segundoElemento :: [a] -> a
-- segundoElemento recebe uma lista de elementos de qualquer tipo a
-- e devolve o segundo elemento da lista.

segundoElemento (_:y:_) = y
-- O padrão (_:y:_) exige uma lista com pelo menos dois elementos.
-- O primeiro _ ignora o primeiro elemento.
-- y representa o segundo elemento.
-- O último _ representa o resto da lista, que não é necessário.
-- A função devolve y.
--
-- Exemplo:
-- segundoElemento [10,20,30]
-- y = 20
-- resultado = 20
--
-- Atenção: segundoElemento [] e segundoElemento [x] não estão definidos,
-- porque essas listas não têm um segundo elemento.


classificaIdade :: Int -> String
-- classificaIdade recebe uma idade representada por um Int
-- e devolve uma String com a classificação dessa idade.

classificaIdade idade
    | idade < 0  = "Idade invalida"
    -- Uma idade negativa é considerada inválida.

    | idade < 13 = "Crianca"
    -- Dos 0 aos 12 anos classificamos como criança.

    | idade < 18 = "Adolescente"
    -- Dos 13 aos 17 anos classificamos como adolescente.

    | idade < 65 = "Adulto"
    -- Dos 18 aos 64 anos classificamos como adulto.

    | otherwise  = "Idoso"
    -- otherwise significa "caso contrário".
    -- Portanto, a partir dos 65 anos classificamos como idoso.


sinal :: Int -> Int
-- sinal recebe um número inteiro e devolve:
--  1  se o número for positivo,
--  0  se o número for zero,
-- -1  se o número for negativo.

sinal n
    | n > 0     = 1
    -- Se n for maior do que zero, o número é positivo.

    | n == 0    = 0
    -- Se n for igual a zero, devolvemos 0.

    | otherwise = -1
    -- Caso contrário, n só pode ser negativo, por isso devolvemos -1.



descricaoLista :: [a] -> String
descricaoLista [] = "Lista vazia"
descricaoLista [_] = "Lista unitaria"
descricaoLista (_:_:_) = "Lista com pelo menos dois elementos"