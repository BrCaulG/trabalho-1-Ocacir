programa {
  inclua biblioteca Texto
  inclua biblioteca Tipos 

  funcao inicio() {
    cadeia cpf_str
    inteiro soma
    inteiro resto
    inteiro primeiro_digito_calculado
    inteiro segundo_digito_calculado
    inteiro digito_numerico_atual 

    escreva("Digite seu CPF (apenas os números, 11 dígitos): ")
    leia(cpf_str)

    // --- PARTE 1: VERIFICAÇÃO INICIAL DO FORMATO ---

    // Verifica se a string tem 11 caracteres
    se (Texto.numero_caracteres(cpf_str) != 11) {
      escreva("CPF inválido: Deve conter exatamente 11 dígitos.\n")
      retorne 
    }

    // Verifica se todos os caracteres são dígitos numéricos
    para (inteiro i = 0; i < 11; i++) {
      caracter char_atual = Texto.obter_caracter(cpf_str, i)
      se (nao (char_atual >= '0' e char_atual <= '9')) {
        escreva("CPF inválido: Deve conter apenas números de 0 a 9.\n")
        retorne 
      }
    }

    // --- ADIÇÃO CRÍTICA: VERIFICAÇÃO DE DÍGITOS REPETIDOS ---
    
    logico todos_iguais = verdadeiro
    para (inteiro i = 1; i < 11; i++) {
        se (Texto.obter_caracter(cpf_str, i) != Texto.obter_caracter(cpf_str, 0)) {
            todos_iguais = falso
            pare // Otimização: se encontrar um diferente, pode parar
        }
    }
    se (todos_iguais) {
        escreva("CPF inválido: Números com todos os dígitos repetidos são inválidos.\n")
        retorne
    }

    // --- PARTE 2: VALIDAÇÃO USANDO O ALGORITMO DO MÓDULO 11 ---

    // Cálculo do Primeiro Dígito Verificador (D1)
    soma = 0
    para (inteiro i = 0; i < 9; i++) {
      digito_numerico_atual = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, i)) - Tipos.caracter_para_inteiro('0')
      soma += digito_numerico_atual * (10 - i)
    }

    resto = soma % 11

    se (resto < 2) {
      primeiro_digito_calculado = 0
    } senao {
      primeiro_digito_calculado = 11 - resto
    }

    // Comparação do Primeiro Dígito Verificador
    inteiro decimo_digito_informado = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, 9)) - Tipos.caracter_para_inteiro('0')
    
    se (primeiro_digito_calculado != decimo_digito_informado) {
      escreva("CPF inválido: Primeiro dígito verificador (D1) incorreto.\n")
      retorne
    }

    // Cálculo do Segundo Dígito Verificador (D2)
    soma = 0
    // Agora o laço vai até 10, incluindo o primeiro dígito verificador
    para (inteiro i = 0; i < 10; i++) {
      digito_numerico_atual = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, i)) - Tipos.caracter_para_inteiro('0')
      soma += digito_numerico_atual * (11 - i)
    }

    resto = soma % 11

    se (resto < 2) {
      segundo_digito_calculado = 0
    } senao {
      segundo_digito_calculado = 11 - resto
    }

    // Comparação do Segundo Dígito Verificador
    inteiro decimo_primeiro_digito_informado = Tipos.caracter_para_inteiro(Texto.obter_caracter(cpf_str, 10)) - Tipos.caracter_para_inteiro('0')

    se (segundo_digito_calculado != decimo_primeiro_digito_informado) {
      escreva("CPF inválido: Segundo dígito verificador (D2) incorreto.\n")
      retorne
    }
  
    escreva("CPF VÁLIDO.\n")
  }
}