.text

######Desenhando um retangulo#####

li $a2, 0x00FF0000  # Carregando a cor vermelha para o registrador a2
li $s3, 50          # y1 = y posicao inicial de y
li $s0, -60         # x1 = x posicao inicial de x
 
addi $t6, $s0, 50   # Posicao final de x
addi $t7, $s3, 10   # Posicao final de y

loop:
   blt $s0, $t6, DrawPixel # Enquanto x1 ainda nao atingiu o limite (t6) pinte o pixel (s0,s1)
   addi $s3, $s3, 1        # Quando x1 chegar no limite (t6) adiciona 1 em y1 (pula linha)
   
 
loop2:
   li $s0, -60             # Reseta x1 para o inicio
 
   blt $s3, $t7, DrawPixel # Enquanto y1 nao atingiu o limite (t7) pinte o pixel (s0, s1)
   j Barra                 # Quando terminar o retangulo va desenhar a barra

 
DrawPixel:
 
    addi $s0, $s0, 1         # Adiciona 1 em x inicial
    li $t3, 0x10000100       # t3 = primeiro pixel da tela
 
    sll   $t0, $s3, 9        # y = y * 512
    addu  $t0, $t0, $s0      # (xy) t0 = x + y
    sll   $t0, $t0, 2        # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0      # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)         # Coloca a cor vermelha (a2) em t0

    j loop                   # Volta para o loop de desenho


######Desenhando a barra#########
Barra:

    li $a2, 0x00FFFFFF  # Carregando a cor branca para o registrador a2
    li $s1, 280         # y1 = y posicao final da barra
    li $s0, 50          # x1 = x posicao inicial da barra
 
    li $t6, 100         # Limite de x para pintar a barra
    j loop3
 
loop3:

   blt $s0, $t6, DrawPixel3 # Enquanto o inicio nao atingiu o limite (100) pinta os pixels em (s0, s1)
   j end                    # Finaliza o programa
 
DrawPixel3:
 
    addi $s0, $s0, 1         # Adiciona 1 em x inicial
    li $t3, 0x10000100       # t3 = primeiro pixel da tela
 
    sll   $t0, $s1, 9        # y = y * 512
    addu  $t0, $t0, $s0      # (xy) t0 = x + y
    sll   $t0, $t0, 2        # (xy) t0 = xy * 4
    addu  $t0, $t3, $t0      # Adiciona xy ao primeiro pixel ( t3 )
    sw    $a2, ($t0)         # Coloca a cor branca ($a2) em $t0

    j loop3                  # Volta para o loop de desenho

end:

    ####Sai do programa########
    li $v0, 10
    syscall
