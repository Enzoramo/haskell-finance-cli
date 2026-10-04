module Portifolio where

carteira :: [(String, Integer)]
carteira = [("AAPL", 80), ("MSFT", 50)]

-- Function to buy an asset and add it to the portfolio
comprar :: String -> Integer -> [(String, Integer)]
        -> Either String [(String, Integer)]

comprar _ quantidade _ -- Verifying if the buy quantity is a valid integer
  | quantidade <= 0 =
      Left "A quantidade deve ser maior que zero."

comprar ativo quantidade [] = -- If the asset is not found in the portfolio, add it with the specified quantity
      Right [(ativo, quantidade)]

comprar ativo quantidade ((nome, total) : resto)
  | ativo == nome =
      Right ((nome, total + quantidade) : resto)

  | otherwise =
      case comprar ativo quantidade resto of
        Left mensagem ->
          Left mensagem

        Right restoAtualizado ->
          Right ((nome, total) : restoAtualizado)


-- Function to sell an asset from the portfolio
vender :: String -> Integer -> [(String, Integer)]
       -> Either String [(String, Integer)]

vender _ quantidade _
  | quantidade <= 0 =
      Left "A quantidade deve ser maior que zero."

vender _ _ [] =
  Left "Ativo não encontrado na carteira."

vender ativo quantidade ((nome, total) : resto) -- additionally, we can check if the asset exists and if the quantity is sufficient to sell
  | ativo == nome && quantidade > total =
      Left "Quantidade insuficiente para vender."

  | ativo == nome =
      Right ((nome, total - quantidade) : resto)

  | otherwise =
      case vender ativo quantidade resto of
        Left mensagem ->
          Left mensagem

        Right restoAtualizado ->
          Right ((nome, total) : restoAtualizado)


-- Function to locate an asset in the portfolio
localizar :: String -> [(String, Integer)] -> Maybe (String, Integer) -- returns Just (asset, quantity) if found
localizar ativo [] = Nothing --if is null return Nothing
localizar ativo ((nome, total) : resto)
  | ativo == nome = Just (nome, total) -- return (asset, quantity)
  | otherwise = localizar ativo resto -- keep looking for the asset
