.text

######Desenho de varios retangulos#####

li $a2, 0x00FF0000                   # Carregando a cor vermelha para o registrador a2
li $s4, 50                           # y0 = y posicao inicial de y
li $s6, -95                          # x0 = x posicao inicial de x
addi $s5, $s6, 0                     # posicao inicial do x que sera deslocado

addi $t8, $s5, 545                   # posicao final do retangulo em x
addi $t9, $s4, 90                    # posicao final do retangulo em y

addi $t1, $s4, 30                    # define a fileira que irei mudar para a cor verde
addi $t2, $s4, 50                    # define a fileira que irei mudar para a cor azul

loop3:

    addi $s5, $s5, 32                # Adiciona no inicio do proximo retangulo (em x)
    
    blt $s5, $t8, DesenhaRetangulo   # Enquanto nao chegar no final da tela continue desenhando retangulos
    j loop4                          # Se chegou no final va para a proxima fileira
    
    
loop4:

    addi $s4, $s4, 15                # Adiciona no inicio do proximo retangulo (em y)
    addi $s5, $s6, 0                 # Reseta o x inicial do retangulo para o x0
    
    bge  $s4, $t1, MudaCorVerde      # Muda a cor dos retangulos para verde
    
    blt $s4, $t9, DesenhaRetangulo   # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    j Barra                          # Se chegou va desenhar a barra
    
    
MudaCorVerde:
    
    li $a2, 0x0000FF00               # Muda $a2 para verde
    
    bge $s4, $t2, MudaCorAzul        # Muda a cor dos retangulos para azul
    
    blt $s4, $t9, DesenhaRetangulo   # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    j Barra                          # Se chegou va desenhar a barra
    
    
MudaCorAzul:

    li $a2, 0x000000FF               # Muda $a2 para azul
    
    blt $s4, $t9, DesenhaRetangulo   # Enquanto nao chegar no final das fileiras continue desenhando retangulos
    j Barra                          # Se chegou va desenhar a barra
    

######Desenhando um retangulo#####

DesenhaRetangulo:

    addi $s3, $s4, 0                 # y1 = y posicao inicial de y para desenhar o retangulo
    addi $s0, $s5, 0                 # x1 = x posicao inicial de x para desenhar o retangulo
 
    addi $t6, $s0, 28                # Posicao final de x
    addi $t7, $s3, 10                # Posicao final de y

    j loop
    

loop:

   blt $s0, $t6, DrawPixel           # Enquanto x1 ainda nao atingiu o limite (t6) pinte o pixel (s0,s1)
   addi $s3, $s3, 1                  # Quando x1 chegar no limite (t6) adiciona 1 em y1 (pula linha)
   
 
loop2:

   addi $s0, $s5, 0                  # Reseta x1 para o inicio
 
   blt $s3, $t7, DrawPixel           # Enquanto y1 nao atingiu o limite (t7) pinte o pixel (s0, s1)
   j loop3                           # Quando terminar o retangulo va desenhar a barra

 
DrawPixel:
 
    addi $s0, $s0, 1                 # Adiciona 1 em x inicial
    li $t3, 0x10000100               # t3 = primeiro pixel da tela
 
    sll   $t0, $s3, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor de (a2) em t0

    j loop                           # Volta para o loop de desenho


######Desenhando a barra#########
Barra:

    li $a2, 0x00FFFFFF               # Carregando a cor branca para o registrador a2
    li $s1, 280                      # y1 = y posicao final da barra
    li $s0, 50                       # x1 = x posicao inicial da barra
 
    li $t6, 100                      # Limite de x para pintar a barra
    li $t7, 285                      # limite de y para pintar a barra
    j  loop5                         # Comece a desenhar
    
 
loop5:

   blt $s0, $t6, DrawPixel3          # Enquanto o inicio nao atingiu o limite (100) pinta os pixels em (s0, s1)
   j   loop6                         # Finaliza o programa
   
   
loop6:

    addi $s1, $s1, 1                 # Pula para a proxima linha
    li   $s0, 50                     # Reseta o x para o inicio
    
    blt $s1, $t7, DrawPixel3         # Enquanto nao chegou no limite em y continue desenhando
    j   Bola                         # Se chegou termine o programa
 
 
DrawPixel3:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j loop5                          # Volta para o loop de desenho
    
    
#####Desenha a bolinha######

Bola:

    li $a2, 0x00FFFFFF               # Carregando a cor branca para o registrador a2
    li $s1, 266                       # y1 = y posicao inicial de y para desenhar a "bolinha"
    li $s0, 70                       # x1 = x posicao inicial de x para desenhar a "bolinha"
 
    addi $t6, $s0, 14                # Posicao final de x
    addi $t7, $s1, 12                # Posicao final de y
    
    j  loop7                         # Comece a desenhar
    
 
loop7:

   blt $s0, $t6, DrawPixel4          # Enquanto $s0 nao atingiu o limite (em x) pinta os pixels em (s0, s3)
   j   loop8                         # Finaliza o programa
   
   
loop8:

    addi $s1, $s1, 1                 # Pula para a proxima linha
    li   $s0, 70                     # Reseta o x para o inicio
    
    blt $s1, $t7, DrawPixel4         # Enquanto $s1 nao chegou no limite em y continue desenhando
    j   end                          # Se chegou termine o programa
 
 
DrawPixel4:
 
    addi  $s0, $s0, 1                # Adiciona 1 em x inicial
    li    $t3, 0x10000100            # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9                # y = y * 512
    addu  $t0, $t0, $s0              # (xy) t0 = x + y
    sll   $t0, $t0, 2                # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0              # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)                 # Coloca a cor branca ($a2) em $t0

    j loop7                          # Volta para o loop de desenho


end:

    ####Sai do programa########
    li $v0, 10
    syscall
