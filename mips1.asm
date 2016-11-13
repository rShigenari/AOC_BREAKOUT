.text

li $t6, 280                         # Posicao inicial da barra em y
li $t7, 50                          # Posicao inicial da barra em x

li $k0, 70                          # Posicao inicial da bolinha em x
li $k1, 266                         # Posicao inicial da bolinha em y

li $v1, 0                           # Detecta se o jogo já começou



    
#####Desenhando a bolinha######
Bola:

    li   $a2, 0x00FFFFFF             # Carregando a cor branca para o registrador a2
    move   $s1, $k1                  # y1 = y posicao inicial de y para desenhar a "bolinha"
    move   $s0, $k0                  # x1 = x posicao inicial de x para desenhar a "bolinha"
 
    addi $t2, $s0, 14                # Posicao final de x
    addi $t1, $s1, 12                # Posicao final de y
    
    j    loop7                       # Comece a desenhar
    
 
loop7:

   blt $s0, $t2, DrawPixel4          # Enquanto $s0 nao atingiu o limite (em x) pinta os pixels em (s0, s3)
   j   loop8                         # Finaliza o programa
   
   
loop8:

    addi $s1, $s1, 1                 # Pula para a proxima linha
    move $s0, $k0                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel4         # Enquanto $s1 nao chegou no limite em y continue desenhando
    j  PintaPretoBola                   # Se chegou va para o loop do jogo
 
 
DrawPixel4:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j loop7                          # Volta para o loop de desenho


#################Desenha a bolinha depois de inicializada###############
Bola2:

    li   $a2, 0x00FFFFFF             # Carregando a cor branca para o registrador a2
    move   $s1, $k1                  # y1 = y posicao inicial de y para desenhar a "bolinha"
    move   $s0, $k0                  # x1 = x posicao inicial de x para desenhar a "bolinha"
 
    addi $t2, $s0, 14                # Posicao final de x
    addi $t1, $s1, 12                # Posicao final de y
    
    j    loop15                      # Comece a desenhar
    
 
loop15:

   blt $s0, $t2, DrawPixel7          # Enquanto $s0 nao atingiu o limite (em x) pinta os pixels em (s0, s3)
   j   loop16                        # Finaliza o programa
   
   
loop16:

    addi $s1, $s1, 1                 # Pula para a proxima linha
    move $s0, $k0                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel7         # Enquanto $s1 nao chegou no limite em y continue desenhando
    addi $zero,$zero,0
    j   PintaPretoBola               # Se chegou va para o loop do jogo
 
 
DrawPixel7:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j loop15                          # Volta para o loop de desenho


#############Pinta a barra de preto########
PintaPreto:

    li   $a2, 0x00000000             # Carregando a cor preta para o registrador a2
    addi $s1, $t6, 0                 # y1 = y posicao final da barra
    addi $s0, $t7, 0                 # x1 = x posicao inicial da barra
 
    addi $t2, $s0, 50                # Limite de x para pintar a barra
    addi $t1, $s1, 5                 # limite de y para pintar a barra
    
    j  loop10                         # Comece a desenhar
    
 
loop10:

   blt $s0, $t2, DrawPixel5          # Enquanto o inicio nao atingiu o limite (100) pinta os pixels em (s0, s1)
   addi $s1, $s1, 1                  # Pula para a proxima linha
   
loop11:

    
    move $s0, $t7                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel5         # Enquanto nao chegou no limite em y continue desenhando
    j   DetectaMovimento             # Se chegou va ver para qual lado deve-se mover a barra
 
 
DrawPixel5:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j     loop10                     # Volta para o loop de desenho
    
    
#####Pinta a bolinha de preto######
PintaPretoBola:

    li     $a2, 0x00000000           # Carregando a cor preta para o registrador a2
    move   $s1, $k1                  # y1 = y posicao inicial de y para desenhar a "bolinha"
    move   $s0, $k0                  # x1 = x posicao inicial de x para desenhar a "bolinha"
 
    addi $t2, $s0, 14                # Posicao final de x
    addi $t1, $s1, 12                # Posicao final de y
    j    loop12                      # Comece a desenhar
    
 
loop12:

   blt $s0, $t2, DrawPixel6          # Enquanto $s0 nao atingiu o limite (em x) pinta os pixels em (s0, s3)
   j   loop13                        # Finaliza o programa
   
   
loop13:

    addi $s1, $s1, 1                 # Pula para a proxima linha
    move $s0, $k0                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel6         # Enquanto $s1 nao chegou no limite em y continue desenhando
    j   MoverBola                    # Se chegou va para o loop do jogo
 
 
DrawPixel6:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j loop12                         # Volta para o loop de desenho
    
    
#############Detecta a entrada###########
DetectaEntrada:
    
    beq $a3, ' ', DetectaInicio      # Enquanto $a3 for igual a 'espaço' mova a bolinha
    beq $a3, 'a', PintaPreto         # Se for 'a' eh para mover a barra
    beq $a3, 'd', PintaPreto         # Se for 'd' tambem move a barra
    j   loop9                        # Se nao for nem 'a', 'd' ou 'espaço' va para o loop
    
    
DetectaMovimento:
    j loop9
    
############Move a bolinha#####################
MoverBola:
    subi $k1, $k1, 5                 # Move a bolinha em 1 em y
    j Bola2                          # Move pra funcao de pintar a bolinha de novo na tela
    
#############Verifica se o jogo ja comecou##########
DetectaInicio:
    beq $v1, 0, SetaInicio          # Se o jogo ainda nao começou entao va setar $v1 para 1 e iniciar o jogo
    j loopBola
    
SetaInicio:
    li $v1, 1                       # Seta a variavel de controle para joga iniciado
    j PintaPretoBola                # Va pintar a bolinha

loopBola:
	j PintaPretoBola

#############Loop do jogo##########
loop9:

    ######Le da entrada padrao um caracter######
    li $v0, 12                       # Da load no registrador $v0 com o codigo de ler_caracter
    syscall

    move $a3, $v0                    # Move a mensagem do display (caracter lido) para $a0
    
    j DetectaEntrada                 # Va pintar a barra de preto


