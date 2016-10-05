.text
 
li $a2, 0x00FFFFFF  # Carregando a cor branca para o registrador a2
li $s3, 280         # y1 = y posicao final da barra
li $s0, 50          # x1 = x posicao inicial da barra
 
li $t6, 100         # Limite de x para pintar a barra
 
loop:
   blt $s0, $t6, DrawPixel # Enquanto o inicio nao atingiu o limite (100) pinto os pixels em (s0, s1)
   j end # finaliza o programa
 
DrawPixel:
 
addi $s0, $s0, 1         # Adiciona 1 em x inicial
li $t3, 0x10000100       # t3 = primeiro pixel da tela
 
sll   $t0, $s3, 9        # y = y * 512
addu  $t0, $t0, $s0      # (xy) t0 = x + y
sll   $t0, $t0, 2        # (xy) t0 = xy * 4
addu  $t0, $t3, $t0      # Adiciona xy ao primeiro pixel ( t3 )
sw    $a2, ($t0)         # Coloca a cor branca ($a2) em $t0
 

j loop                   # Volta para o loop de desenho

end:
 
    ####Sai do programa########
    li $v0, 10
    syscall