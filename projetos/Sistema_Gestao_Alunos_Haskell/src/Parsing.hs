module Parsing
  ( parseStudents
  , parseEvaluations
  , splitOn
  , trim
  ) where

import Data.Char (isSpace)
import Data.Either (partitionEithers)
import Data.List (dropWhileEnd)
import Model
import Text.Read (readMaybe)

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace

splitOn :: Char -> String -> [String]
splitOn _ [] = [""]
splitOn separator text = go text
  where
    go [] = [""]
    go (c:cs)
      | c == separator = "" : go cs
      | otherwise =
          case go cs of
            [] -> [[c]]
            (x:xs) -> (c:x) : xs

parseStudents :: String -> Either [String] [Student]
parseStudents input = collect (map (uncurry parseStudentLine) body)
  where
    body = dropPossibleHeader (numberedNonEmptyLines input)

parseEvaluations :: String -> Either [String] [Evaluation]
parseEvaluations input = collect (map (uncurry parseEvaluationLine) body)
  where
    body = dropPossibleHeader (numberedNonEmptyLines input)

numberedNonEmptyLines :: String -> [(Int, String)]
numberedNonEmptyLines input =
  [ (n, trim line)
  | (n, line) <- zip [1..] (lines input)
  , not (null (trim line))
  ]

dropPossibleHeader :: [(Int, String)] -> [(Int, String)]
dropPossibleHeader [] = []
dropPossibleHeader rows@((_, firstLine):rest) =
  case splitOn ';' firstLine of
    [] -> rows
    (firstField:_) ->
      case readMaybe (trim firstField) :: Maybe Int of
        Just _  -> rows
        Nothing -> rest

parseStudentLine :: Int -> String -> Either String Student
parseStudentLine lineNumber line =
  case map trim (splitOn ';' line) of
    [sidText, name, course] -> do
      sid <- readInt "identificador do aluno" lineNumber sidText
      if sid <= 0
        then Left (lineError lineNumber "o identificador deve ser positivo")
        else if null name
          then Left (lineError lineNumber "o nome não pode ser vazio")
          else if null course
            then Left (lineError lineNumber "o curso não pode ser vazio")
            else Right (Student sid name course)
    _ -> Left (lineError lineNumber "esperados 3 campos: id;nome;curso")

parseEvaluationLine :: Int -> String -> Either String Evaluation
parseEvaluationLine lineNumber line =
  case map trim (splitOn ';' line) of
    [sidText, unitName, componentName, gradeText, weightText] -> do
      sid <- readInt "identificador do aluno" lineNumber sidText
      grade <- readDouble "nota" lineNumber gradeText
      weight <- readDouble "peso" lineNumber weightText
      if sid <= 0
        then Left (lineError lineNumber "o identificador deve ser positivo")
        else if null unitName
          then Left (lineError lineNumber "a UC não pode ser vazia")
          else if null componentName
            then Left (lineError lineNumber "a componente não pode ser vazia")
            else if grade < 0 || grade > 20
              then Left (lineError lineNumber "a nota deve estar entre 0 e 20")
              else if weight <= 0 || weight > 1
                then Left (lineError lineNumber "o peso deve pertencer a ]0,1]")
                else Right (Evaluation sid unitName componentName grade weight)
    _ -> Left (lineError lineNumber "esperados 5 campos: aluno_id;uc;componente;nota;peso")

readInt :: String -> Int -> String -> Either String Int
readInt fieldName lineNumber text =
  case readMaybe text of
    Just value -> Right value
    Nothing -> Left (lineError lineNumber (fieldName ++ " inválido: " ++ show text))

readDouble :: String -> Int -> String -> Either String Double
readDouble fieldName lineNumber text =
  case readMaybe text of
    Just value -> Right value
    Nothing -> Left (lineError lineNumber (fieldName ++ " inválida: " ++ show text))

lineError :: Int -> String -> String
lineError lineNumber message =
  "Linha " ++ show lineNumber ++ ": " ++ message

collect :: [Either String a] -> Either [String] [a]
collect values =
  case partitionEithers values of
    ([], parsedValues) -> Right parsedValues
    (errors, _)        -> Left errors
