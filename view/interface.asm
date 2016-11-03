.text

Inicializa:
    jal InicializaRetangulos        # Desenha os Retangulos
    li $v1, 0                       # Detecta se o jogo já começou
    
    addi $sp, $sp, -24              # Adiciona espaco na pilha para os parametros a serem passados para as funcoes de desenho (economizando registradores)
    
    ###########Parte da barra##############
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 0($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 280                     # Adiciona a posicao inicial da barra em y
    sw $t8, 4($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 50                      # Adiciona a posicao inicial da barra em x
    sw $t8, 8($sp)                  # Adiciona a cor de t8 para a pilha

    jal Barra                       # Desenha a bola
    
    ###############Parte da bolinha#######
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 266                     # Adiciona a posicao inicial da bolinha em y
    sw $t8, 16($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 70                      # Adiciona a posicao inicial da bolinha em x
    sw $t8, 20($sp)                 # Adiciona a cor de t8 para a pilha
    
    jal Bola                        # Desenha a barra
    
    j loop9                         # Inicia o jogo

######Desenhando varios retangulos#####
InicializaRetangulos:

    li   $a2, 0x00FF0000             # Carregando a cor vermelha para o registrador a2
    li   $s2, 50                     # y0 = y posicao inicial de y
    li   $s3, -95                    # x0 = x posicao inicial de x
    move $s4, $s3                    # posicao inicial do x que sera deslocado

    addi $t8, $s3, 545               # posicao final do retangulo em x
    addi $t9, $s2, 90                # posicao final do retangulo em y

    addi $t4, $s2, 30                # define a fileira que irei mudar para a cor verde
    addi $t5, $s2, 60                # define a fileira que irei mudar para a cor azul

loop3:

    addi $s4, $s4, 32                # Adiciona no inicio do proximo retangulo (em x)
    
    blt  $s4, $t8, DesenhaRetangulo  # Enquanto nao chegar no final da tela continue desenhando retangulos
    j    loop4                       # Se chegou no final va para a proxima fileira
    
    
loop4:

    addi $s2, $s2, 14                # Adiciona no inicio do proximo retangulo (em y)
    move $s4, $s3                    # Reseta o x inicial do retangulo para o x0
    
    bge  $s2, $t4, MudaCorVerde      # Muda a cor dos retangulos para ou verde ou azul
    
    blt  $s2, $t9, DesenhaRetangulo  # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    jr   $ra                         # Se chegou retorna pra quem chamou
    
MudaCorVerde:
    
    li  $a2, 0x0000FF00              # Muda $a2 para verde
    
    bge $s2, $t5, MudaCorAzul        # Muda a cor dos retangulos para azul
    
    blt $s2, $t9, DesenhaRetangulo   # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    jr  $ra                          # Se chegou va desenhar a barra
    
    
MudaCorAzul:

    li  $a2, 0x000000FF              # Muda $a2 para azul
    
    blt $s2, $t9, DesenhaRetangulo   # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    jr  $ra                         # Se chegou va desenhar a barra
    

######Desenhando um retangulo#####

DesenhaRetangulo:

    move $s1, $s2                    # y1 = y posicao inicial de y para desenhar o retangulo
    move $s0, $s4                    # x1 = x posicao inicial de x para desenhar o retangulo
 
    addi $t2, $s0, 28                # Posicao final de x
    addi $t1, $s1, 10                # Posicao final de y

    j    loop
    

loop:

   blt  $s0, $t2, DrawPixel          # Enquanto x1 ainda nao atingiu o limite (t0) pinte o pixel (s0,s1)
   addi $s1, $s1, 1                  # Quando x1 chegar no limite (t0) adiciona 1 em y1 (pula linha)
   j loop2
   
 
loop2:

   move $s0, $s4                     # Reseta x1 para o inicio
 
   blt  $s1, $t1, DrawPixel          # Enquanto y1 nao atingiu o limite (t1) pinte o pixel (s0, s1)
   j    loop3                        # Quando terminar o retangulo va desenhar o proxima retangulo

 
DrawPixel:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor de (a2) em t0

    j     loop                       # Volta para o loop de desenho


######Desenhando a barra#########
Barra:

    lw $a2, 0($sp)                    # Carregando a cor branca para o registrador a2
    lw $s1, 4($sp)                    # y1 = y posicao final da barra
    lw $s0, 8($sp)                    # x1 = x posicao inicial da barra
    
    move $t8, $s0
 
    addi $t2, $s0, 50                # Limite de x para pintar a barra
    addi $t1, $s1, 5                 # limite de y para pintar a barra
    
    j  loop5                         # Comece a desenhar
    
 
loop5:

   blt $s0, $t2, DrawPixel3          # Enquanto o inicio nao atingiu o limite (100) pinta os pixels em (s0, s1)
   addi $s1, $s1, 1                  # Pula para a proxima linha
   
   
loop6:

    
    move $s0, $t8                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel3         # Enquanto nao chegou no limite em y continue desenhando
    jr  $ra                          # Se chegou termine o programa
 
 
DrawPixel3:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j     loop5                      # Volta para o loop de desenho
    
    
#####Desenhando a bolinha######
Bola:

    lw $a2, 12($sp)                  # Carregando a cor branca para o registrador a2
    lw $s1, 16($sp)                  # y1 = y posicao inicial de y para desenhar a "bolinha"
    lw $s0, 20($sp)                  # x1 = x posicao inicial de x para desenhar a "bolinha"
    
    move $t8, $s0
 
    addi $t2, $s0, 14                # Posicao final de x
    addi $t1, $s1, 12                # Posicao final de y
    
    j    loop7                       # Comece a desenhar
    
 
loop7:

   blt $s0, $t2, DrawPixel4          # Enquanto $s0 nao atingiu o limite (em x) pinta os pixels em (s0, s3)
   j   loop8                         # Finaliza o programa
   
   
loop8:

    addi $s1, $s1, 1                 # Pula para a proxima linha
    move $s0, $t8                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel4         # Enquanto $s1 nao chegou no limite em y continue desenhando
    jr  $ra                          # Se chegou va para o loop do jogo
 
 
DrawPixel4:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j loop7                          # Volta para o loop de desenho
    
#############Detecta a entrada###########
DetectaEntrada:
    
    beq $a3, ' ', DetectaInicio      # Enquanto $a3 for igual a 'espaço' mova a bolinha
    beq $a3, 'a', MoverEsquerda      # Se for 'a' eh para mover a barra para a esquerda
    beq $a3, 'd', MoverDireita       # Se for 'd' tambem move a barra para a direita
    j   loop9                        # Se nao for nem 'a', 'd' ou 'espaço' va para o loop
    
    
############Move a bolinha#####################
MoverBola:
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    subi $t8, $t8, 7                 # Adiciona 1 na posicao em y da bolinha
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    j loop9
    
#############Move a barra Para a Esquerda#######
MoverEsquerda:
    
    lw   $t7, 8($sp)                 # Pega o valor de y da barra
    blt  $t7, -55, loop9             # Se chegou no limite da tela pela esquerda nao mova
    
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 0($sp)                   # Adiciona t8 para a pilha
    
    jal Barra                        # Pinta a Barra de preto
    
    subi $t7, $t7, 7                 # Adiciona 1 na posicao em y da barra
    sw   $t7, 8($sp)                 # Adiciona a nova posicao em y da barra na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 0($sp)                 # Adiciona a cor de t8 na pilha
    
    jal Barra                        # Move pra funcao de pintar a barra de novo na tela
    j loop9
    
    
#############Move a barra Para a Direita#######
MoverDireita:
    lw   $t7, 8($sp)                 # Pega o valor de y da barra
    bgt  $t7, 386, loop9             # Se chegou no limite da tela pela direita nao mova
    
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 0($sp)                   # Adiciona t8 para a pilha
    
    jal Barra                        # Pinta a Barra de preto
    
    addi $t7, $t7, 7                 # Adiciona 1 na posicao em y da barra
    sw   $t7, 8($sp)                 # Adiciona a nova posicao em y da barra na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 0($sp)                 # Adiciona a cor de t8 na pilha
    
    jal Barra                        # Move pra funcao de pintar a barra de novo na tela
    j loop9


#############Verifica se o jogo ja comecou##########
DetectaInicio:
    beq $v1, 0, SetaInicio          # Se o jogo ainda nao começou entao va setar $v1 para 1 e iniciar o jogo
    j loop9
    
SetaInicio:
    li $v1, 1                       # Seta a variavel de controle para joga iniciado
    j MoverBola                     # Va mover a bolinha

#############Loop do jogo##########
loop9:

    ######Le da entrada padrao um caracter######
    li $v0, 12                       # Da load no registrador $v0 com o codigo de ler_caracter
    syscall

    move $a3, $v0                    # Move a mensagem do display (caracter lido) para $a0
    
    j DetectaEntrada                 # Va tratar a entrada
