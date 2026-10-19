module Conversoes where

-- Converte Fahrenheit para Celsius.
fahrenheitToCelsius :: Double -> Double
fahrenheitToCelsius f = (f - 32) * 5 / 9

-- Converte Celsius para Fahrenheit.
celsiusToFahrenheit :: Double -> Double
celsiusToFahrenheit c = c * 9 / 5 + 32

-- Converte pés para metros.
feetToMeters :: Double -> Double
feetToMeters ft = ft * 0.3048

-- Converte metros para pés.
metersToFeet :: Double -> Double
metersToFeet m = m / 0.3048

-- Converte milhas para quilómetros.
milesToKilometers :: Double -> Double
milesToKilometers mi = mi * 1.609344

-- Converte quilómetros para milhas.
kilometersToMiles :: Double -> Double
kilometersToMiles km = km / 1.609344
