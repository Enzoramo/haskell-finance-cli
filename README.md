# Simulador de carteira em Haskell

[![Compilar Haskell](https://github.com/Enzoramo/haskell-finance-cli/actions/workflows/haskell.yml/badge.svg)](https://github.com/Enzoramo/haskell-finance-cli/actions/workflows/haskell.yml)

Projeto de estudo de Haskell: um programa de terminal para simular compras e vendas de ativos e acompanhar suas quantidades. Não envolve dinheiro real, preços ou conexão com uma corretora.

O objetivo é aprender funções, listas de tuplas, recursão, casamento de padrões, guardas, `Maybe` e entrada e saída com `IO`.

## Funcionalidades atuais

- Consultar os ativos e suas quantidades.
- Comprar um ativo, criando ou aumentando sua posição.
- Vender parte de uma posição existente.
- Localizar um ativo pelo seu código.
- Voltar ao menu com a carteira atualizada após cada operação válida.

A carteira começa vazia e existe apenas enquanto o programa está aberto. O valor de exemplo definido em `Portifolio.hs` não é usado como carteira inicial pelo `Main.hs`.

## Como executar

Requisito: GHC instalado. A compilação automática usa GHC 9.10.3. O projeto utiliza apenas a biblioteca padrão, sem dependências externas.

Após clonar o repositório, entre na pasta do programa:

```sh
git clone https://github.com/Enzoramo/haskell-finance-cli.git
cd haskell-finance-cli/Finance
runghc Main.hs
```

Para compilar e executar um binário, dentro de `Finance`:

```sh
ghc Main.hs -o simulador
./simulador
```

No VS Code, abra a pasta do repositório e use o terminal integrado para executar esses comandos. A extensão Haskell oferece suporte à edição.

## Exemplo de uso

1. Digite `2`, depois `AAPL` e `100` para comprar 100 unidades.
2. Digite `3`, depois `AAPL` e `20` para vender 20 unidades.
3. Digite `1` para consultar a carteira: `[("AAPL",80)]`.
4. Digite `4` e `AAPL` para localizar essa posição.

O programa diferencia maiúsculas e minúsculas nos códigos dos ativos. Para encerrar a execução, pressione `Ctrl+C` no terminal.

## Organização

```text
Finance/
  Main.hs       # Inicia o programa com uma carteira vazia
  Painel.hs     # Menu e leitura das entradas do usuário
  Portifolio.hs # Funções de compra, venda e consulta
.github/workflows/haskell.yml # Compilação automática no GitHub
```

## Próximos passos de aprendizado

O projeto está em desenvolvimento. Estas limitações ficam como exercícios para as próximas versões:

- Validar quantidades: textos não numéricos causam erro, e valores negativos ou zero ainda são aceitos.
- Impedir a venda de um ativo inexistente: atualmente esse caso cria uma posição indevida.
- Tratar uma venda acima da quantidade disponível sem encerrar o programa.
- Repetir o menu após uma opção inválida e adicionar uma opção explícita de saída.
- Salvar a carteira em arquivo e carregá-la na próxima execução.
- Adicionar testes para as regras de compra e venda.

## Como versionar as próximas alterações

No terminal, dentro da pasta do repositório:

```sh
git status
git diff
git add Finance README.md
git commit -m "Descreve a melhoria realizada"
git push
```

`git diff` mostra o que mudou; `git add` seleciona os arquivos; `git commit` registra uma versão local; `git push` envia os commits para o GitHub. Ao criar outros arquivos, inclua-os também no `git add`.

Prefira commits pequenos, cada um com uma mudança que você consiga explicar, por exemplo: `Valida a quantidade informada na compra`.

A aba **Actions** do GitHub mostra se o código compila após cada envio para `main` e em pull requests. Essa checagem ainda não testa as regras do simulador.
