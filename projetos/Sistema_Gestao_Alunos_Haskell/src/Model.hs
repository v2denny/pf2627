module Model
  ( StudentId
  , Student(..)
  , Evaluation(..)
  , ResultStatus(..)
  , Result(..)
  ) where

type StudentId = Int

data Student = Student
  { studentId     :: StudentId
  , studentName   :: String
  , studentCourse :: String
  } deriving (Eq, Show)

data Evaluation = Evaluation
  { evaluationStudentId :: StudentId
  , evaluationUnit      :: String
  , evaluationComponent :: String
  , evaluationGrade     :: Double
  , evaluationWeight    :: Double
  } deriving (Eq, Show)

data ResultStatus
  = Approved
  | Failed
  | Incomplete
  deriving (Eq, Ord, Show)

data Result = Result
  { resultStudent     :: Student
  , resultUnit        :: String
  , resultFinalGrade  :: Maybe Double
  , resultTotalWeight :: Double
  , resultStatus      :: ResultStatus
  } deriving (Eq, Show)
