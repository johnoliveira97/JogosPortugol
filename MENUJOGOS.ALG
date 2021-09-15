algoritmo "MenuJogos"
// Função :
// Autor :
// Data : 17/05/2019
// Seção de Declarações
//--------------------------------------------//
//-------------Menu de Jogos-----------------//
funcao menuJogos(): inteiro
var
   indice: inteiro
inicio
   Repita
      Escreval("1- Campo Minado")
      Escreval("2- Jogo da Velha")
      Escreval("3- Sair")
      Leia(indice)
      enquanto ((indice <= 0) OU (indice > 3)) faca
         limpatela
         Escreval("Opção inválida! Digite um número entre 1 e 3.")
         Escreval("1- Campo Minado")
         Escreval("2- Jogo da Velha")
         Escreval("3- Sair")
         Leia(indice)
      fimenquanto
   Ate ((indice > 0) E (indice < 4))
   retorne indice

fimfuncao
//-----------------------------Campo Minado--------------------------------//
//Preenche o campo com 0 em todas as posicoes
procedimento iniciaMinas()
var
   i, j: inteiro
inicio
   para i de 0 ate 9 faca
      para j de 0 ate 9 faca
         minas[i, j] <- 0
      fimpara
   fimpara
fimprocedimento
//-------------------------------------------//
//Coloca, aleatoriamente, 10 minas no tabuleiro de minas
procedimento sorteiaMinas()
var
   sorteado: logico
   i, lin, col, boom: inteiro
inicio
   sorteado <- Verdadeiro
   para i de 1 ate 10 faca
      Repita
         lin <- randi(8)
         col <- randi(8)
         Repita
            se ((lin = 0) OU (col = 0)) entao
               lin <- randi(8)
               col <- randi(8)
            fimse
         Ate ((lin <> 0) E (col <> 0))
         se (minas[lin, col] = -1) entao // Verifica se o campo ja contem uma mina
            sorteado <- Verdadeiro
         senao
            sorteado <- Falso
         fimse
      Ate (sorteado = Falso)
      boom <- boom + 1
      minas[lin, col] <- -1 // Preenche -1 onde a mina foi sorteada
   fimpara
fimprocedimento
//-------------------------------------------//
//Preenche o tabuleiro de minas com o numero de minas vizinhas
procedimento preencheDicas()
var
   line, column, i, j: inteiro
inicio
   para line de 1 ate 8 faca
      para column de 1 ate 8 faca
         para i de -1 ate 1 faca
            para j de -1 ate 1 faca
               se (minas[line, column] <> -1) entao
                  se (minas[line+i,column+j] = -1) entao
                     minas[line,column] <- minas[line,column]+1
                  fimse
               fimse
            fimpara
         fimpara
      fimpara
   fimpara
fimprocedimento
//-------------------------------------------//
//Preenche o tabuleiro exibido para o usuario com "*"
procedimento iniciaTabuleiroCampoMinado()
var
   i, j: inteiro
inicio
   para i de 1 ate 9 faca
      para j de 1 ate 9 faca
         tabuleiro[i, j] <- "*"
      fimpara
   fimpara
fimprocedimento
//-------------------------------------------//
//Exibe os numeros das linhas e colunas, para facilitar o modo que o usuario ve o tabuleiro
procedimento exibe()
var
   linha, coluna: inteiro
inicio
   Escreval("     Linhas")
   para linha de 8 ate 1 passo -1 faca
      Escreva("       ",linha," ")
      para coluna de 1 ate 8 faca
         Escreva("   ",tabuleiro[linha,coluna])
      fimpara
      Escreval()
   fimpara
   Escreval("              1   2   3   4   5   6   7   8")
   Escreval("                      Colunas")
fimprocedimento
//-------------------------------------------//
//Verifica no tabuleiro, quantas casas nao foram abertas.
//Caso tenham 10 "*", significa que so sobraram as bombas, e ele retorna verdadeiro.
//Caso tenham mais de 10 "*", retorna falso.
funcao ganhouCampoMinado(): logico
var
   conta, lin, col: inteiro
   g: logico
inicio
   conta <- 0
   para lin de 1 ate 8 faca
      para col de 1 ate 8 faca
         se (tabuleiro[lin, col] = "*") entao
            conta <- conta +1
         fimse
      fimpara
   fimpara
   se (conta = 10) entao
      g <- Verdadeiro
   senao
      g <- Falso
   fimse
   retorne g
fimfuncao
//-------------------------------------------//
//Procedimento para abrir os campos ao redor do escolhido, caso nao sejam minas
procedimento abrirVizinhas()
var
   i, j: inteiro
inicio
   para i de -1 ate 1 faca
      para j de -1 ate 1 faca
         se ((minas[linha+i, coluna+j] <> -1) E (linha <> 0) E (linha <> 9) E (coluna <> 0) E (coluna <> 9)) entao
            tabuleiro[linha+i, coluna+j] <- Numpcarac(minas[linha+i, coluna+j])
         fimse
      fimpara
   fimpara
fimprocedimento
//-------------------------------------------//
//Pega a posicao escolhida no tabuleiro, e verifica se o valor correspondente e uma mina
funcao pegaPosicao(linha, coluna: inteiro): inteiro
inicio
   retorne minas[linha, coluna]
fimfuncao
//-------------------------------------------//
//Funcao que verifica o campo escolhido, se ele existe, ou ainda nao foi aberto
//Caso retorne verdadeiro, abre o campo, se nao, o usuario devera
//digitar outro campo
funcao setarPosicao(): logico
var
   mA: inteiro
   finalmente: logico
inicio
   Repita
      Escreva("Linha: ")
      Leia(linha)
      Escreva("Coluna: ")
      Leia(coluna)
      se ((linha < 1) OU (linha > 8) OU (coluna < 1) OU (coluna > 8)) entao
         Escreval("Escolha numeros entre 1 e 8")
         Escreva("Linha: ")
         Leia(linha)
         Escreva("Coluna: ")
         Leia(coluna)
      fimse
      se (tabuleiro[linha, coluna] <> "*") entao
         Escreval("Esse campo já está sendo exibido!")
         Escreval("Digite um valor válido!")
         Escreva("Linha: ")
         Leia(linha)
         Escreva("Coluna: ")
         leia(coluna)
      fimse
   Ate (((linha > 0) E (linha < 9)) E ((coluna > 0) E (coluna < 9)) OU (tabuleiro[linha,coluna] <> "*"))
   mA <- pegaPosicao(linha, coluna)
   se mA = -1 entao
      finalmente <- Verdadeiro
   senao
      finalmente <- Falso
   fimse
   retorne finalmente
fimfuncao
//-------------------------------------------//
//Exibe onde as minas estavam
procedimento exibeMinas()
var
   i, j: inteiro
inicio
   para i de 1 ate 8 faca
      para j de 1 ate 8 faca
         se (minas[i, j] = -1) entao
            tabuleiro[i, j] <- "X"
         fimse
      fimpara
   fimpara
   exibe()
fimprocedimento
//-------------------------------------------//
//Procedimento onde ocorre toda a logica do jogo
//Monta o tabuleiro, sorteia onde as minas ficam,
//Preenche os campos com as dicas das minas ao redor,
//Exibe o tabuleiro, verifica a variavel escolhida, se o usuario ganhou ou perdeu
//E exibe as minas ao fim da partida.
procedimento jogarCampoMinado()
var
   rodada: inteiro
   terminou, ganhou: logico
inicio
   rodada <- 0
   iniciaMinas()
   sorteiaMinas()
   preencheDicas()
   limpatela
   iniciaTabuleiroCampoMinado()
   Repita
      limpatela
      rodada <- rodada + 1
      Escreval("Rodada ",rodada)
      exibe()
      terminou <- setarPosicao()
      se (terminou = Falso) entao
         abrirVizinhas()
         terminou <- ganhouCampoMinado()
      fimse
   Ate (terminou = Verdadeiro)
   ganhou <- ganhouCampoMinado()
   se (ganhou = Falso) entao
      limpatela
      se (derrota < 5) entao
         Escreval("Havia uma mina ! Você perdeu!")
         Escreval("Rodadas ate o fim do jogo: ", rodada)
      senao
         Escreval("Cara, você já perdeu pela ", derrota,"ª vez. Certeza que esse jogo é para você?")
         Escreval("Rodadas ate o fim do jogo: ", rodada)
      fimse
      exibeMinas()
      derrota <- derrota + 1
   senao
      limpatela
      Escreval("************************************************************")
      Escreval("Parabéns, você deixou os 10 campos de minas livres em ",rodada," rodadas")
      exibeMinas()
      vitoria <- vitoria + 1
      Escreval("Essa foi a sua vitoria de numero: ",vitoria, "Parabéns campeão!")
      Escreval("Poucos conseguem isso.")
      Escreval("************************************************************")
      Escreval()
   fimse
fimprocedimento
//-----------------------Fim Procedimentos Campo Minado----------------------//
//---------------------------------------------------------------------------//
//--------------------------Jogo da Velha------------------------------------//
//---------------------------------------------------------------------------------------------------//
//Procedimento para decidir se o jogo será contra máquina ou jogador 2.
procedimento escolheBot()
var
   opcao: caractere
inicio
   certo <- falso
   Enquanto (certo = falso) faca
      Escreval("Deseja jogar contra jogador ou contra máquina? j/m")
      Leia(opcao)
      se (opcao = "m") entao
         bot <- verdadeiro
         certo <- verdadeiro
      senao
         bot <- falso
         certo <- verdadeiro
      fimse
      se ((opcao <> "m") E (opcao <> "j")) entao
         limpatela
         Escreval("Opção inválida!")
         certo <- falso
      fimse
   fimenquanto
fimprocedimento
//---------------------------------------------------------------------------------------------------//
//Procedimento para escolher se começa jogando, e qual simbolo sera.
procedimento escolhaJogador()
var
   opcao: caractere
inicio
   certo <- falso
   Enquanto (certo = falso) faca
      Escreval("Deseja começar jogando? s/n")
      Leia(opcao)
      se opcao = "s" entao
         usuario <- "p1"
         certo <- verdadeiro
      senao
         se opcao = "n" entao
            usuario <- "p2"
            certo <- verdadeiro
         fimse
      fimse
      Repita
         se ((opcao <> "s") E (opcao <> "n")) entao
            limpatela
            Escreval("Opção inválida! Digite 's' ou 'n'.")
            Leia(opcao)
            se opcao = "s" entao
               usuario <- "p1"
               certo <- verdadeiro
            senao
               se opcao = "n" entao
                  usuario <- "p2"
                  certo <- verdadeiro
               fimse
            fimse
         fimse
      Ate ((opcao = "s") OU (opcao = "n"))
   Fimenquanto
   certo <- falso
   Enquanto (certo = falso) faca
      se usuario = "p1" entao
         Escreval("Deseja jogar como 'X' ou 'O'?")
         Leia(p1)
         se ((p1 ="x") OU (p1 = "X")) entao
            p1 <- "X"
            p2 <- "O"
            certo <- verdadeiro
         senao
            se ((p1 ="o") OU (p1 = "O")) entao
               p2 <- "X"
               p1 <- "O"
               certo <- verdadeiro
            fimse
         fimse
      senao
         Escreval("Deseja jogar como 'X' ou 'O'?")
         Leia(p2)
         se ((p2 ="x") OU (p2 = "X")) entao
            p2 <- "X"
            p1 <- "O"
            certo <- verdadeiro
         senao
            se ((p2 ="o") OU (p2 = "O")) entao
               p1 <- "X"
               p2 <- "O"
               certo <- verdadeiro
            fimse
         fimse
      fimse
      se (((p1 <> "o") E (p1 <> "O")) E ((p2 <> "o") E (p2 <> "O")) E ((p1 <> "x") E (p1 <> "X")) E ((p1 <> "x") E (p1 <> "X"))) entao
         limpatela
         Escreval("Voce digitou um valor inválido!")
         certo <- falso
      fimse
   fimenquanto
fimprocedimento
//---------------------------------------------------------------------------------------------------//
//Procedimento que deixa todos os campos com numeros de 1 ate 9.
procedimento zeraMatriz()
var
   i, j, k: inteiro
inicio
   k <- 0
   para i de 1 ate 3 faca
      para j de 1 ate 3 faca
         k <- k + 1
         tabuleiroVelha[i, j] <- numpcarac(k)
      fimpara
   fimpara
fimprocedimento
//---------------------------------------------------------------------------------------------------//
//Procedimento para zerar matriz de comparação.
procedimento criaMatriz()
var
   i: inteiro
inicio
   para i de 1 ate 9 faca
      checaNum[i] <- 0
   fimpara
fimprocedimento
//---------------------------------------------------------------------------------------------------//
//Procedimento para criar o layout do jogo, e exibir o mesmo
procedimento exibirTabuleiro()
inicio
   Escreval("      +---+---+---+")
   Escreval("      | ", tabuleiroVelha[1,1], " | ", tabuleiroVelha[1,2], " | ", tabuleiroVelha[1,3], " |")
   Escreval("      +---+---+---+")
   Escreval("      | ", tabuleiroVelha[2,1], " | ", tabuleiroVelha[2,2], " | ", tabuleiroVelha[2,3], " |")
   Escreval("      +---+---+---+")
   Escreval("      | ", tabuleiroVelha[3,1], " | ", tabuleiroVelha[3,2], " | ", tabuleiroVelha[3,3], " |")
   Escreval("      +---+---+---+")
fimprocedimento
//---------------------------------------------------------------------------------------------------//
procedimento jogadas()
var
   tentativa, i, g1, g2, g3: inteiro
   erro: caractere
   tem: logico
inicio
   zeraMatriz()
   criaMatriz()
   escolhaJogador()
   exibirTabuleiro()
   certo <- falso
   i <- 1
   Enquanto ((certo = falso)) faca
      Enquanto ((fim = falso)) faca
         se ((i%2 = 1) E (usuario = "p1")) entao
            Escreval("Rodada ", i)
            Escreval("Escolha onde jogar o ", p1)
            Leia(tentativa)
            linhax <- tentativaLinha(tentativa)
            colunay <- tentativaColuna(tentativa)
            tem <- checaJogada(tentativa)
            erro <- p1
            se (tem = verdadeiro) entao
               tabuleiroVelha[linhax, colunay] <- p1
               certo <- verdadeiro
            fimse
         senao
            se ((i%2 = 1) E (usuario = "p2")) entao
               Escreval("Rodada ", i)
               Escreval("Escolha onde jogar o ", p1)
               Leia(tentativa)
               linhax <- tentativaLinha(tentativa)
               colunay <- tentativaColuna(tentativa)
               tem <- checaJogada(tentativa)
               erro <- p1
               se (tem = verdadeiro) entao
                  tabuleiroVelha[linhax, colunay] <- p1
                  certo <- verdadeiro
               fimse
            fimse
         fimse
         se ((i%2 = 0) E (usuario = "p1")) entao
            Escreval("Rodada ", i)
            Escreval("Escolha onde jogar o ", p2)
            Leia(tentativa)
            linhax <- tentativaLinha(tentativa)
            colunay <- tentativaColuna(tentativa)
            tem <- checaJogada(tentativa)
            erro <- p2
            se (tem = verdadeiro) entao
               tabuleiroVelha[linhax, colunay] <- p2
               certo <- verdadeiro
            fimse
         senao
            se ((i%2 = 0) E (usuario = "p2")) entao
               Escreval("Rodada ", i)
               Escreval("Escolha onde jogar o ", p2)
               Leia(tentativa)
               linhax <- tentativaLinha(tentativa)
               colunay <- tentativaColuna(tentativa)
               tem <- checaJogada(tentativa)
               erro <- p2
               se (tem = verdadeiro) entao
                  tabuleiroVelha[linhax, colunay] <- p2
                  certo <- verdadeiro
               fimse
            fimse
         fimse
         Enquanto (tem = falso) faca
            limpatela
            exibirTabuleiro()
            Escreval("Local inválido ou ocupado. Digite outro número de 1 a 9.")
            Leia(tentativa)
            linhax <- tentativaLinha(tentativa)
            colunay <- tentativaColuna(tentativa)
            tem <- checaJogada(tentativa)
            se (usuario = "p1") entao
               se ((tem = verdadeiro) E (i%2 = 1)) entao
                  tabuleiroVelha[linhax, colunay] <- erro
                  certo <- verdadeiro
               senao
                  se ((tem = verdadeiro) E (i%2 = 0)) entao
                     tabuleiroVelha[linhax, colunay] <- erro
                     certo <- verdadeiro
                  fimse
               fimse
            senao
               se ((tem = verdadeiro) E (i%2 = 1)) entao
                  tabuleiroVelha[linhax, colunay] <- erro
                  certo <- verdadeiro
               senao
                  se ((tem = verdadeiro) E (i%2 = 0)) entao
                     tabuleiroVelha[linhax, colunay] <- erro
                     certo <- verdadeiro
                  fimse
               fimse
            fimse
         fimenquanto
         limpatela
         exibirTabuleiro()
         g1 <- checaLinhas()
         g2 <- checaColunas()
         g3 <- checaDiagonais()
         i <- i+1
      fimse
   fimenquanto
fimenquanto
fimprocedimento
//---------------------------------------------------------------//
procedimento jogadasBot()
var
   tentativa, i, g1, g2, g3, a: inteiro
   tem: logico
   erro: caractere
inicio
   zeraMatriz()
   criaMatriz()
   escolhaJogador()
   exibirTabuleiro()
   certo <- falso
   fim <- falso
   i <- 1
   Enquanto (certo = falso) faca
      Enquanto ((fim = falso) E (deuVelha() < 9)) faca
         se ((i%2 = 1) E (usuario = "p1")) entao
            Escreval("Rodada ", i)
            Escreval("Escolha onde jogar.")
            Leia(tentativa)
            linhax <- tentativaLinha(tentativa)
            colunay <- tentativaColuna(tentativa)
            tem <- checaJogada(tentativa)
            erro <- p1
            se (tem = verdadeiro) entao
               tabuleiroVelha[linhax, colunay] <- p1
               certo <- verdadeiro
            fimse
         senao
            se ((i%2 = 0) E (usuario = "p2")) entao
               Escreval("Rodada ", i)
               Escreval("Escolha onde jogar.")
               Leia(tentativa)
               linhax <- tentativaLinha(tentativa)
               colunay <- tentativaColuna(tentativa)
               tem <- checaJogada(tentativa)
               se (tem = verdadeiro) entao
                  tabuleiroVelha[linhax, colunay] <- p2
                  certo <- verdadeiro
               fimse
            fimse
         fimse
         se ((i%2 = 0) E (usuario = "p1")) entao
            tentativa <- 0
            Enquanto (tentativa = 0) faca
               a <- randi(10)
               se (a <> 0) entao
                  tentativa <- a
               senao
                  a <- randi(10)
                  tentativa <- a
               fimse
               linhax <- tentativaLinha(tentativa)
               colunay <- tentativaColuna(tentativa)
               tem <- checaJogada(tentativa)
            fimenquanto
            se (tem = verdadeiro) entao
               tabuleiroVelha[linhax, colunay] <- p2
               certo <- verdadeiro
            fimse
         senao
            se ((i%2 = 1) E (usuario = "p2")) entao
               tentativa <- 0
               Enquanto (tentativa = 0) faca
                  a <- randi(10)
                  se (a <> 0) entao
                     tentativa <- a
                  senao
                     a <- randi(10)
                     tentativa <- a
                  fimse
                  linhax <- tentativaLinha(tentativa)
                  colunay <- tentativaColuna(tentativa)
                  tem <- checaJogada(tentativa)
               fimenquanto
               se (tem = verdadeiro) entao
                  tabuleiroVelha[linhax, colunay] <- p1
                  certo <- verdadeiro
               fimse
            fimse
         fimse
         Enquanto (tem = falso) faca
            se ((usuario = "p1") E (i%2 = 1)) entao
               limpatela
               exibirTabuleiro()
               Escreval("Local inválido ou ocupado. Digite outro número de 1 a 9.")
               Leia(tentativa)
               linhax <- tentativaLinha(tentativa)
               colunay <- tentativaColuna(tentativa)
               tem <- checaJogada(tentativa)
            senao
               se ((usuario = "p1") E (i%2 = 0)) entao
                  tentativa <- 0
                  Enquanto (tentativa = 0) faca
                     a <- randi(10)
                     se (a = 0) entao
                        a <- randi(10)
                     senao
                        tentativa <- a
                     fimse
                  fimenquanto
                  linhax <- tentativaLinha(tentativa)
                  colunay <- tentativaColuna(tentativa)
                  tem <- checaJogada(tentativa)
               fimse
            fimse
            se ((usuario = "p2") E (i%2 = 0)) entao
               limpatela
               exibirTabuleiro()
               Escreval("Local inválido ou ocupado. Digite outro número de 1 a 9.")
               Leia(tentativa)
               linhax <- tentativaLinha(tentativa)
               colunay <- tentativaColuna(tentativa)
               tem <- checaJogada(tentativa)
            senao
               se ((usuario = "p2") E (i%2 = 1)) entao
                  tentativa <- 0
                  Enquanto (tentativa = 0) faca
                     a <- randi(10)
                     se (a = 0) entao
                        a <- randi(10)
                     senao
                        tentativa <- a
                     fimse
                  fimenquanto
                  linhax <- tentativaLinha(tentativa)
                  colunay <- tentativaColuna(tentativa)
                  tem <- checaJogada(tentativa)
               fimse
            fimse
            se (usuario = "p1") entao
               se ((tem = verdadeiro) E (i%2 = 1) E (tentativa <> 0)) entao
                  tabuleiroVelha[linhax, colunay] <- p1
                  certo <- verdadeiro
               senao
                  se ((tem = verdadeiro) E (i%2 = 0) E (tentativa <> 0)) entao
                     tabuleiroVelha[linhax, colunay] <- p2
                     certo <- verdadeiro
                  fimse
               fimse
            senao
               se ((tem = verdadeiro) E (i%2 = 1) E (tentativa <> 0)) entao
                  tabuleiroVelha[linhax, colunay] <- p1
                  certo <- verdadeiro
               senao
                  se ((tem = verdadeiro) E (i%2 = 0) E (tentativa <> 0)) entao
                     tabuleiroVelha[linhax, colunay] <- p2
                     certo <- verdadeiro
                  fimse
               fimse
            fimse
         fimenquanto
         limpatela
         exibirTabuleiro()
         g1 <- checaLinhas()
         g2 <- checaColunas()
         g3 <- checaDiagonais()
         i <- i + 1
      fimse
   fimenquanto
fimenquanto
fimprocedimento
//---------------------------------------------------------------//
funcao tentativaLinha(x: inteiro) : inteiro // insere valor na linha escolhida
inicio
   se (x >= 1) e (x <= 3) entao
      retorne 1
   senao
      se (x >= 4) e (x <= 6) entao
         retorne 2
      senao
         se(x >= 7) e (x <= 9) entao
            retorne 3
         fimse
      fimse
   fimse
   se (x > 9) entao
      retorne 0
   fimse
fimfuncao
//---------------------------------------------------------------//
funcao tentativaColuna(y : inteiro) : inteiro  //insere valor na coluna escolhida
inicio
   se (y = 1) ou (y = 4) ou (y = 7) entao
      retorne 1
   senao
      se (y = 2) ou (y = 5) ou (y = 8) entao
         retorne 2
      senao
         se(y = 3) ou (y = 6) ou (y = 9) entao
            retorne 3
         fimse
      fimse
   fimse
   se (y > 9) entao
      retorne 0
   fimse
fimfuncao
//---------------------------------------------------------------//
funcao checaJogada(tentativa: inteiro):logico
var
inicio
   se ((tentativa = 0) E (bot = verdadeiro)) entao
      Enquanto (tentativa = 0) faca
         tentativa <- randi(9)
      fimenquanto
   fimse
   se ((checaNum[tentativa]) = 0) entao
      checaNum[tentativa] <- 1
      retorne verdadeiro
   senao
      retorne falso
   fimse
fimfuncao
//---------------------------------------------------------------------------------------------------//
//Função para saber se o jogador "X" ou o "O" ganharam
funcao checaLinhas():inteiro
var
   i: inteiro
inicio
   para i de 1 ate 3 faca
      se ((tabuleiroVelha[i,1] = "X") E (tabuleiroVelha[i,2] = "X") E (tabuleiroVelha[i,3] = "X")) entao
         fimdeJogo(1)
         retorne 1
      fimse
      se ((tabuleiroVelha[i,1] = "O") E (tabuleiroVelha[i,2] = "O") E (tabuleiroVelha[i,3] = "O")) entao
         fimdeJogo(-1)
         retorne -1
      fimse
   fimpara
   retorne 0
fimfuncao
//--------------------------------------------------------------------------//
//Função para saber se o jogador "X" ou o "O" ganharam
funcao checaColunas():inteiro
var
   i: inteiro
inicio
   para i de 1 ate 3 faca
      se ((tabuleiroVelha[1,i] = "X") E (tabuleiroVelha[2,i] = "X") E (tabuleiroVelha[3,i] = "X")) entao
         fimdeJogo(1)
         retorne 1
      fimse
      se ((tabuleiroVelha[1,i] = "O") E (tabuleiroVelha[2,i] = "O") E (tabuleiroVelha[3,i] = "O")) entao
         fimdeJogo(-1)
         retorne -1
      fimse
   fimpara
   retorne 0
fimfuncao
//--------------------------------------------------------------------------//
//Função para saber se o jogador "X" ou o "O" ganharam
funcao checaDiagonais():inteiro
var
   i, j: inteiro
inicio
   i <- 1
   j <- 3
   se ((tabuleiroVelha[i,i] = "X") E (tabuleiroVelha[i+1,i+1] = "X") E (tabuleiroVelha[i+2,i+2] = "X")) entao
      fimdeJogo(1)
      retorne 1
   fimse
   se ((tabuleiroVelha[i,i] = "O") E (tabuleiroVelha[i+1,i+1] = "O") E (tabuleiroVelha[i+2,i+2] = "O")) entao
      fimdeJogo(-1)
      retorne -1
   fimse
   se ((tabuleiroVelha[i,j] = "X") E (tabuleiroVelha[i+1,j-1] = "X") E (tabuleiroVelha[i+2,j-2] = "X")) entao
      fimdeJogo(1)
      retorne 1
   fimse
   se ((tabuleiroVelha[i,j] = "O") E (tabuleiroVelha[i+1,j-1] = "O") E (tabuleiroVelha[i+2,j-2] = "O")) entao
      fimdeJogo(-1)
      retorne -1
   fimse
   retorne 0
fimfuncao
//--------------------------------------------------------------------------//
//Verifica se deu Velha, ou seja, se empatou
funcao deuVelha():inteiro
var
   lin, soma: inteiro
inicio
   soma <- 0
   para lin de 1 ate 9 faca
      soma <- soma + checaNum[lin]
   fimpara
   retorne soma
fimfuncao
//--------------------------------------------------------------------------//
//Procedimento que encerra o jogo, exibindo o vencedor
procedimento fimdeJogo(x: inteiro)
inicio
   se (x = 1) entao
      fim <- verdadeiro
      Escreval ("X ganhou")
      se (bot = falso) entao
         se ((usuario = "p1") E (p1 = "X")) entao
            vitoria <- vitoria + 1
         fimse
         se ((usuario = "p2") E (p2 = "X")) entao
            vitoria <- vitoria + 1
         fimse
         se ((usuario = "p1") E (p1 = "O")) entao
            vitoria2 <- vitoria2 + 1
         fimse
         se ((usuario = "p2") E (p2 = "O")) entao
            vitoria2 <- vitoria2 + 1
         fimse
      senao
         se ((usuario = "p1") E (p1 = "X")) entao
            vitoria <- vitoria + 1
         fimse
         se ((usuario = "p2") E (p2 = "X")) entao
            vitoria <- vitoria + 1
         fimse
         se ((usuario = "p1") E (p1 = "O")) entao
            derrota <- derrota + 1
         fimse
         se ((usuario = "p2") E (p2 = "O")) entao
            derrota <- derrota + 1
         fimse
      fimse
   senao
      se (x = -1) entao
         Escreval ("O ganhou")
         fim <- verdadeiro
         se (bot = falso) entao
            se ((usuario = "p1") E (p1 = "O")) entao
               vitoria <- vitoria + 1
            fimse
            se ((usuario = "p2") E (p2 = "O")) entao
               vitoria <- vitoria + 1
            fimse
            se ((usuario = "p1") E (p1 = "X")) entao
               vitoria2 <- vitoria2 + 1
            fimse
            se ((usuario = "p2") E (p2 = "X")) entao
               vitoria2 <- vitoria2 + 1
            fimse
         senao
            se ((usuario = "p1") E (p1 = "O")) entao
               vitoria <- vitoria + 1
            fimse
            se ((usuario = "p2") E (p2 = "O")) entao
               vitoria <- vitoria + 1
            fimse
            se ((usuario = "p1") E (p1 = "X")) entao
               derrota <- derrota + 1
            fimse
            se ((usuario = "p2") E (p2 = "X")) entao
               derrota <- derrota + 1
            fimse
         fimse
      fimse
      se ((deuVelha = 9) E (x <> 1) E (x <> -1)) entao
         Escreval("Deu Velha")
         empate <- empate + 1
      fimse
      fim <- verdadeiro
   fimse
fimprocedimento
//---------------------------------------------------------------------------------------------------//
var
   minas: vetor[0..9,0..9] de inteiro
   tabuleiro: vetor[0..9,0..9] de caractere
   tabuleiroVelha: vetor[1..3,1..3] de caractere
   checaNum: vetor[1..9] de inteiro
   linha, coluna, indice, jogador, resultx, resulty, vitoria, derrota, vitoria2: inteiro
   i, j, jogada, empate, linhax, colunay: inteiro
   ganha, termina, ganhou, certo, fim, bot: logico
   outra, outro: caractere
   p1, p2, usuario, ultimo: caractere
inicio
   Escreval("-------------------MENU DE JOGOS---------------------")
   Escreval()
   Repita
      Escreval("O que deseja jogar?")
      indice <- menuJogos()
      Escolha indice
      caso 1
         limpatela
         vitoria <- 0
         derrota <- 0
         jogarCampoMinado()
         Repita
            Escreval("Deseja jogar novamente? s/n")
            Leia(outra)
            se (outra = "s") entao
               jogarCampoMinado()
            fimse
         Ate outra <> "s"
         limpatela
         Escreval("Deseja jogar alguma de nossas outras opcoes? s/n")
         Leia(outro)
         se outro = "n" entao
            ultimo <- "Campo Minado"
         fimse
      caso 2
         limpatela
         vitoria <- 0
         vitoria2 <- 0
         derrota <- 0
         empate <- 0
         certo <- falso
         ganhou <- falso
         jogada <- 0
         fim <- falso
         escolheBot()
         se (bot = verdadeiro) entao
            jogadasBot()
         senao
            jogadas()
         fimse
         Repita
            Escreval("Deseja jogar novamente? s/n")
            Leia(outra)
            se (outra = "s") entao
               fim <- falso
               escolheBot()
               se (bot = verdadeiro) entao
                  jogadasBot()
               senao
                  jogadas()
               fimse
            fimse
         Ate outra <> "s"
         limpatela
         Escreval("Deseja jogar alguma de nossas outras opcoes? s/n")
         Leia(outro)
         se outro = "n" entao
            ultimo <- "Jogo da Velha"
         fimse
      caso 3
         limpatela
         Escreval("Construido por: Joao Pedro, Giovanna, Raquel, Marcos, Larissa e Cecilia")
      fimescolha
   Ate ((outro <> "s") OU (indice = 3))
   se (indice <> 3) entao
      limpatela
      se (ultimo = "Campo Minado") entao
         Escreval("Seu último jogo jogado foi: ", ultimo, ". Onde você obteve ", vitoria, " vitoria(s) e ", derrota, " derrota(s)")
      fimse
      se (ultimo = "Jogo da Velha") entao
         Escreval("Seu último jogo jogado foi: ", ultimo, ". Onde o jogador1 obteve ", vitoria, " vitoria(s) e ", derrota, " derrota(s) para a maquina")
         Escreval("Além de ", empate, " empate(s)")
         Escreval("Onde o jogador1 obteve ", vitoria, " vitoria(s) e o jogador2 ", vitoria2, " vitoria(s)")
      fimse
      se (vitoria > derrota) entao
         se (vitoria > vitoria2) entao
            Escreval("Parabéns pelo desempenho, jogador 1!")
         senao
            Escreval("Parabéns pelo desempenho, jogador 2!")
         fimse
      fimse
      Escreval("Construido por: Joao Pedro, Giovanna, Raquel, Marcos")
      Escreval("Obrigado por jogar conosco")
   fimse
fimalgoritmo