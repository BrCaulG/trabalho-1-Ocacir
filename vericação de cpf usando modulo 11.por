programa {
  inclua biblioteca Texto
  inclua biblioteca Tipos // Usaremos para a conversão de caracter para inteiro de forma segura

  funcao inicio() {
    cadeia cpf_str
    inteiro soma
    inteiro resto
    inteiro primeiro_digito_calculado
    inteiro segundo_digito_calculado
    inteiro digito_numerico_atual // Variável auxiliar para armazenar o dígito como número

    escreva("Digite seu CPF (apenas os números, 11 dígitos): ")
    leia(cpf_str)

    // --- PARTE 1: VERIFICAÇÃO INICIAL DO FORMATO ---

    // 1.1. Verificar se a string tem exatamente 11 caracteres.
    se (Texto.numero_caracteres(cpf_str) != 11) {
      escreva("CPF inválido: Deve conter exatamente 11 dígitos.\n")
      retorne // Encerra o programa se o formato for inválido
    }

    // 1.2. Verificar se todos os caracteres da string são dígitos numéricos (0-9).
    para (inteiro i = 0; i < Texto.numero_caracteres(cpf_str); i++) {
      caracter char_atual = Texto.obter_caracter(cpf_str, i)
      // Verifica se o caractere está fora do intervalo '0' a '9'
      se (nao (char_atual >= '0' e char_atual <= '9')) {
        escreva("CPF inválido: Deve conter apenas números de 0 a 9.\n")
        retorne // Encerra o programa se houver caracteres não numéricos
      }
    }

    // --- PARTE 2: VALIDAÇÃO USANDO O ALGORITMO DO MÓDULO 11 ---

    // 2.1. Cálculo do Primeiro Dígito Verificador (D1)
    soma = 0
    // Multiplicar os nove primeiros dígitos por pesos decrescentes de 10 a 2.
    para (inteiro i = 0; i < 9; i++) {
      // Converte o caractere do dígito para seu valor numérico inteiro
      digito_numerico_atual = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, i)) - Tipos.caracter_para_inteiro('0')
      soma += digito_numerico_atual * (10 - i) // Peso decrescente (10, 9, ..., 2)
    }

    // Calcular o resto da divisão da soma por 11.
    resto = soma % 11

    // Determinar o Primeiro Dígito Verificador (D1)
    se (resto < 2) {
      primeiro_digito_calculado = 0
    } senao {
      primeiro_digito_calculado = 11 - resto
    }

    // Comparar o primeiro dígito verificador calculado com o décimo dígito do CPF de entrada.
    inteiro decimo_digito_informado = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, 9)) - Tipos.caracter_para_inteiro('0')
    
    se (primeiro_digito_calculado != decimo_digito_informado) {
      escreva("CPF inválido: Primeiro dígito verificador (D1) incorreto.\n")
      retorne
    }

    // 2.2. Cálculo do Segundo Dígito Verificador (D2)
    soma = 0
    // Considerar os nove dígitos iniciais mais o primeiro dígito verificador calculado (total de 10 dígitos).
    // Multiplicar esses dez dígitos por pesos decrescentes de 11 a 2.
    para (inteiro i = 0; i < 10; i++) {
      se (i < 9) { // Para os primeiros 9 dígitos, pegamos do CPF original
          digito_numerico_atual = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, i)) - Tipos.caracter_para_inteiro('0')
      } senao { // Para o décimo dígito (índice 9), usamos o D1 que calculamos
          digito_numerico_atual = primeiro_digito_calculado
      }
      soma += digito_numerico_atual * (11 - i) // Peso decrescente (11, 10, ..., 2)
    }

    // Calcular o resto da divisão da soma por 11.
    resto = soma % 11

    // Determinar o Segundo Dígito Verificador (D2)
    se (resto < 2) {
      segundo_digito_calculado = 0
    } senao {
      segundo_digito_calculado = 11 - resto
    }

    // Comparar o segundo dígito verificador calculado com o décimo primeiro dígito do CPF de entrada.
    inteiro decimo_primeiro_digito_informado = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, 10)) - Tipos.caracter_para_inteiro('0')

    se (segundo_digito_calculado != decimo_primeiro_digito_informado) {
      escreva("CPF inválido: Segundo dígito verificador (D2) incorreto.\n")
      retorne
    }
    
    // --- PARTE 3: RESULTADO FINAL ---
    // Se todas as verificações passarem
    escreva("CPF VÁLIDO.\n")
  }
}