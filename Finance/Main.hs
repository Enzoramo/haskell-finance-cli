module Main where
import Painel (linhas)
import System.IO.Error (catchIOError, isEOFError)

main :: IO ()
main = catchIOError (linhas []) tratarErro -- Catching the EOF error to handle the end of input gracefully

tratarErro :: IOError -> IO ()
tratarErro erro
    | isEOFError erro =
        putStrLn "\nEntrada encerrada. Até logo!"

    | otherwise =
        ioError erro