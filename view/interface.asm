######Regs######
# $t7: posição inicial da barra em x 50
# $t6: posição inicial da barra em y 280
# $k0: posição inicial da bolinha em x 70
# $k1: posição inicial da bolinha em y 266
# $v1: verificador 
######Regs######
.text

li $t6, 280                         # Posicao inicial da barra em y
li $t7, 50                          # Posicao inicial da barra em x

li $k0, 70                          # Posicao inicial da bolinha em x
li $k1, 266                         # Posicao inicial da bolinha em y

li $v1, 0                           # Detecta se o jogo já começou

j Inicializa                        # Inicia os desenhos

######Desenhando varios retangulos#####
######Regs######
# $a2: carrega a cor 
# $s2: posição inicial de x
# $s3: posição inicial de y
# $s4: nova posição inicial
######Regs######

Inicializa:

    li   $a2, 0x00FF0000             # Carregando a cor vermelha para o registrador a2
    li   $s2, 50                     # y0 = y posicao inicial de y
    li   $s3, -95                    # x0 = x posicao inicial de x
    move $s4, $s3                    # posicao inicial do x que sera deslocado

    addi $t8, $s3, 545               # posicao final do retangulo em x
    addi $t9, $s2, 90                # posicao final do retangulo em y

    addi $t4, $s2, 30                # define a fileira que irei mudar para a cor verde
    addi $t5, $s2, 50                # define a fileira que irei mudar para a cor azul

loop3: # primeira fileira

    addi $s4, $s4, 32                # Adiciona no inicio do proximo retangulo (em x)
    blt  $s4, $t8, DesenhaRetangulo  # Enquanto nao chegar no final da tela continue desenhando retangulos
    j    loop4                       # Se chegou no final va para a proxima fileira
    
    
loop4: # segunda fileira

    addi $s2, $s2, 14                # Adiciona no inicio do proximo retangulo (em y)
    move $s4, $s3                    # Reseta o x inicial do retangulo para o x0
    
    bge  $s2, $t4, MudaCorVerde      # Muda a cor dos retangulos para verde
    
    blt  $s2, $t9, DesenhaRetangulo  # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    j    Bola                        # Se chegou va desenhar a barra
    
    
MudaCorVerde:# terceira fileira
    
    li  $a2, 0x0000FF00              # Muda $a2 para verde
    
    bge $s2, $t5, MudaCorAzul        # Muda a cor dos retangulos para azul
    
    blt $s2, $t9, DesenhaRetangulo   # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    j   Bola                         # Se chegou va desenhar a barra
    
    
MudaCorAzul:#quarta fileira

    li  $a2, 0x000000FF              # Muda $a2 para azul
    
    blt $s2, $t9, DesenhaRetangulo   # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    j   Bola                         # Se chegou va desenhar a barra
    

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

    li   $a2, 0x00FFFFFF             # Carregando a cor branca para o registrador a2
    addi $s1, $t6, 0                 # y1 = y posicao final da barra
    addi $s0, $t7, 0                 # x1 = x posicao inicial da barra
 
    addi $t2, $s0, 50                # Limite de x para pintar a barra
    addi $t1, $s1, 5                 # limite de y para pintar a barra
    
    j  loop5                         # Comece a desenhar
    
 
loop5:

   blt $s0, $t2, DrawPixel3          # Enquanto o inicio nao atingiu o limite (100) pinta os pixels em (s0, s1)
   addi $s1, $s1, 1                  # Pula para a proxima linha
   
   
loop6:

    
    move $s0, $t7                    # Reseta o x para o inicio
    
    blt $s1, $t1, DrawPixel3         # Enquanto nao chegou no limite em y continue desenhando
    j   loop9                        # Se chegou termine o programa
 
 
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
    j   Barra                        # Se chegou va para o loop do jogo
 
 
DrawPixel4:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j loop7                          # Volta para o loop de desenho


