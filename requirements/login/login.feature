Feature: Login
Como um cliente quero poder acessar minha conta
e me manter logado, para que eu possa ver e responder
enquetes de forma rapida

Cenário: Credenciais Válidas
Dado que o cliente informou Credenciais validas
Quando solicitar para fazer login
Então o sistema  deve enviar o usuario  para  a tela  de pesquisas 
E manter o usuario  conectado

Cenário: Credenciais Inválidas
Dado que o cliente  informou Credenciais Inválidas
Quando solicitar para fazer login
Então o sistema  deve  retornar  uma mensagem de erro