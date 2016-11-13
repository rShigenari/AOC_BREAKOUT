Inicializa:
    li $v1, 0                       # Detecta se o jogo já começou
    
    addi $sp, $sp, -24              # Adiciona espaco na pilha para os parametros a serem passados para as funcoes de desenho (economizando registradores)
    
    ###########Parte da barra##############
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 0($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 280                     # Adiciona a posicao inicial da barra em y
    sw $t8, 4($sp)                  # Adiciona a cor de t8 para a pilha
    li $t8, 50                      # Adiciona a posicao inicial da barra em x
    sw $t8, 8($sp)                  # Adiciona a cor de t8 para a pilha

    #jal Barra                       # Desenha a bola
    
    ###############Parte da bolinha#######
    li $t8, 0x00FFFFFF              # Adiciona a cor branca para t8
    sw $t8, 12($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 266                     # Adiciona a posicao inicial da bolinha em y
    sw $t8, 16($sp)                 # Adiciona a cor de t8 para a pilha
    li $t8, 70                      # Adiciona a posicao inicial da bolinha em x
    sw $t8, 20($sp)                 # Adiciona a cor de t8 para a pilha
    
    jal Bola                        # Desenha a barra
    
    j loop9                         # Inicia o jogo
    
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
    
    
############Move a bolinha#####################
MoverBola:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,-5		     # soma a posição em y	
    addi $t7,$t7,-5		     # soma a posição em x
    blt $t8,37,MoverBolaDown         # Se a bola chegar em y na posicao 37 muda o movimento
    blt $t7,-60,MoverBolaUp          # Se a bola chegar em x na posicao -60 muda o movimento
          
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    
    j MoverBola

############Move a bolinha Up #####################
MoverBolaUp:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
   addi $t8,$t8,-5		     # soma a posição em y	
   addi $t7,$t7,5		     # soma a posição em x
   blt $t8,37,MoverBolaDown 
             
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    
    j MoverBolaUp
   
            
########Movimento de Descida###########
MoverBolaDown:
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"
    li $t8, 0x00000000               # Adiciona a cor preta em t8
    sw $t8, 12($sp)                  # Adiciona t8 para a pilha
    
    jal Bola                         # Pinta a Bolinha de preto
    
    lw   $t8, 16($sp)                # Pega o valor de y da bolinha
    lw   $t7, 20($sp)                # Pega o valor de x da bolinha
    
    addi $t8,$t8,5		     # add em y	
    addi $t7,$t7,5		     # add em x	
    bgt $t8,275,stope		     # para 
         
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    
    j MoverBolaDown
    
                  
stope:
    sw   $t8, 16($sp)                # Adiciona a nova posicao em y da bolinha na pilha
    sw   $t7, 20($sp)                # Adiciona a nova posicao em x da bolinha na pilha
    li   $t8, 0x00FFFFFF             # Adiciona a cor branca para t8
    sw   $t8, 12($sp)                # Adiciona a cor de t8 na pilha
    
    jal Bola                         # Move pra funcao de pintar a bolinha de novo na tela
    
    li $v0,32                        # Chama a funcao sleep
    li $a0, 30                       # Define o tempo para o programa "dormir"
    syscall                          # Manda o programa "dormir"


#############Detecta a entrada###########
DetectaEntrada:
    
    beq $a3, ' ', DetectaInicio      # Enquanto $a3 for igual a 'espaço' mova a bolinha
    j   loop9                        # Se nao for nem 'a', 'd' ou 'espaço' va para o loop
    
    
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
