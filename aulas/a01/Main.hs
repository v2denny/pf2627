module Main where

data Aluno = Aluno
    { nome :: String
    , nota :: Double
    }
    deriving Show

parseAluno :: String -> Aluno
parseAluno linha =
    let (n, resto) = break (== ';') linha
        valorNota  = read (tail resto) :: Double
    in Aluno n valorNota

aprovados :: [Aluno] -> [Aluno]
aprovados =
    filter (\a -> nota a > 10)

melhorNota :: [Aluno] -> Double
melhorNota alunos =
    maximum (map nota alunos)

piorNota :: [Aluno] -> Double
piorNota alunos =
    minimum (map nota alunos)

mediaTurma :: [Aluno] -> Double
mediaTurma alunos =
    sum (map nota alunos)
        / fromIntegral (length alunos)

mostraAluno :: Aluno -> String
mostraAluno a =
    nome a ++ " - " ++ show (nota a)

main :: IO ()
main = do
    conteudo <- readFile "alunos.txt"

    let alunos =
            map parseAluno (lines conteudo)

    putStrLn "=== RESULTADOS DA TURMA ==="

    putStrLn "\nAlunos aprovados:"
    mapM_ (putStrLn . mostraAluno) (aprovados alunos)

    putStrLn "\nEstatisticas:"
    putStrLn ("Melhor nota: " ++ show (melhorNota alunos))
    putStrLn ("Pior nota:   " ++ show (piorNota alunos))
    putStrLn ("Media:       " ++ show (mediaTurma alunos))
