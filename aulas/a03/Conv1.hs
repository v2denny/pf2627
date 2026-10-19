module Conv1 where

import Data.Char

-- Constante: converte 'A' para minúscula.
con :: Char
con = toLower 'A'

-- Recebe um carácter e converte-o para maiúscula.
fun :: Char -> Char
fun x = toUpper x
