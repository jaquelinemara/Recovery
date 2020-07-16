# Automação de Processo de Recovery

## Introdução

Um Recovery corresponde a uma imagem de um sistema operacional. Supondo que por padrão o nome desta imagem seja "CÓDIGO - DESCRIÇÃO", esta ferramenta busca a imagem em diretório específico, verifica o HASH MD5, e por fim, faz a compactação desta imagem para enviá-la a um servidor. 

## Uso da Ferramenta

* Realiar o download da ferramenta no diretório desejado;
* Preencher o arquivo "recovery.csv":
  * Cada linha contém um "cod" (código do recovery) e a respectiva "desc" (descrição de recovery); 
  * Listar cada arquivo em cada linha, não deixando linhas em branco ao final, abaixo das preenchidas;
* Executar o arquivo "Menu.BAT";
* Aguardar o processo de recovery ser finalizado;
* Verificar o arquivo log.txt na pasta "LOG\log.txt" para conferir a saída do processo;
* Os arquivos zipados estarão nas pastas "Temp\[Código do Recovery]";
* Transfira a pasta criada contendo o arquivo compactado para o servidor via FTP, por exemplo.
