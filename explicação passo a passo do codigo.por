// Declaração do início de um programa em Portugol.
// Todo código em Portugol deve estar dentro desta estrutura.
programa { 

  // Inclusão da biblioteca 'Texto'.
  // Esta biblioteca fornece funções úteis para manipular cadeias de caracteres (strings),
  // como obter o número de caracteres de uma string, extrair um caractere específico, etc.
  inclua biblioteca Texto

  // Inclusão da biblioteca 'Tipos'.
  // Esta biblioteca é crucial para realizar conversões entre diferentes tipos de dados,
  // como converter um caractere que representa um número ('0', '1', etc.) para o seu valor inteiro (0, 1, etc.).
  inclua biblioteca Tipos 

  // Definição da função principal do programa.
  // A execução do programa sempre começa dentro desta função 'inicio()'.
  funcao inicio() {
    
    // Declaração de uma variável do tipo 'cadeia' (string).
    // 'cpf_str' será usada para armazenar o CPF que o usuário digitar, como uma sequência de caracteres.
    cadeia cpf_str
    
    // Declaração de uma variável do tipo 'inteiro'.
    // 'soma' será usada para acumular os resultados das multiplicações dos dígitos do CPF pelos pesos.
    inteiro soma
    
    // Declaração de uma variável do tipo 'inteiro'.
    // 'resto' armazenará o resto da divisão da 'soma' por 11, que é fundamental para calcular os dígitos verificadores.
    inteiro resto
    
    // Declaração de uma variável do tipo 'inteiro'.
    // 'primeiro_digito_calculado' guardará o valor do primeiro dígito verificador (D1) após o cálculo.
    inteiro primeiro_digito_calculado
    
    // Declaração de uma variável do tipo 'inteiro'.
    // 'segundo_digito_calculado' guardará o valor do segundo dígito verificador (D2) após o cálculo.
    inteiro segundo_digito_calculado
    
    // Declaração de uma variável auxiliar do tipo 'inteiro'.
    // 'digito_numerico_atual' será usada temporariamente dentro dos laços para armazenar o valor numérico
    // de cada dígito do CPF à medida que ele é processado.
    inteiro digito_numerico_atual 

    // A função 'escreva' é usada para exibir mensagens na tela para o usuário.
    // Aqui, ela solicita que o usuário digite o CPF.
    escreva("Digite seu CPF (apenas os números, 11 dígitos): ")
    
    // A função 'leia' é usada para ler a entrada do usuário do teclado.
    // O valor digitado pelo usuário será armazenado na variável 'cpf_str'.
    leia(cpf_str)

    // O comentário abaixo indica o início da primeira parte da validação:
    // A verificação do formato inicial do CPF.
    // --- PARTE 1: VERIFICAÇÃO INICIAL DO FORMATO ---

    // 1.1. Esta é a primeira verificação de formato.
    // A função 'Texto.numero_caracteres(cpf_str)' retorna a quantidade de caracteres na string 'cpf_str'.
    // A condição '!=' verifica se essa quantidade NÃO é igual a 11.
    se (Texto.numero_caracteres(cpf_str) != 11) {
      // Se a condição acima for verdadeira (o CPF não tem 11 dígitos),
      // esta mensagem de erro é exibida.
      escreva("CPF inválido: Deve conter exatamente 11 dígitos.\n")
      // A instrução 'retorne' encerra a execução da função 'inicio()' imediatamente.
      // Isso significa que o programa para aqui se o CPF tiver um número incorreto de dígitos.
      retorne 
    } // Fim do bloco 'se' para a verificação do número de caracteres.

    // 1.2. Esta é a segunda verificação de formato.
    // Este laço 'para' (for) irá percorrer cada caractere da string 'cpf_str'.
    // 'i' começa em 0 (primeiro caractere), vai até o número total de caracteres - 1.
    para (inteiro i = 0; i < Texto.numero_caracteres(cpf_str); i++) {
      // A função 'Texto.obter_caracter(cpf_str, i)' extrai o caractere na posição 'i' da string 'cpf_str'.
      // Esse caractere é armazenado na variável 'char_atual' do tipo 'caracter'.
      caracter char_atual = Texto.obter_caracter(cpf_str, i)
      
      // A condição 'se (nao (char_atual >= '0' e char_atual <= '9'))' verifica se 'char_atual' NÃO está no intervalo de '0' a '9'.
      // Em Portugol, assim como em muitas linguagens, podemos comparar caracteres baseados em sua ordem na tabela ASCII/Unicode.
      // Ou seja, '0' é menor que '1', que é menor que '2', e assim por diante até '9'.
      // Se 'char_atual' for uma letra, um símbolo ou qualquer coisa fora desse intervalo, a condição será verdadeira.
      se (nao (char_atual >= '0' e char_atual <= '9')) {
        // Se a condição acima for verdadeira (encontrou um caractere não numérico),
        // esta mensagem de erro é exibida.
        escreva("CPF inválido: Deve conter apenas números de 0 a 9.\n")
        // Novamente, 'retorne' encerra o programa, pois o CPF é inválido.
        retorne 
      } // Fim do bloco 'se' para a verificação de caracteres numéricos.
    } // Fim do laço 'para' que verifica todos os caracteres.

    // O comentário abaixo indica o início da segunda parte da validação:
    // O algoritmo de validação do Módulo 11, que calcula e verifica os dígitos verificadores.
    // --- PARTE 2: VALIDAÇÃO USANDO O ALGORITMO DO MÓDULO 11 ---

    // 2.1. Início do cálculo para o Primeiro Dígito Verificador (D1).
    // Zera a variável 'soma' para um novo cálculo.
    soma = 0
    
    // Este laço 'para' calcula a soma ponderada dos 9 primeiros dígitos do CPF para o D1.
    // Ele itera de 'i = 0' a 'i = 8' (total de 9 dígitos).
    // Multiplicar os nove primeiros dígitos por pesos decrescentes de 10 a 2.
    para (inteiro i = 0; i < 9; i++) {
      // Esta é uma conversão crucial e confiável:
      // 1. 'Texto.obter_caracter(cpf_str, i)' pega o caractere do CPF na posição 'i'. (Ex: se cpf_str é "123..." e i é 0, pega '1')
      // 2. 'Tipos.caracter_para_inteiro(...)' converte o caractere ('1') para o seu valor inteiro na tabela ASCII/Unicode.
      // 3. 'Tipos.caracter_para_inteiro('0')' faz o mesmo para o caractere '0'.
      // 4. A subtração 'valor_do_char - valor_do_char_zero' converte o caractere dígito no seu valor numérico real.
      //    Ex: ('1' em ASCII é 49) - ('0' em ASCII é 48) = 1.
      //    Ex: ('9' em ASCII é 57) - ('0' em ASCII é 48) = 9.
      // O resultado é armazenado em 'digito_numerico_atual'.
      digito_numerico_atual = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, i)) - Tipos.caracter_para_inteiro('0')
      
      // Adiciona ao 'soma' o produto do 'digito_numerico_atual' pelo peso correspondente.
      // O peso é '10 - i'.
      // Quando i=0, peso=10. Quando i=1, peso=9, ..., Quando i=8, peso=2.
      soma += digito_numerico_atual * (10 - i) 
    } // Fim do laço 'para' do D1.

    // Calcular o resto da divisão da soma por 11.
    // O operador '%' (módulo) retorna o resto de uma divisão.
    resto = soma % 11

    // Determinar o Primeiro Dígito Verificador (D1) com base no 'resto'.
    // Se o resto da divisão for menor que 2 (ou seja, 0 ou 1),
    // o dígito verificador é 0.
    se (resto < 2) {
      primeiro_digito_calculado = 0
    } 
    // Caso contrário (se o resto for de 2 a 10),
    // o dígito verificador é 11 menos o valor do resto.
    senao {
      primeiro_digito_calculado = 11 - resto
    } // Fim do bloco 'se-senao' para calcular D1.

    // Compara o primeiro dígito verificador calculado (D1) com o décimo dígito (índice 9) do CPF de entrada.
    // Primeiro, extrai o décimo caractere do CPF original e o converte para seu valor numérico.
    inteiro decimo_digito_informado = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, 9)) - Tipos.caracter_para_inteiro('0')
    
    // Se o dígito calculado NÃO for igual ao dígito informado no CPF,
    // significa que o CPF é inválido devido ao primeiro dígito verificador.
    se (primeiro_digito_calculado != decimo_digito_informado) {
      escreva("CPF inválido: Primeiro dígito verificador (D1) incorreto.\n")
      retorne // Encerra o programa.
    } // Fim do bloco 'se' de comparação do D1.

    // 2.2. Início do cálculo para o Segundo Dígito Verificador (D2).
    // Zera novamente a variável 'soma' para um novo cálculo.
    soma = 0
    
    // Este laço 'para' calcula a soma ponderada dos 10 primeiros dígitos (9 primeiros + D1) para o D2.
    // Ele itera de 'i = 0' a 'i = 9' (total de 10 dígitos).
    // Multiplicar esses dez dígitos por pesos decrescentes de 11 a 2.
    para (inteiro i = 0; i < 10; i++) {
      // Condição para decidir qual dígito usar na soma:
      // Se 'i' for menor que 9, significa que estamos pegando um dos 9 primeiros dígitos do CPF original.
      se (i < 9) { 
          // Pega o caractere na posição 'i' do CPF original e o converte para número.
          digito_numerico_atual = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, i)) - Tipos.caracter_para_inteiro('0')
      } 
      // Se 'i' for igual a 9 (que é a posição do décimo dígito no loop),
      // significa que devemos usar o 'primeiro_digito_calculado' (D1).
      senao { 
          digito_numerico_atual = primeiro_digito_calculado
      }
      // Adiciona ao 'soma' o produto do 'digito_numerico_atual' pelo peso correspondente.
      // O peso é '11 - i'.
      // Quando i=0, peso=11. Quando i=1, peso=10, ..., Quando i=9, peso=2.
      soma += digito_numerico_atual * (11 - i) 
    } // Fim do laço 'para' do D2.

    // Calcular o resto da divisão da soma por 11.
    resto = soma % 11

    // Determinar o Segundo Dígito Verificador (D2) com base no 'resto'.
    // Similar ao cálculo do D1: se o resto for menor que 2 (0 ou 1),
    // o dígito verificador é 0.
    se (resto < 2) {
      segundo_digito_calculado = 0
    } 
    // Caso contrário (se o resto for de 2 a 10),
    // o dígito verificador é 11 menos o valor do resto.
    senao {
      segundo_digito_calculado = 11 - resto
    } // Fim do bloco 'se-senao' para calcular D2.

    // Compara o segundo dígito verificador calculado (D2) com o décimo primeiro dígito (índice 10) do CPF de entrada.
    // Primeiro, extrai o décimo primeiro caractere do CPF original e o converte para seu valor numérico.
    inteiro decimo_primeiro_digito_informado = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, 10)) - Tipos.caracter_para_inteiro('0')

    // Se o dígito calculado NÃO for igual ao dígito informado no CPF,
    // significa que o CPF é inválido devido ao segundo dígito verificador.
    se (segundo_digito_calculado != decimo_primeiro_digito_informado) {
      escreva("CPF inválido: Segundo dígito verificador (D2) incorreto.\n")
      retorne // Encerra o programa.
    } // Fim do bloco 'se' de comparação do D2.
    
    // O comentário abaixo indica a última parte do programa:
    // O resultado final, se todas as verificações passaram.
    // --- PARTE 3: RESULTADO FINAL ---
    // Se a execução do programa chegou até aqui, significa que todas as verificações
    // de formato e de dígitos verificadores foram bem-sucedidas.
    // Portanto, o CPF é considerado válido.
    escreva("CPF VÁLIDO.\n")
    
  } // Fim da função 'inicio()'. Todo o código do programa está contido dentro destas chaves.
} // Fim do bloco 'programa'. Encerra a definição do programa em Portugol.