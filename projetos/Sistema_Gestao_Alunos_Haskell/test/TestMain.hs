module Main where

import Domain
import Model
import Parsing

main :: IO ()
main = do
  putStrLn "Testes do Sistema de Gestão de Alunos e Avaliações"
  testFinalGrade
  testIncompleteGrade
  testParsing
  testInvalidGrade
  testResultStatus
  putStrLn "Todos os testes passaram."

testFinalGrade :: IO ()
testFinalGrade = do
  let evaluations =
        [ Evaluation 1 "PF" "TP" 10 0.4
        , Evaluation 1 "PF" "Exame" 20 0.6
        ]
  assertEqual "nota final ponderada" (Just 16.0) (finalGrade evaluations)

testIncompleteGrade :: IO ()
testIncompleteGrade = do
  let evaluations = [Evaluation 1 "PF" "TP" 15 0.5]
  assertEqual "avaliação incompleta" Nothing (finalGrade evaluations)

testParsing :: IO ()
testParsing = do
  let input = "id;nome;curso\n1;Ana Silva;Engenharia Informatica\n2;Bruno Costa;Ciencia de Dados\n"
  case parseStudents input of
    Left errors -> error (unlines errors)
    Right students -> assertEqual "parse de alunos" 2 (length students)

testInvalidGrade :: IO ()
testInvalidGrade = do
  let input = "aluno_id;uc;componente;nota;peso\n1;PF;Exame;25;1.0\n"
  case parseEvaluations input of
    Left _  -> putStrLn "[OK] nota inválida rejeitada"
    Right _ -> error "[FALHOU] nota inválida deveria ter sido rejeitada"

testResultStatus :: IO ()
testResultStatus = do
  let student = Student 1 "Ana" "EI"
  let evaluations = [Evaluation 1 "PF" "Exame" 14 1.0]
  assertEqual "estado aprovado" Approved (resultStatus (resultFor student "PF" evaluations))

assertEqual :: (Eq a, Show a) => String -> a -> a -> IO ()
assertEqual label expected actual
  | expected == actual = putStrLn ("[OK] " ++ label)
  | otherwise = error $ "[FALHOU] " ++ label
      ++ " | esperado=" ++ show expected
      ++ " | obtido=" ++ show actual
