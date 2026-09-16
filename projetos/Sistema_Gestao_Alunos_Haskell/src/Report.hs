module Report
  ( renderStudent
  , renderEvaluation
  , renderResult
  , studentReport
  , unitReport
  , globalReport
  ) where

import Data.List (sortOn)
import Model
import Domain
import Text.Printf (printf)

renderStudent :: Student -> String
renderStudent student =
  show (studentId student)
    ++ " | " ++ studentName student
    ++ " | " ++ studentCourse student

renderEvaluation :: Evaluation -> String
renderEvaluation evaluation =
  show (evaluationStudentId evaluation)
    ++ " | " ++ evaluationUnit evaluation
    ++ " | " ++ evaluationComponent evaluation
    ++ " | nota=" ++ format2 (evaluationGrade evaluation)
    ++ " | peso=" ++ format2 (evaluationWeight evaluation)

renderResult :: Result -> String
renderResult result =
  show (studentId student)
    ++ " | " ++ studentName student
    ++ " | " ++ resultUnit result
    ++ " | nota final=" ++ maybe "--" format2 (resultFinalGrade result)
    ++ " | peso=" ++ format2 (resultTotalWeight result)
    ++ " | " ++ statusText (resultStatus result)
  where
    student = resultStudent result

studentReport :: StudentId -> [Student] -> [Evaluation] -> Either String String
studentReport sid students evaluations =
  case findStudent sid students of
    Nothing -> Left ("Aluno " ++ show sid ++ " não encontrado.")
    Just student ->
      Right . unlines $
        [ "RELATÓRIO DO ALUNO"
        , replicate 60 '-'
        , renderStudent student
        , replicate 60 '-'
        ]
        ++ map renderResult studentResults
  where
    studentResults =
      sortOn resultUnit
        [ result
        | result <- buildResults students evaluations
        , studentId (resultStudent result) == sid
        ]

unitReport :: String -> [Student] -> [Evaluation] -> String
unitReport unitName students evaluations =
  unlines $
    [ "RELATÓRIO DA UC: " ++ unitName
    , replicate 60 '-'
    , "Média: " ++ maybe "--" format2 averageGrade
    , "Taxa de aprovação: " ++ maybe "--" (\x -> format2 x ++ "%") rate
    , replicate 60 '-'
    ]
    ++ map renderResult unitResults
  where
    unitResults =
      sortOn (studentId . resultStudent)
        [ result
        | result <- buildResults students evaluations
        , resultUnit result == unitName
        ]
    averageGrade = averageResult unitResults
    rate = approvalRate unitResults

globalReport :: [Student] -> [Evaluation] -> String
globalReport students evaluations =
  unlines $
    [ "SISTEMA DE GESTÃO DE ALUNOS E AVALIAÇÕES"
    , "RELATÓRIO GLOBAL"
    , replicate 72 '='
    , "Número de alunos: " ++ show (length students)
    , "Número de avaliações: " ++ show (length evaluations)
    , "Número de resultados de UC: " ++ show (length results)
    , "Média global: " ++ maybe "--" format2 (averageResult results)
    , "Taxa global de aprovação: " ++ maybe "--" (\x -> format2 x ++ "%") (approvalRate results)
    , replicate 72 '='
    ]
    ++ concatMap section (allUnits evaluations)
  where
    results = buildResults students evaluations
    section unitName =
      [ ""
      , "UC: " ++ unitName
      , replicate 72 '-'
      ]
      ++ map renderResult
           [r | r <- results, resultUnit r == unitName]

statusText :: ResultStatus -> String
statusText Approved   = "APROVADO"
statusText Failed     = "REPROVADO"
statusText Incomplete = "INCOMPLETO"

format2 :: Double -> String
format2 value = printf "%.2f" value
