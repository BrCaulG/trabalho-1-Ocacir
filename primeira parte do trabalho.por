programa {
  inclua biblioteca Texto
  inclua biblioteca Tipos
  funcao inicio() {
   cadeia cpf
   escreva("escreva seu CPF com apenas os numeros")
   leia(cpf)
   se(Texto.numero_caracteres(cpf) != 11){
    escreva("cpf invalido")
    retorne
   }
 
  
  }                                                                   
}
