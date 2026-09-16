module Main where

import Control.Exception (IOException, try)
import Data.List (sortOn)
import Domain
import GHC.IO.Encoding (setLocaleEncoding, utf8)
import Model
import Parsing
import Report
import System.IO (hSetEncoding, stderr, stdin, stdout)
import Text.Printf (printf)
import Text.Read (readMaybe)

studentsPath :: FilePath
studentsPath = "data/alunos.csv"

evaluationsPath :: FilePath
evaluationsPath = "data/avaliacoes.csv"

reportPath :: FilePath
reportPath = "relatorio.txt"

main :: IO ()
main = do
  configureEncoding
  putStrLn "Sistema de Gestão de Alunos e Avaliações"
  putStrLn "A carregar dados..."
  loaded <- loadData
  case loaded of
    Left err -> do
      putStrLn "\nNão foi possível iniciar a aplicação:"
      putStrLn err
    Right (students, evaluations) -> do
      putStrLn $ "Carregados " ++ show (length students) ++ " alunos e "
        ++ show (length evaluations) ++ " avaliações."
      runMenu students evaluations

configureEncoding :: IO ()
configureEncoding = do
  setLocaleEncoding utf8
  hSetEncoding stdin utf8
  hSetEncoding stdout utf8
  hSetEncoding stderr utf8

loadData :: IO (Either String ([Student], [Evaluation]))
loadData = do
  studentsText <- safeReadFile studentsPath
  evaluationsText <- safeReadFile evaluationsPath
  pure $ do
    sText <- studentsText
    eText <- evaluationsText
    students <- either (Left . unlines) Right (parseStudents sText)
    evaluations <- either (Left . unlines) Right (parseEvaluations eText)
    let referenceErrors = validateEvaluationReferences students evaluations
    if null referenceErrors
      then Right (students, evaluations)
      else Left (unlines referenceErrors)

runMenu :: [Student] -> [Evaluation] -> IO ()
runMenu students evaluations = do
  putStrLn ""
  putStrLn "================ MENU ================"
  putStrLn "1 - Listar alunos"
  putStrLn "2 - Consultar aluno"
  putStrLn "3 - Listar resultados finais"
  putStrLn "4 - Estatísticas por UC"
  putStrLn "5 - Exportar relatório global"
  putStrLn "0 - Sair"
  putStr "Opção: "
  option <- getLine
  case trim option of
    "1" -> listStudentsAction students >> pause >> runMenu students evaluations
    "2" -> studentAction students evaluations >> pause >> runMenu students evaluations
    "3" -> resultsAction students evaluations >> pause >> runMenu students evaluations
    "4" -> unitStatisticsAction students evaluations >> pause >> runMenu students evaluations
    "5" -> exportAction students evaluations >> pause >> runMenu students evaluations
    "0" -> putStrLn "Até breve."
    _   -> putStrLn "Opção inválida." >> runMenu students evaluations

listStudentsAction :: [Student] -> IO ()
listStudentsAction students = do
  putStrLn "\nALUNOS"
  putStrLn "----------------------------------------"
  mapM_ (putStrLn . renderStudent) (sortOn studentId students)

studentAction :: [Student] -> [Evaluation] -> IO ()
studentAction students evaluations = do
  putStr "Número do aluno: "
  input <- getLine
  case readMaybe input of
    Nothing -> putStrLn "Identificador inválido."
    Just sid ->
      case studentReport sid students evaluations of
        Left err -> putStrLn err
        Right report -> putStrLn report

resultsAction :: [Student] -> [Evaluation] -> IO ()
resultsAction students evaluations = do
  putStrLn "\nRESULTADOS FINAIS"
  putStrLn "------------------------------------------------------------------------"
  mapM_ (putStrLn . renderResult) (buildResults students evaluations)

unitStatisticsAction :: [Student] -> [Evaluation] -> IO ()
unitStatisticsAction students evaluations = do
  let results = buildResults students evaluations
  putStrLn "\nESTATÍSTICAS POR UC"
  putStrLn "------------------------------------------------------------------------"
  mapM_ (printUnitStats results) (allUnits evaluations)

printUnitStats :: [Result] -> String -> IO ()
printUnitStats results unitName = do
  let unitResults = [r | r <- results, resultUnit r == unitName]
  let avg = averageResult unitResults
  let rate = approvalRate unitResults
  putStrLn $ unitName
    ++ " | média=" ++ maybe "--" (printf "%.2f") avg
    ++ " | aprovação=" ++ maybe "--" (\x -> printf "%.2f%%" x) rate

exportAction :: [Student] -> [Evaluation] -> IO ()
exportAction students evaluations = do
  result <- safeWriteFile reportPath (globalReport students evaluations)
  case result of
    Left err -> putStrLn err
    Right () -> putStrLn $ "Relatório criado em " ++ reportPath

safeReadFile :: FilePath -> IO (Either String String)
safeReadFile path = do
  result <- try (readFile path) :: IO (Either IOException String)
  pure $
    case result of
      Left ex -> Left ("Erro ao ler " ++ path ++ ": " ++ show ex)
      Right content -> Right content

safeWriteFile :: FilePath -> String -> IO (Either String ())
safeWriteFile path content = do
  result <- try (writeFile path content) :: IO (Either IOException ())
  pure $
    case result of
      Left ex -> Left ("Erro ao escrever " ++ path ++ ": " ++ show ex)
      Right () -> Right ()

pause :: IO ()
pause = do
  putStrLn ""
  putStr "Prima ENTER para continuar..."
  _ <- getLine
  pure ()
