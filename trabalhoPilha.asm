.data
 mostrarMenu: .asciiz "\n1 Input numero inteiro \n* Multiplicação \n/ Divisao\n+ Soma \n- Subtração\n6 Sair do loop\nQual sua escolha: \n"
 mensagemInput: .asciiz "\ninforme o numero para quardar na pilha: "
 resultado: .asciiz "\n Resultado: "

.text
  .main:
  li $s0,49 # CODIGO D0 1 NA TABELA ASCI       
  li $s1,42 # CODIGO DA MULTIPLICACAO NA TABELA ASCII                    
  li $s2,47 # CODIGO DA DIVISAO NA TABELA ASCII
  li $s3,43 # CODIGO DA SOMA NA TABELA ASCII
  li $s4,45 # CODIGO DA SUBTRACAO NA TABELA ASCII
  li $s5,54 # CODIGO DO 6 NA TABELA ASCII (ESTOU USANDO PARA SAIR DO LOOP)
  
  li $t0,0  # REGISTRADOR $T0 VAI SER OQUE O USUARIO ESCOLHER 

  inicio:
  beq $t0,$s5,final  # EQUANTO O $T0 FOR DIFERENTE DO CODIGO 6 O LOOP CONTINUA
  
  la $a0,mostrarMenu # IMPRIMINDO O MENU DE OPCAO
  jal imprimirString
  
  jal leituraCaracter # LENDO A OPCAO DO USARIO VIA TECLADO 
  
  move $t0,$v0  # MOVENDO A RESPOSTA DA FUNCAO EM $V0 PARA O REGISTRADOR $T0
  
  beq $t0,$s0,inputNumero    # verificando se a escolha do usuario foi entrar com numeros inteiros via teclado
  beq $t0,$s1,realizarMultiplicacao  # verificando se a escolha do usuario foi realizar multiplicacao
  beq $t0,$s2,realizarDivisao  # verificando se a escolha do usuario foi realizar divisao
  beq $t0,$s3,realizarSoma  # verificando se a escolha do usuario foi realizar soma
  beq $t0,$s4,realizarSubtracao # verificando se a escolha do usuario foi realizar subtracao
    
  final:                               # final do loop caso o usuario escolha a opcao 6
  li $v0,10                            # finaliza o programa
  syscall   

                
  
  realizarSubtracao:     # caso a esolha do usuario foi realizar subtracao 
  la $a0,resultado 
  jal imprimirString     # chama a funcao que vai imprimir a mensagem 'resultado: '
  jal desempilharPilha   # desempilha o valor do topo da pilha
  move $a0, $v0          # move esse valor que veio no retorno da funcao para $a0
  jal desempilharPilha   # desempilha o novamente valor do topo da pilha
  move $a1, $v0          # move  esse valor que veio no retorno da funcao para $a1
  jal  subtracao         # realiza a subtracao com os valores $a0 e $a1 como parametros da funcao
  move $a0, $v0          # pega o retorno da funcao subtracao e move para o registrador $a0
  jal empilharPilha      # empilha o valor contido em $a0 na pilha 
  jal imprimirInteiro    # imprimir o valor contido em $a0 na tela
  j inicio               # volta pro inicio do loop
  
  
  realizarDivisao:      # caso a esolha do usuario foi realizar divisao
  la $a0,resultado
  jal imprimirString    # chama a funcao que vai imprimir a mensagem 'resultado: '
  jal desempilharPilha  # desempilha o valor do topo da pilha
  move $a0, $v0         # move esse valor que veio no retorno da funcao para $a0
  jal desempilharPilha  # desempilha o novamente valor do topo da pilha
  move $a1, $v0         # move  esse valor que veio no retorno da funcao para $a1
  jal  divisao          # realiza a divisao com os valores $a0 e $a1 como parametros da funcao
  move $a0, $v0         # pega o retorno da funcao divisao e move para o registrador $a0
  jal empilharPilha     # empilha o valor contido em $a0 na pilha 
  jal imprimirInteiro   # imprimir o valor contido em $a0 na tela
  j inicio              # volta pro inicio do loop

  
  realizarMultiplicacao:  # caso a esolha do usuario foi realizar multiplicacao
  la $a0,resultado 
  jal imprimirString     # chama a funcao que vai imprimir a mensagem 'resultado: '
  jal desempilharPilha   # desempilha o valor do topo da pilha
  move $a0, $v0          # move esse valor que veio no retorno da funcao para $a0
  jal desempilharPilha   # desempilha o novamente valor do topo da pilha
  move $a1, $v0          # move  esse valor que veio no retorno da funcao para $a1
  jal multiplicacao      # realiza a multiplicacao com os valores $a0 e $a1 como parametros da funcao
  move $a0, $v0          # pega o retorno da funcao multiplicacao e move para o registrador $a0
  jal empilharPilha      # empilha o valor contido em $a0 na pilha 
  jal imprimirInteiro    # imprimir o valor contido em $a0 na tela
  j inicio               # volta pro inicio do loop
  
  realizarSoma:          # caso a esolha do usuario foi realizar soma
  la $a0,resultado
  jal imprimirString     # chama a funcao que vai imprimir a mensagem 'resultado: '
  jal desempilharPilha   # desempilha o valor do topo da pilha
  move $a0, $v0          # move esse valor que veio no retorno da funcao para $a0
  jal desempilharPilha   # desempilha o novamente valor do topo da pilha
  move $a1, $v0          # move  esse valor que veio no retorno da funcao para $a1
  jal soma               # realiza a soma com os valores $a0 e $a1 como parametros da funcao
  move $a0, $v0          # pega o retorno da funcao soma e move para o registrador $a0
  jal empilharPilha      # empilha o valor contido em $a0 na pilha 
  jal imprimirInteiro    # imprimir o valor contido em $a0 na tela
  j inicio               # volta pro inicio do loop
  
  inputNumero:           # caso a esolha do usuario foi entrar com numeros inteiros via teclado
  li $v0,4
  la $a0,mensagemInput   # chamo a mensagem de input
  syscall
  li $v0,5               # leio o valor via teclado
  syscall
  move $a0,$v0           # pego o retorno do $v0 para $a0
  jal empilharPilha      # e empilho o valor contido no $a0 na pilha
  j inicio               # volta pro inicio do loop

  
 #Funcoes 
 
 empilharPilha: # funcao que empilha na pilha
 addi $sp, $sp,-4
 sw $a0, 0($sp)
 jr $ra
 
 desempilharPilha: # funcao que desempilha na pilha
 lw $v0, 0($sp)
 addi $sp, $sp,4
 jr $ra
 
 
 soma:  # funcao de soma
 add $v0,$a0,$a1
 jr $ra
 
 subtracao: # funcao de subtracao
 sub $v0,$a1,$a0
 jr $ra
 
 divisao:  # funcao de divisao
 div $a1,$a0
 mflo $v0
 jr $ra
  
 multiplicacao:  # funcao de multiplicacao
 mult $a0,$a1
 mflo $v0
 jr $ra
  
 imprimirString:  # funcao de imprimir String
 li $v0,4
 syscall
 jr $ra
 
 imprimirInteiro: # funcao de imprimirInteiro
 li $v0,1
 syscall
 jr $ra
 
 leituraCaracter: # funcao de leitura de caracter + - / * ( CODIGO DO 1 E 6 NA TABELA ASCII)
 li $v0,12
 syscall
 jr $ra
 
 
 
 
 
