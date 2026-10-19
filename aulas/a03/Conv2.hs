module Conv2 where

import Data.Char

-- Recebe um carácter e devolve uma lista com
-- a versão minúscula e a versão maiúscula.
upperandlower :: Char -> String
upperandlower c = [toLower c, toUpper c]
