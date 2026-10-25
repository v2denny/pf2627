-- ficha2_1a4.hs
-- Programação Funcional em Haskell
-- Ficha PL2 — Soluções das Tarefas 1 a 4
--
-- Este ficheiro segue a ordem e os conceitos da Ficha nº 2:
--   Tarefa 1 -> múltiplas cláusulas e pattern matching
--   Tarefa 2 -> reescrever uma função com pattern matching
--   Tarefa 3 -> guards e factorial
--   Tarefa 4 -> Fibonacci com guards


------------------------------------------------------------
-- TAREFA 1
-- Funções com múltiplas cláusulas e pattern matching
------------------------------------------------------------

f :: (Int, Char, Int) -> Int

f (y, 'a', x) = y + x
-- Esta cláusula é usada quando o segundo elemento do triplo é 'a'.

f (z, 'b', x) = z * x
-- Esta cláusula é usada quando o segundo elemento do triplo é 'b'.

f (x, y, z) = x
-- Esta é a cláusula mais geral.
-- Aceita qualquer triplo do tipo (Int, Char, Int).
-- Por isso deve aparecer depois das cláusulas mais específicas.


-- Tarefa 1.1
--
-- Avaliar:
--
-- f (3,'a',5)
--
-- A primeira cláusula corresponde:
--   y = 3
--   x = 5
--
-- Resultado:
--   3 + 5 = 8
--
-- No GHCi:
-- > f (3,'a',5)
-- 8


-- f (9,'B',0)
--
-- A primeira cláusula não corresponde, porque 'B' /= 'a'.
-- A segunda também não corresponde, porque 'B' /= 'b'.
-- É usada a terceira cláusula:
--
--   f (x,y,z) = x
--
-- Logo:
--   x = 9
--
-- Resultado:
--   9
--
-- No GHCi:
-- > f (9,'B',0)
-- 9


-- f (5,'b',4)
--
-- A primeira cláusula não corresponde.
-- A segunda cláusula corresponde:
--   z = 5
--   x = 4
--
-- Resultado:
--   5 * 4 = 20
--
-- No GHCi:
-- > f (5,'b',4)
-- 20


-- Tarefa 1.2
--
-- A ordem das equações é importante.
--
-- Haskell procura, de cima para baixo, a PRIMEIRA cláusula
-- cujo padrão corresponde ao argumento.
--
-- Se colocássemos a cláusula geral:
--
--   f (x,y,z) = x
--
-- em primeiro lugar, ela corresponderia a todos os triplos.
-- As cláusulas para 'a' e 'b' nunca chegariam a ser usadas.
--
-- Exemplo de uma ordem problemática:
--
-- f (x,y,z) = x
-- f (y,'a',x) = y+x
-- f (z,'b',x) = z*x
--
-- Assim:
-- f (3,'a',5)
-- devolveria 3, em vez de 8.


------------------------------------------------------------
-- TAREFA 2
-- Reescrever opp usando pattern matching
------------------------------------------------------------

-- Versão dada na ficha:

opp :: (Int, (Int, Int)) -> Int
opp z =
    if fst z == 1
        then fst (snd z) + snd (snd z)
        else if fst z == 2
            then fst (snd z) - snd (snd z)
            else 0


-- Tarefa 2.2
--
-- Avaliar:
--
-- opp (1,(2,3))
--
-- fst (1,(2,3)) = 1
--
-- Como 1 == 1, usamos o primeiro ramo:
--
-- fst (2,3) + snd (2,3)
-- = 2 + 3
-- = 5
--
-- No GHCi:
-- > opp (1,(2,3))
-- 5


-- Tarefa 2.3
-- Versão usando pattern matching.

oppPattern :: (Int, (Int, Int)) -> Int

oppPattern (1, (x, y)) = x + y
-- Se o primeiro valor for 1, soma os dois valores interiores.

oppPattern (2, (x, y)) = x - y
-- Se o primeiro valor for 2, subtrai os dois valores interiores.

oppPattern _ = 0
-- Qualquer outro padrão devolve 0.
-- O _ significa que não precisamos de saber quais são os valores.


-- Exemplos:
--
-- > oppPattern (1,(2,3))
-- 5
--
-- > oppPattern (2,(10,4))
-- 6
--
-- > oppPattern (7,(10,4))
-- 0
--
-- Esta versão é mais direta porque usamos a própria estrutura
-- do argumento para separar os casos.
-- Evitamos várias chamadas a fst e snd.


------------------------------------------------------------
-- TAREFA 3
-- Guards e factorial
------------------------------------------------------------

-- Tarefa 3.1
-- Nova versão de opp usando guards.

oppGuardas :: (Int, (Int, Int)) -> Int
oppGuardas (op, (x, y))
    | op == 1   = x + y
    | op == 2   = x - y
    | otherwise = 0

-- Aqui usamos pattern matching para decompor o triplo
-- e guards para decidir qual operação realizar.
--
-- op == 1    -> soma
-- op == 2    -> subtração
-- otherwise  -> qualquer outro caso


-- Exemplos:
--
-- > oppGuardas (1,(2,3))
-- 5
--
-- > oppGuardas (2,(10,4))
-- 6
--
-- > oppGuardas (9,(10,4))
-- 0


------------------------------------------------------------
-- Factorial
------------------------------------------------------------

-- Versão apresentada na ficha:

fact :: Int -> Int
fact 0 = 1
fact n = n * fact (n - 1)

-- Esta definição funciona corretamente para números naturais.
--
-- Exemplo:
--
-- fact 4
-- = 4 * fact 3
-- = 4 * 3 * fact 2
-- = 4 * 3 * 2 * fact 1
-- = 4 * 3 * 2 * 1 * fact 0
-- = 4 * 3 * 2 * 1 * 1
-- = 24


-- Tarefa 3.3
--
-- O que acontece com um número negativo?
--
-- Exemplo:
--
-- fact (-1)
-- = (-1) * fact (-2)
-- = (-1) * (-2) * fact (-3)
-- = ...
--
-- O argumento vai ficando cada vez mais negativo.
-- Nunca chega ao caso base:
--
--   fact 0 = 1
--
-- Portanto, a recursão não termina.


-- Tarefa 3.4
-- Versão com guards que trata explicitamente os negativos.
--
-- A ficha pede uma guarda para evitar o comportamento anterior.
-- Aqui escolhemos usar error para indicar que o factorial
-- não está definido, neste exercício, para números negativos.

factGuardas :: Int -> Int
factGuardas n
    | n < 0     = error "factorial nao definido para numeros negativos"
    | n == 0    = 1
    | otherwise = n * factGuardas (n - 1)

-- Guards:
--
-- n < 0
--   -> impede que a função entre numa recursão infinita.
--
-- n == 0
--   -> caso base.
--
-- otherwise
--   -> caso recursivo para valores positivos.


-- Exemplos:
--
-- > factGuardas 0
-- 1
--
-- > factGuardas 5
-- 120
--
-- > factGuardas (-2)
-- *** Exception: factorial nao definido para numeros negativos


------------------------------------------------------------
-- TAREFA 4
-- Fibonacci usando guards
------------------------------------------------------------

-- Definição matemática apresentada na ficha:
--
-- fib(0) = 0
-- fib(1) = 1
-- fib(n) = fib(n-2) + fib(n-1), para n >= 2


fib :: Int -> Int
fib n
    | n < 0     = error "Fibonacci nao definido para indices negativos"
    | n == 0    = 0
    | n == 1    = 1
    | otherwise = fib (n - 2) + fib (n - 1)

-- Casos base:
--
-- fib 0 = 0
-- fib 1 = 1
--
-- Caso recursivo:
--
-- fib n = fib (n-2) + fib (n-1)
--
-- Cada chamada calcula o resultado usando dois problemas menores.


-- Exemplo: fib 4
--
-- fib 4
-- = fib 2 + fib 3
--
-- fib 2
-- = fib 0 + fib 1
-- = 0 + 1
-- = 1
--
-- fib 3
-- = fib 1 + fib 2
-- = 1 + 1
-- = 2
--
-- Logo:
--
-- fib 4
-- = 1 + 2
-- = 3


-- Alguns testes no GHCi:
--
-- > fib 0
-- 0
--
-- > fib 1
-- 1
--
-- > fib 2
-- 1
--
-- > fib 3
-- 2
--
-- > fib 4
-- 3
--
-- > fib 5
-- 5
--
-- > fib 6
-- 8


------------------------------------------------------------
-- RESUMO
------------------------------------------------------------

-- Tarefa 1:
--   múltiplas cláusulas + ordem do pattern matching.
--
-- Tarefa 2:
--   substituir fst/snd e ifs por pattern matching.
--
-- Tarefa 3:
--   guards + análise do domínio de uma função recursiva.
--
-- Tarefa 4:
--   definição de Fibonacci com casos base e caso recursivo.
--
-- Ideia importante:
-- em funções com várias cláusulas ou guards,
-- a ordem em que os casos são escritos pode ser relevante.
