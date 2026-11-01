-- Funções de ordem superior, map e filter
-- Carregar no GHCi: :load mapfilter.hs


-- Dobrar os elementos de uma lista usando recursão.
dobrar :: Num a => [a] -> [a]
-- Num a permite multiplicar os valores por 2.
dobrar [] = []                       -- Caso base: lista vazia.
dobrar (x:xs) = (2 * x) : dobrar xs   -- Dobra x e continua no resto.


aplica :: (a -> b) -> a -> b
-- Recebe uma função de a para b e um valor de tipo a; devolve um b.
aplica f x = f x                     -- Aplica a função f ao valor x.
-- Exemplo: aplica (+3) 4 = 7
-- Exemplo: aplica even 4 = True


-- map já pertence ao Prelude e está disponível por omissão no GHCi.
-- map :: (a -> b) -> [a] -> [b]
-- Recebe uma função e uma lista; transforma cada elemento.
-- Pode mudar o tipo dos elementos, mas mantém a ordem e o comprimento.
-- Exemplo: map (*2) [1,2,3] = [2,4,6]
-- Exemplo: map even [1,2,3] = [False,True,False]

-- Implementação didática, comentada para não redefinir map:
-- map _ [] = []
-- map f (x:xs) = f x : map f xs


-- filter também pertence ao Prelude e já está disponível no GHCi.
-- filter :: (a -> Bool) -> [a] -> [a]
-- Recebe um predicado e uma lista; conserva os elementos que dão True.
-- Mantém a ordem e o tipo dos elementos, mas pode reduzir o comprimento.
-- Exemplo: filter even [1,2,3,4] = [2,4]

-- Implementação didática, comentada para não redefinir filter:
-- filter _ [] = []
-- filter p (x:xs)
--     | p x       = x : filter p xs  -- Conserva x se passar no teste.
--     | otherwise = filter p xs      -- Caso contrário, ignora x.


positivos :: (Num a, Ord a) => [a] -> [a]
-- Recebe números e devolve apenas os maiores que zero.
-- Num a permite usar 0; Ord a permite comparar com >.
positivos = filter (>0)
-- (>0) testa se cada elemento é positivo. O zero fica de fora.
-- Exemplo: positivos [-3,4,0,-2,7] = [4,7]


quadrado :: Num a => a -> a
-- Recebe um número e devolve o seu quadrado.
quadrado x = x * x
-- Equivale à lambda: \x -> x * x
-- \ inicia a função anónima; x é o parâmetro; x * x é o corpo.


quadrados :: Num a => [a] -> [a]
-- Recebe uma lista de números e devolve os seus quadrados.
quadrados = map (\x -> x * x)
-- map aplica a lambda a cada elemento da lista.
-- Exemplo: quadrados [-3,0,2,5] = [9,0,4,25]
-- Alternativas: quadrados = map quadrado
--               quadrados = map (^2)


-- EXERCÍCIOS AUTÓNOMOS


duplicar :: Num a => [a] -> [a]
-- Recebe números e devolve o dobro de cada elemento, usando map.
duplicar = map (*2)
-- Tem o mesmo resultado de dobrar, sem escrever a recursão.
-- Exemplo: duplicar [1,2,3] = [2,4,6]


celsiusParaFahrenheit :: Fractional a => [a] -> [a]
-- Recebe temperaturas em Celsius e devolve-as em Fahrenheit.
-- Fractional a permite a divisão com / (por exemplo, Float ou Double).
celsiusParaFahrenheit = map (\c -> c * 9 / 5 + 32)
-- A lambda converte cada temperatura c pela fórmula F = C * 9 / 5 + 32.
-- Exemplo: celsiusParaFahrenheit [0,100,-40] = [32.0,212.0,-40.0]


-- O exercício positivos usa a função já definida acima.
-- Não é necessário voltar a defini-la.


notasAprovadas :: (Num a, Ord a) => [a] -> [a]
-- Recebe notas e devolve apenas as que são iguais ou superiores a 10.
-- Num a permite usar 10; Ord a permite comparar com >=.
notasAprovadas = filter (>=10)
-- A nota 10 é incluída no resultado.
-- Exemplo: notasAprovadas [8,10,15,9,20] = [10,15,20]


quadradosPares :: Integral a => [a] -> [a]
-- Recebe inteiros e devolve os quadrados dos elementos pares.
-- Integral a permite testar a paridade com even.
quadradosPares xs = map (\x -> x * x) (filter even xs)
-- filter even xs seleciona os pares; map calcula os seus quadrados.
-- Exemplo: [-3,-2,0,4,5] -> [-2,0,4] -> [4,0,16]
-- Zero e os inteiros negativos também podem ser pares.


-- Casos limite: todas as funções de listas acima devolvem [] para [].
-- positivos [0,-1] = []
-- notasAprovadas [5,9] = []
-- quadradosPares [1,3,5] = []
