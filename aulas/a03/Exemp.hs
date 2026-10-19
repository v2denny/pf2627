module Exemp where

import Conv2
import Data.Char

-- Se x for uma letra, devolve [minúscula, maiúscula].
-- Caso contrário, devolve a lista vazia.
conv :: Char -> String
conv x =
    if isAlpha x
        then upperandlower x
        else []
