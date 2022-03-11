# Projeto Download
**Projeto realizado para prova da softplan.**
Teste de Conhecimento.

# Pré-Condições técnicas:
• Utilizar orientação a objetos
• Utilizar SOLID
• Utilizar Clean Code
• Utilizar boas práticas de tratamento de exceção
• Utilizar processamento multithread (System.Threading)
• O sistema deve realizar o download via HTTP request
• Os dados de downloads devem ser armazenados em um banco SQLite

# Desenvolva uma aplicação MultiThread conforme critérios de aceite
```sh
DADO que acesso o sistema
E informo o link para download,
QUANDO clico no botão “Iniciar Download”,
ENTÃO o sistema inicia o download
E consigo visualizar seu progresso até sua finalização.
```
```sh
DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico no botão “Exibir mensagem”,
ENTÃO o sistema exibe uma mensagem com a % atual de download.
```
```sh
DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico no botão “Parar download”,
ENTÃO o sistema interrompe o download do arquivo.
```
```sh
DADO que acesso o sistema
E possuo um download em andamento,
QUANDO clico para fechar o sistema,
ENTÃO o sistema exibe a mensagem “Existe um download em andamento, deseja interrompe-lo? 
[Sim, Não]”.
```
```sh
DADO que acesso o sistema
QUANDO clico no botão “Exibir histórico de downloads”,
ENTÃO o sistema abre uma nova tela
E exibe o histórico de downloads realizados, com suas URL’s e suas respectivas datas de início e 
fim.
```

# Resultado esperado:
Uma URL pública do GITHUB, contendo os fontes e binário da 
solução.
