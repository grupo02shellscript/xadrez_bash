# xadrez_bash
Jogo de Xadrez implementado em Shell Scripts utilizando matriz.

Sinopse/Synopsis
É um jogo de xadrez desenvolvido em shell  que funciona offline onde tem a capacidade de 2 jogadores por partida , os quais fazem suas jogadas a partir do mesmo computador ,a jogada é feita a partir de uma letra e um numero que representa uma posição na matriz , coluna x linha , alem disso o jogador possui a opção de voltar a jogada defido a implementação de uma função de backup o que possibilita a correção de alguma jogada errada.

Motivação/Motivation
Esse projeto foi desenvolvido no intuito de realizar a execução de uma trabalho exigido em uma  disciplina de programação de  na Universidade Federal Ceará - Campus Quixadá

Instalação/Installation
1 - Baixa o arquivo xadrez_bash.sh 
2 - salvar em uma maquina com sistema operacional linux ou no windows com subsistema linux e na pasta desejada 
3 - executar o comando chmod +x xadrez_bash.sh que permite executar o arquivo
4 - utilizando o comando ./xadrez_bash.sh para executar o  

Como Jogar?
1 - Rodar  "./xadrez-bash.sh
2 - Ao rodar o  :
Peças Brancas iniciam jogando
As peças se movem na seguinte sequência:
- nome da peça
- posição que ela se encontra coluna x linha (onde a coluna é representada por letras e as linha são representadas por numeros, ex A1)
- posição futura  coluna x linha 
Muda jogador e inicia a proxima movimentação .

Regras do xadrez em si, não são implementadas pois os dois jogadores estão presentes.
Ao detectar um jogada invalida qualquer jogador pode chamar a função "voltar", que desfaz
a ultima jogada e devolve a vez para o jogador anterior, o jogo acaba quando um rei é capturado. 


Referência API/API Reference
https://github.com/thelazt/chessbash
bolknote.ru

Contribuintes/Contributors

Programadores:
https://www.facebook.com/marcospaulo.fernandes.1
https://www.facebook.com/luzia.nogueira
kessiofideles@gmail.com
https://www.facebook.com/andersonfelipe.costa
https://www.facebook.com/thiago.costa.3110567

Licença/License
O projeto possui licença de código de acesso livre o qual pode ser feito copias, implementado,alterado ou utilizados partes em novos programas gratuitos, ou seja, o projeto pode ser utilizado como o usuário desejar.
