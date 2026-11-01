-- ficha2_5a10.hs
-- Programação Funcional em Haskell
-- Ficha PL2 — Soluções comentadas das Tarefas 5 a 10
--
-- Continuação de ficha2_1a4.hs: assinaturas, explicações, avaliações
-- e exemplos para experimentar no GHCi.
--
-- Carregar: :load ficha2_5a10.hs
-- Ver tipos: :t nomeDaFuncao
--
-- Organização:
--   Tarefa 5  -> definições locais: let ... in e where
--   Tarefa 6  -> padrões sobre listas; take e sum
--   Tarefa 7  -> padrões sobre listas; funções parciais
--   Tarefa 8  -> recursão explícita sobre listas
--   Tarefa 9  -> comprimento e soma numa única travessia
--   Tarefa 10 -> dividir, separar e comparar com a média


------------------------------------------------------------
-- TAREFA 5
-- Definições locais com let ... in e where
------------------------------------------------------------

-- Tarefa 5.1
-- Função 'exemplo' apresentada na ficha.
--
-- 'where' define c, a, b e f para toda a equação.
-- 'let ... in' define k e g apenas para a expressão após 'in'.
-- A função g recebe um triplo e escolhe a operação pelo primeiro valor.

exemplo :: Int -> (Int, Int)
exemplo y = let k = 100
                g (1,w,z) = w + z
                g (2,w,z) = w - z
                g (_,_,_) = k
            in (f y + f a + f b, g (y,k,c))
    where c = 10
          (a,b) = (3*c, f 2)
          f x = x + 7*c

-- Nota: c = 10; f x = x + 70; a = 30; b = f 2 = 72.
-- Portanto, a primeira componente é:
--   f y + f a + f b = (y+70) + 100 + 142 = y + 312.
-- A segunda componente depende do primeiro valor de y:
--   y == 1  -> g (1,100,10) = 110
--   y == 2  -> g (2,100,10) = 90
--   outros  -> g (y,100,10) = 100
--
-- No GHCi:
-- > exemplo 1
-- (313,110)
-- > exemplo 2
-- (314,90)
-- > exemplo 3
-- (315,100)
--
-- Pergunta para os alunos:
-- Porque podemos usar f, c e a dentro da expressão 'let ... in'?
-- R.: Porque estão definidos no 'where' da mesma equação.


-- Tarefa 5.2
-- Calcular as duas raízes reais de ax^2 + bx + c = 0.
-- A assinatura e a ideia da definição com where vêm da ficha.
-- 'd' é o discriminante; 'r' é a sua raiz quadrada.

raizes :: (Double, Double, Double) -> (Double, Double)
raizes (a,b,c) = (r1,r2)
    where r1 = (-b + r) / (2*a)
          r2 = (-b - r) / (2*a)
          d = b^2 - 4*a*c
          r | d >= 0 = sqrt d
            | otherwise = error "raizes imaginarias"

-- Esta versão tem limitações: exige a /= 0 e d >= 0.
-- O enunciado fornece a definição e pede outras versões.
-- Apresentamos uma versão equivalente com let ... in.

raizesLet :: (Double, Double, Double) -> (Double, Double)
raizesLet (a,b,c) =
    let d = b^2 - 4*a*c
        r = if d >= 0 then sqrt d else error "raizes imaginarias"
        r1 = (-b + r) / (2*a)
        r2 = (-b - r) / (2*a)
    in (r1,r2)

-- E uma versão sem guardas, com if ... then ... else.

raizesIf :: (Double, Double, Double) -> (Double, Double)
raizesIf (a,b,c) =
    if d >= 0
        then ((-b + sqrt d)/(2*a), (-b - sqrt d)/(2*a))
        else error "raizes imaginarias"
    where d = b^2 - 4*a*c

-- No GHCi:
-- > raizes (1,-3,2)
-- (2.0,1.0)
-- > raizesLet (1,-3,2)
-- (2.0,1.0)
-- > raizesIf (1,-3,2)
-- (2.0,1.0)
--
-- Atenção: se a == 0, já não temos uma equação de 2.º grau.
-- As versões acima reproduzem o domínio implícito do exercício:
-- não fazem validação desse caso.


------------------------------------------------------------
-- TAREFA 6
-- Padrões sobre listas
------------------------------------------------------------

-- Tarefa 6.1
-- Na ficha: vazia [] = True; vazia (x:xs) = False.
-- Uma definição alternativa é usar um padrão geral '_'.
-- O '_' ignora o conteúdo da lista não vazia.

vazia :: [a] -> Bool
vazia [] = True
vazia _ = False

-- No GHCi:
-- > vazia []
-- True
-- > vazia [1,2,3]
-- False


-- Tarefa 6.2
-- Somar apenas os primeiros três elementos de uma lista.
-- Se houver menos de três, somar todos os existentes.
-- O padrão mais específico (três elementos ou mais) aparece primeiro.

soma3 :: [Integer] -> Integer
soma3 [] = 0
soma3 (x:y:z:t) = x + y + z
soma3 (x:y:t) = x + y
soma3 (x:t) = x

-- Avaliação:
-- soma3 [2,4,6,8]
-- -> 2 + 4 + 6
-- -> 12
--
-- No GHCi:
-- > soma3 []
-- 0
-- > soma3 [5]
-- 5
-- > soma3 [5,7]
-- 12
-- > soma3 [5,7,9,100]
-- 21
--
-- A ordem das cláusulas é importante!
-- Se colocarmos (x:t) antes de (x:y:z:t), ela corresponde
-- também a listas grandes; assim o programa devolveria apenas x.
--
-- Versão solicitada usando apenas as funções predefinidas take e sum.
-- 'take 3 xs' seleciona os primeiros três elementos (ou menos).
-- 'sum' calcula a soma dessa lista.

soma3Take :: [Integer] -> Integer
soma3Take xs = sum (take 3 xs)

-- No GHCi:
-- > soma3Take [5,7,9,100]
-- 21
-- > soma3Take []
-- 0


------------------------------------------------------------
-- TAREFA 7
-- Transformações de listas e funções parciais
------------------------------------------------------------

-- Tarefa 7.1
-- Se a lista tiver pelo menos quatro elementos, trocar:
--   - o primeiro com o segundo;
--   - o penúltimo com o último.
-- Caso contrário, devolver a lista original.
--
-- Usamos length para confirmar o tamanho e reverse para chegar
-- aos dois últimos elementos sem criar uma função recursiva auxiliar.

transf :: [a] -> [a]
transf xs
    | length xs < 4 = xs
    | otherwise = trocaUltimos (trocaPrimeiros xs)
    where trocaPrimeiros (a:b:resto) = b:a:resto
          trocaPrimeiros ys = ys
          trocaUltimos ys = reverse (trocaPrimeiros (reverse ys))

-- Exemplo:
-- transf [1,2,3,4,5,6,7]
-- -> trocaPrimeiros [1,2,3,4,5,6,7]
-- -> [2,1,3,4,5,6,7]
-- -> trocaUltimos [2,1,3,4,5,6,7]
-- -> [2,1,3,4,5,7,6]
--
-- No GHCi:
-- > transf [1,2,3,4,5,6,7]
-- [2,1,3,4,5,7,6]
-- > transf [1,2,3,4]
-- [2,1,4,3]
-- > transf [1,2,3]
-- [1,2,3]
-- > transf []
-- []
--
-- Esta função é total: cobre todas as listas finitas.
-- Nota: verificar length percorre a lista; esta solução privilegia
-- simplicidade, como sugerido na ficha.


-- Tarefa 7.2
-- Somar o segundo e o quarto par de uma lista de pares de Int.
-- A soma é feita componente a componente.
-- O padrão ignora o primeiro e o terceiro pares.
--
-- Exemplo: (2,3) + (5,7) = (7,10).

somaPares24 :: [(Int, Int)] -> (Int, Int)
somaPares24 (_:(a,b):_:(c,d):_) = (a+c,b+d)

-- No GHCi:
-- > somaPares24 [(1,1),(2,3),(4,4),(5,7)]
-- (7,10)
--
-- Atenção: esta função é PARCIAL.
-- Uma lista com menos de quatro pares não corresponde ao padrão,
-- e o GHCi apresenta um erro de padrões não exaustivos.
--
-- Alternativa TOTAL, com resultado Maybe:
-- Nothing = faltam pares; Just (x,y) = soma calculada.
-- Esta variante é complementar; Maybe é trabalhado mais adiante.

somaPares24Segura :: [(Int, Int)] -> Maybe (Int, Int)
somaPares24Segura (_:(a,b):_:(c,d):_) = Just (a+c,b+d)
somaPares24Segura _ = Nothing

-- No GHCi:
-- > somaPares24Segura [(1,1),(2,3),(4,4),(5,7)]
-- Just (7,10)
-- > somaPares24Segura [(1,1)]
-- Nothing


------------------------------------------------------------
-- TAREFA 8
-- Funções recursivas sobre listas
------------------------------------------------------------

-- Tarefa 8.1 (primeira função)
-- Produto de todos os números de uma lista.
-- Caso base: produto da lista vazia = 1 (elemento neutro de *).
-- Caso recursivo: multiplicar a cabeça pelo produto da cauda.

produtoLista :: Num a => [a] -> a
produtoLista [] = 1
produtoLista (x:xs) = x * produtoLista xs

-- produtoLista [2,3,4]
-- -> 2 * produtoLista [3,4]
-- -> 2 * (3 * produtoLista [4])
-- -> 2 * (3 * (4 * produtoLista []))
-- -> 2 * (3 * (4 * 1))
-- -> 24
--
-- No GHCi:
-- > produtoLista [2,3,4]
-- 24
-- > produtoLista []
-- 1


-- Tarefa 8.1 (segunda função)
-- Colocar um elemento NO FIM de uma lista.
-- Não podemos simplesmente fazer x:xs, porque (:) coloca no início.
-- Percorremos a lista até encontrarmos [].

acrescentaFim :: [a] -> a -> [a]
acrescentaFim [] x = [x]
acrescentaFim (y:ys) x = y : acrescentaFim ys x

-- acrescentaFim [1,2] 3
-- -> 1 : acrescentaFim [2] 3
-- -> 1 : 2 : acrescentaFim [] 3
-- -> 1 : 2 : [3]
-- -> [1,2,3]
--
-- No GHCi:
-- > acrescentaFim [1,2] 3
-- [1,2,3]
-- > acrescentaFim [] 3
-- [3]


-- Tarefa 8.1 (terceira função)
-- Concatenar duas listas: elementos da primeira, seguidos da segunda.
-- Percorremos apenas a primeira lista.

concatenaListas :: [a] -> [a] -> [a]
concatenaListas [] ys = ys
concatenaListas (x:xs) ys = x : concatenaListas xs ys

-- concatenaListas [1,2] [3,4]
-- -> 1 : concatenaListas [2] [3,4]
-- -> 1 : 2 : concatenaListas [] [3,4]
-- -> 1 : 2 : [3,4]
-- -> [1,2,3,4]
--
-- No GHCi:
-- > concatenaListas [1,2] [3,4]
-- [1,2,3,4]
-- > concatenaListas [] [3,4]
-- [3,4]
-- > concatenaListas [1,2] []
-- [1,2]
--
-- A função predefinida (++) faz esta concatenação.


------------------------------------------------------------
-- TAREFA 9
-- Comprimento e soma numa única travessia
------------------------------------------------------------

-- Tarefa 9.1
-- Devolver um par (quantidade de elementos, soma dos elementos).
-- Com pattern matching e recursão percorremos a lista uma vez.
--
-- (Int, a) representa:
--   Int -> quantidade de elementos;
--   a   -> soma, do mesmo tipo numérico dos elementos.

comprimentoSoma :: Num a => [a] -> (Int, a)
comprimentoSoma [] = (0,0)
comprimentoSoma (x:xs) = (n+1,s+x)
    where (n,s) = comprimentoSoma xs

-- comprimentoSoma [2,4,6]
-- -> comprimentoSoma [4,6] = (2,10)
-- -> (2+1,10+2)
-- -> (3,12)
--
-- No GHCi:
-- > comprimentoSoma [2,4,6]
-- (3,12)
-- > comprimentoSoma []
-- (0,0)


-- Tarefa 9.2
-- Usar a função anterior para calcular a média.
-- fromIntegral converte um Int para o tipo numérico necessário
-- para fazer a divisão (/).
-- A média não está definida para listas vazias: indicamos isso.

mediaLista :: Fractional a => [a] -> a
mediaLista [] = error "media de lista vazia"
mediaLista xs = s / fromIntegral n
    where (n,s) = comprimentoSoma xs

-- No GHCi:
-- > mediaLista [10,12,14]
-- 12.0
-- > mediaLista [2,4]
-- 3.0
-- > mediaLista []
-- *** Exception: media de lista vazia
--
-- Embora o cálculo da média seja parcial no caso vazio,
-- comprimentoSoma é total para listas finitas.


------------------------------------------------------------
-- TAREFA 10
-- Divisão de listas, partição por valor e média
------------------------------------------------------------

-- Tarefa 10.1
-- Dividir uma lista em duas metades de tamanho igual, ou quase
-- igual se o comprimento da lista for ímpar.
-- Usamos div para obter um comprimento inteiro e splitAt para
-- separar a lista nessa posição.

metades :: [a] -> ([a],[a])
metades xs = splitAt (length xs `div` 2) xs

-- No GHCi:
-- > metades [1,2,3,4,5,6]
-- ([1,2,3],[4,5,6])
-- > metades [1,2,3,4,5]
-- ([1,2],[3,4,5])
-- > metades []
-- ([],[])
--
-- Alternativa com take e drop, mostrando as duas metades:

metadesTakeDrop :: [a] -> ([a],[a])
metadesTakeDrop xs = (take n xs,drop n xs)
    where n = length xs `div` 2


-- Tarefa 10.2
-- Separar os elementos relativamente a um valor de referência.
-- Primeira lista: valores estritamente inferiores ao limite.
-- Segunda lista: os restantes, incluindo os iguais ao limite.
--
-- Esta solução usa recursão explícita e guardas.

separar :: Ord a => [a] -> a -> ([a],[a])
separar [] _ = ([],[])
separar (x:xs) limite
    | x < limite = (x:menores,restantes)
    | otherwise  = (menores,x:restantes)
    where (menores,restantes) = separar xs limite

-- separar [1,5,2,8,3] 4
-- -> ([1,2,3],[5,8])
--
-- No GHCi:
-- > separar [1,5,2,8,3] 4
-- ([1,2,3],[5,8])
-- > separar [4,4,2,5] 4
-- ([2],[4,4,5])
-- > separar [] 4
-- ([],[])
--
-- ADAPTAÇÃO PARA A AULA 6 (funções de ordem superior):
-- A ficha não exige filter. Esta é uma segunda implementação
-- para relacionar o exercício com a matéria de map/filter.

separarFilter :: Ord a => [a] -> a -> ([a],[a])
separarFilter xs limite = (filter (<limite) xs,filter (>=limite) xs)


-- Tarefa 10.3
-- Obter todos os elementos superiores à média da lista.
-- Primeiro calculamos a média; depois selecionamos os elementos.
-- Esta implementação usa recursão explícita para a seleção.

superioresMedia :: (Fractional a, Ord a) => [a] -> [a]
superioresMedia [] = []
superioresMedia xs = seleciona media xs
    where media = mediaLista xs
          seleciona _ [] = []
          seleciona m (y:ys)
              | y > m     = y : seleciona m ys
              | otherwise = seleciona m ys

-- No GHCi:
-- > superioresMedia [2,4,6,8]
-- [6.0,8.0]
-- > superioresMedia [5,5,5]
-- []
-- > superioresMedia []
-- []
--
-- ADAPTAÇÃO PARA A AULA 6:
-- filter substitui a função recursiva auxiliar 'seleciona'.

superioresMediaFilter :: (Fractional a, Ord a) => [a] -> [a]
superioresMediaFilter [] = []
superioresMediaFilter xs = filter (>mediaLista xs) xs


------------------------------------------------------------
-- RESUMO
------------------------------------------------------------
-- Tarefa 5: let ... in e where; âmbito de definições locais.
-- Tarefa 6: padrões de listas e importância da ordem das cláusulas.
-- Tarefa 7: transformações de listas; totalidade e parcialidade.
-- Tarefa 8: produto, acrescentar ao fim e concatenação por recursão.
-- Tarefa 9: calcular simultaneamente comprimento e soma; média.
-- Tarefa 10: dividir em metades, separar por limite, filtrar pela média.
--
-- Sugestões para a aula:
-- 1. Pedir que os alunos expliquem assinaturas de tipos.
-- 2. Identificar caso base e caso recursivo nas Tarefas 8 e 9.
-- 3. Comparar separar/separarFilter e superioresMedia/superioresMediaFilter.
-- 4. Discutir casos limite, sobretudo listas vazias e funções parciais.
