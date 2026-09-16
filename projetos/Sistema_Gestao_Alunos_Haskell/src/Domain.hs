module Domain
  ( findStudent
  , evaluationsForStudent
  , unitsForStudent
  , allUnits
  , totalWeight
  , finalGrade
  , resultFor
  , buildResults
  , validateEvaluationReferences
  , averageResult
  , approvalRate
  ) where

import Data.List (find, nub, sort)
import Data.Maybe (mapMaybe)
import Model

findStudent :: StudentId -> [Student] -> Maybe Student
findStudent sid = find ((== sid) . studentId)

evaluationsForStudent :: StudentId -> [Evaluation] -> [Evaluation]
evaluationsForStudent sid = filter ((== sid) . evaluationStudentId)

unitsForStudent :: StudentId -> [Evaluation] -> [String]
unitsForStudent sid evaluations =
  sort . nub $
    [ evaluationUnit evaluation
    | evaluation <- evaluations
    , evaluationStudentId evaluation == sid
    ]

allUnits :: [Evaluation] -> [String]
allUnits = sort . nub . map evaluationUnit

totalWeight :: [Evaluation] -> Double
totalWeight = sum . map evaluationWeight

finalGrade :: [Evaluation] -> Maybe Double
finalGrade [] = Nothing
finalGrade evaluations
  | abs (totalWeight evaluations - 1.0) > tolerance = Nothing
  | otherwise = Just (sum [evaluationGrade e * evaluationWeight e | e <- evaluations])
  where
    tolerance = 0.0001

resultFor :: Student -> String -> [Evaluation] -> Result
resultFor student unitName evaluations =
  Result
    { resultStudent = student
    , resultUnit = unitName
    , resultFinalGrade = grade
    , resultTotalWeight = totalWeight relevant
    , resultStatus = statusFromGrade grade
    }
  where
    relevant =
      [ evaluation
      | evaluation <- evaluations
      , evaluationStudentId evaluation == studentId student
      , evaluationUnit evaluation == unitName
      ]
    grade = finalGrade relevant

buildResults :: [Student] -> [Evaluation] -> [Result]
buildResults students evaluations =
  [ resultFor student unitName evaluations
  | student <- students
  , unitName <- unitsForStudent (studentId student) evaluations
  ]

validateEvaluationReferences :: [Student] -> [Evaluation] -> [String]
validateEvaluationReferences students evaluations =
  [ "Avaliação refere aluno inexistente: " ++ show sid
  | sid <- nub (map evaluationStudentId evaluations)
  , findStudent sid students == Nothing
  ]

averageResult :: [Result] -> Maybe Double
averageResult results = average grades
  where
    grades = mapMaybe resultFinalGrade results

approvalRate :: [Result] -> Maybe Double
approvalRate results =
  case completed of
    [] -> Nothing
    _  -> Just (100 * fromIntegral approvedCount / fromIntegral (length completed))
  where
    completed = [r | r <- results, resultFinalGrade r /= Nothing]
    approvedCount = length [r | r <- completed, resultStatus r == Approved]

statusFromGrade :: Maybe Double -> ResultStatus
statusFromGrade Nothing = Incomplete
statusFromGrade (Just grade)
  | grade >= 10 = Approved
  | otherwise   = Failed

average :: [Double] -> Maybe Double
average [] = Nothing
average xs = Just (sum xs / fromIntegral (length xs))
