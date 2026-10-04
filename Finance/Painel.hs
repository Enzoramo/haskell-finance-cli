module Painel where
import Portifolio
import Text.Read (readMaybe)

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
            case (readMaybe quantidadeStr :: Maybe Integer) of -- Verifing if the input is a valid integer
                Nothing -> do
                    putStrLn "Erro!! Quantidade inválida. Digite um número inteiro." -- if the quantity is not a valid integer, print an error message
                    linhas carteira
                Just quantidade
                    | quantidade <= 0 -> do
                        putStrLn "Erro!! A quantidade deve ser maior que zero."
                        linhas carteira

                    | otherwise -> do
                        case comprar ativo quantidade carteira of
                            Left mensagem -> do
                                putStrLn $ "Erro ao comprar: " ++ mensagem
                                linhas carteira
                            Right novaCarteira -> do
                                putStrLn $ "Sucesso ao comprar " ++ show quantidade ++ " de " ++ ativo
                                linhas novaCarteira
        "3" -> do
            putStrLn "Digite o ativo que deseja vender:"
            ativo <- getLine
            putStrLn "Digite a quantidade que deseja vender:"
            quantidadeStr <- getLine
            case (readMaybe quantidadeStr :: Maybe Integer) of -- Verifing if the input is the sell quantity is a valid integer
                Nothing -> do
                    putStrLn "Erro!! Quantidade inválida. Digite um número inteiro."
                    linhas carteira
                Just quantidade
                    | quantidade <= 0 -> do
                        putStrLn "Erro!! A quantidade deve ser maior que zero."
                        linhas carteira
                    | otherwise -> do
                        case vender ativo quantidade carteira of
                            Left mensagem -> do
                                putStrLn $ "Erro ao vender: " ++ mensagem
                                linhas carteira
                            Right novaCarteira -> do
                                putStrLn $ "Sucesso ao vender " ++ show quantidade ++ " de " ++ ativo
                                linhas novaCarteira
        "4" -> do
            putStrLn "Digite o ativo que deseja localizar:"
            ativo <- getLine
            case localizar ativo carteira of
                Just (nome, total) -> putStrLn $ "Ativo: " ++ nome ++ ", Quantidade: " ++ show total
                Nothing -> putStrLn "Ativo não encontrado na carteira"
            linhas carteira
        _ -> do
            putStrLn "Opção inválida. Tente novamente."
            linhas carteira
