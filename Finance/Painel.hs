module Painel where
import Portifolio

linhas :: [(String, Integer)] -> IO ()
linhas carteira = do
    putStrLn "=============================="
    putStrLn "Bem-vindo ao Painel Financeiro"
    putStrLn "=============================="
    putStrLn "Digite 1 para ver a carteira"
    putStrLn "Digite 2 para comprar um ativo"
    putStrLn "Digite 3 para vender um ativo"
    putStrLn "Digite 4 para localizar um ativo"
    opcao <- getLine
    case opcao of
        "1" -> do
            putStrLn "Carteira:"
            print carteira
            linhas carteira
        "2" -> do
            putStrLn "Digite o ativo que deseja comprar:"
            ativo <- getLine
            putStrLn "Digite a quantidade que deseja comprar:"
            quantidadeStr <- getLine
            let quantidade = read quantidadeStr :: Integer
            let novaCarteira = comprar ativo quantidade carteira
            linhas novaCarteira
        "3" -> do
            putStrLn "Digite o ativo que deseja vender:"
            ativo <- getLine
            putStrLn "Digite a quantidade que deseja vender:"
            quantidadeStr <- getLine
            let quantidade = read quantidadeStr :: Integer
            let novaCarteira = vender ativo quantidade carteira
            linhas novaCarteira
        "4" -> do
            putStrLn "Digite o ativo que deseja localizar:"
            ativo <- getLine
            case localizar ativo carteira of
                Just (nome, total) -> putStrLn $ "Ativo: " ++ nome ++ ", Quantidade: " ++ show total
                Nothing -> putStrLn "Ativo não encontrado na carteira"
            linhas carteira
        _ -> putStrLn "Opção inválida"
