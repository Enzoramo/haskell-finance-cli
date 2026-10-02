module Portifolio where

carteira :: [(String, Integer)]
carteira = [("AAPL", 80), ("MSFT", 50)]

-- Function to buy an asset and add it to the portfolio
comprar :: String -> Integer -> [(String, Integer)] -> [(String, Integer)]
comprar ativo quantidade [] = [(ativo, quantidade)]

comprar ativo quantidade ((nome, total) : resto)
  | ativo == nome = (nome, total + quantidade) : resto
  | otherwise = (nome, total) : comprar ativo quantidade resto

-- Function to sell an asset from the portfolio
vender :: String -> Integer -> [(String, Integer)] -> [(String, Integer)]
vender ativo quantidade [] = [(ativo, quantidade)]

vender ativo quantidade ((nome, total) : resto)
  | ativo == nome && total >= quantidade = (nome, total - quantidade) : resto -- if the asser exist & has enough, subtract the quantity
  | ativo == nome && total < quantidade = error "Quantidade insuficiente para vender" -- throw an error
  | otherwise = (nome, total) : vender ativo quantidade resto -- if the asset isnt the one, keep looking

-- Function to locate an asset in the portfolio
localizar :: String -> [(String, Integer)] -> Maybe (String, Integer) -- returns Just (asset, quantity) if found
localizar ativo [] = Nothing --if is null return Nothing
localizar ativo ((nome, total) : resto)
  | ativo == nome = Just (nome, total) -- return (asset, quantity)
  | otherwise = localizar ativo resto -- keep looking for the asset
