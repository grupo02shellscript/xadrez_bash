#!/bin/bash

declare -A mt
declare -A ps
declare -A negro
declare -A branco
declare -A backup

#########variaveis para o tput#############
colunas=$(tput cols)
linhas=$(tput lines)
#########para cor do tabuleiro############
branco="43"
preto="44"

cor=$branco

FIM=""
#### AS PEÇAS COM CARACTERES BONITINHOS#####

negro["rei"]="?"
negro["rainha"]="?"
negro["bispo"]="?"
negro["cavalo"]="?"
negro["torre"]="?"
negro["piao"]="?"

branco["rei"]="?"
branco["rainha"]="?"
branco["bispo"]="?"
branco["cavalo"]="?"
branco["torre"]="?"
branco["piao"]="?"

######cria a matriz para movimentos##############
for i in 1 2 3 4 5 6 7 8;
do	
	for j in 1 2 3 4 5 6 7 8;
	do
		mt["$j","$i"]="$j""$i" 
	done
done

###########inicializa peças na posição inicial###############
for i in 9 8 7 6 5 4 3 2 1 0;
do      
        for j in "Z" "A" "B" "C" "D" "E" "F" "G" "H" "I";
        do
                ps["$j","$i"]=" " 
        done
done

ps["A",8]=${negro["torre"]}
ps["B",8]=${negro["cavalo"]}
ps["C",8]=${negro["bispo"]}
ps["D",8]=${negro["rainha"]}
ps["E",8]=${negro["rei"]}
ps["F",8]=${negro["bispo"]}
ps["G",8]=${negro["cavalo"]}
ps["H",8]=${negro["torre"]}
ps["A",7]=${negro["piao"]}
ps["B",7]=${negro["piao"]}
ps["C",7]=${negro["piao"]}
ps["D",7]=${negro["piao"]}
ps["E",7]=${negro["piao"]}
ps["F",7]=${negro["piao"]}
ps["G",7]=${negro["piao"]}
ps["H",7]=${negro["piao"]}

ps["A",1]=${branco["torre"]}
ps["B",1]=${branco["cavalo"]}
ps["C",1]=${branco["bispo"]}
ps["D",1]=${branco["rainha"]}
ps["E",1]=${branco["rei"]}
ps["F",1]=${branco["bispo"]}
ps["G",1]=${branco["cavalo"]}
ps["H",1]=${branco["torre"]}
ps["A",2]=${branco["piao"]}
ps["B",2]=${branco["piao"]}
ps["C",2]=${branco["piao"]}
ps["D",2]=${branco["piao"]}
ps["E",2]=${branco["piao"]}
ps["F",2]=${branco["piao"]}
ps["G",2]=${branco["piao"]}
ps["H",2]=${branco["piao"]}

#########seta as bordas do tabuleiro#############

ps["A",9]="A"
ps["B",9]="B"
ps["C",9]="C"
ps["D",9]="D"
ps["E",9]="E"
ps["F",9]="F"
ps["G",9]="G"
ps["H",9]="H"
ps["A",0]="A"
ps["B",0]="B"
ps["C",0]="C"
ps["D",0]="D"
ps["E",0]="E"
ps["F",0]="F"
ps["G",0]="G"
ps["H",0]="H"

ps["Z",1]="1"
ps["Z",2]="2"
ps["Z",3]="3"
ps["Z",4]="4"
ps["Z",5]="5"
ps["Z",6]="6"
ps["Z",7]="7"
ps["Z",8]="8"
ps["I",1]="1"
ps["I",2]="2"
ps["I",3]="3"
ps["I",4]="4"
ps["I",5]="5"
ps["I",6]="6"
ps["I",7]="7"
ps["I",8]="8"
####################################################

####para o tpup#####################################
width=$(($colunas - 30))
height=$(($linhas - 20))


############### o nome da função ja diz tudo né?########################################
desenha_tabuleiro(){
for i in 9 8 7 6 5 4 3 2 1 0;
do
	tput cup $(($height / 2)) $((($width / 2) - (10 / 2)))
	height=$(($height+2))
	for j in "Z" "A" "B" "C" "D" "E" "F" "G" "H" "I";
	do
	 	peca=${ps["$j","$i"]}
		###############teste para não pintar as bordas##########################
		if [ $i == 0 ]
		then
			echo -n " "$peca
		else
			if [ $i == 9 ]
			then
				echo -n " "$peca
			else
				if [ $j == "Z" ]
				then
					echo -n " "$peca
				else
					if [ $j == "I" ]
					then
						echo -n " "$peca
					else
						echo -en "\033[${cor}m$peca \033[m"
					fi
				fi
			fi
		fi		
################### troca a cor #####################################################
		if [ $cor == $branco ]
		then
			cor=$preto
		else
			cor=$branco
		fi
	done
	printf "\n"
	if [ $cor == $branco ]
	then
		cor=$preto
	else
		cor=$branco
	fi
done
}

################## duas funções que fazem backups da ultima jogada para poder retornar ################# 
faz_backup(){

for i in 9 8 7 6 5 4 3 2 1 0;
do
        for j in "Z" "A" "B" "C" "D" "E" "F" "G" "H" "I";
        do
                backup["$j","$i"]=${ps["$j","$i"]}
        done
done
}

devolve_backup(){
for i in 9 8 7 6 5 4 3 2 1 0;
do
        for j in "Z" "A" "B" "C" "D" "E" "F" "G" "H" "I";
        do
               ps["$j","$i"]=${backup["$j","$i"]}
        done
done

}

testa_limites(){
	x=$1
	y=$2
	aux="ABCDEFGH"
	if [ $y -gt 0 ];
	then
		if [ $y -lt 9 ];
		then
			if echo $aux | egrep $x >/dev/null;
			then
				echo "True"
			else
				echo "False"
			fi
		else
			echo "False"
		fi
	else
		echo "False"
	fi

}
###################função pra testar final de jogo ########################

fim_de_jogo(){
	jogando=$1
	local x=$2
	local y=$3
	
	if [ $jogando == "branco" ];
	then
		if [ ${ps[$x,$y]} == ${negro["rei"]} ];
		then
			echo "FIM"
			break
		fi
	fi
	
	if [ $jogando == "negro" ];
        then
                if [ ${ps[$x,$y]} == ${branco["rei"]} ];
                then
                        echo "FIM"
			break
                fi
        fi

	echo "CONTINUA"
}

################### que começa jogando ########################
quemjoga="branco"


###################### MAIN ##################################
while true
do
clear

desenha_tabuleiro

if [ $quemjoga == "branco" ]
then
	################# o height é incrementado para poder a linha descer no canto certo############# 
	tput cup $(($height / 2)) $((($width / 2) - (29 / 2))) ## a ultima subtração é para centralizar o testo
        height=$(($height + 2))
	if [ "$FIM" == "FIM" ];
	then
		tput cup $(($height / 2)) $((($width / 2) - (14 / 2)))
		height=$(($height + 2))
		echo "PRETAS VENCERAM"
		read enter
	fi
	echo "Brancos jogam, informe o nome da peça deseja mover: "; 
	tput cup $(($height / 2)) $((($width / 2)))
        height=$(($height + 2))
	read nome
	##################### se o jogador jogou errado ele volta a ultima jogada #######################3
	if [ "$nome" == "voltar" ];
	then
		devolve_backup
		quemjoga="negro"
		width=$(($colunas - 30))
                height=$(($linhas - 20))
		continue
	fi
	tput cup $(($height / 2)) $((($width / 2) - (20 / 2)))
        height=$(($height + 2))
	echo "Informa a posição que ela esta. EX: A1: "; 
	tput cup $(($height / 2)) $((($width / 2)))
        height=$(($height + 2))
	read pos1
	tput cup $(($height / 2)) $((($width / 2) - (22 / 2)))
        height=$(($height + 2))
	echo "Informe a posição para onde ela ira. EX: B2:"; 
	tput cup $(($height / 2)) $((($width / 2)))
	height=$(($height + 2))
	read pos2
		
	testa=${branco[$nome]}
	x=`echo $pos1 | grep -Eo "(^[[:alnum:]])"`
	y=`echo $pos1 | grep -Eo "([[:alnum:]]$)"`
	xn=`echo $pos2 | grep -Eo "(^[[:alnum:]])"`
	yn=`echo $pos2 | grep -Eo "([[:alnum:]]$)"`
	

	if [ "${ps[$x,$y]}" != "$testa" ];
	then
		tput cup $(($height / 2)) $((($width / 2) - (22 / 2)))
		echo "Você é CEGO? A peça não esta no local indicado"
		read enter
		width=$(($colunas - 30))
        	height=$(($linhas - 20))
		continue
	else
		
		limite=`testa_limites $xn $yn`
		if [ "$limite" == "False" ]
		then
			tput cup $(($height / 2)) $((($width / 2) - (22 / 2)))
			echo "Você é CEGO? O Destino da peça não é válido"
			width=$(($colunas - 30))
               		height=$(($linhas - 20))
			read enter
			continue
		else
			
			FIM=`fim_de_jogo $quemjoga $xn $yn`
			faz_backup
			ps[$x,$y]=" "
			ps[$xn,$yn]="$testa"
			quemjoga="negro"	
			width=$(($colunas - 30))
        		height=$(($linhas - 20))
		fi
	fi
	################### após a ação devemos devolver o valor das variaveis width e height para poderem redesenhar o tabuleiro###########
else
	tput cup $(($height / 2)) $((($width / 2) - (29 / 2)))
        height=$(($height+2))
	if [ "$FIM" == "FIM" ];
        then
   	        tput cup $(($height / 2)) $((($width / 2) - (16 / 2)))
                height=$(($height + 2))
		echo "BRANCAS VENCERAM"
                read enter
        fi
	echo "Pretos jogam, informe o nome da peça deseja mover: "
	tput cup $(($height / 2)) $((($width / 2)))
        height=$(($height + 2))
	read nome
	################### se o jogador jogou errado ele volta a ultima jogada ###############################
	if [ "$nome" == "voltar" ];
        then
                devolve_backup
                quemjoga="branco"
		width=$(($colunas - 30))
                height=$(($linhas - 20))
                continue
        fi


	tput cup $(($height / 2)) $((($width / 2) - (20 / 2)))
        height=$(($height + 2))
        echo "Informa a posição que ela esta. EX: A1: "
	tput cup $(($height / 2)) $((($width / 2)))
        height=$(($height + 2))
	read pos1
	tput cup $(($height / 2)) $((($width / 2) - (22 / 2)))
        height=$(($height + 2))
        echo "Informe a posição para onde ela ira. EX: B2: " 
	tput cup $(($height / 2)) $((($width / 2)))
        height=$(($height + 2))
	read pos2
	
	
        testa=${negro[$nome]}       
	x=`echo $pos1 | grep -Eo "(^[[:alnum:]])"`
        y=`echo $pos1 | grep -Eo "([[:alnum:]]$)"`
        xn=`echo $pos2 | grep -Eo "(^[[:alnum:]])"`
        yn=`echo $pos2 | grep -Eo "([[:alnum:]]$)"`
	if [ "${ps[$x,$y]}" != "$testa" ];
        then
		tput cup $(($height / 2)) $((($width / 2) - (22 / 2)))
                echo "Você é CEGO? A peça não esta no local indicado"
         	
        	read enter
		
		width=$(($colunas - 30))
        	height=$(($linhas - 20))
	
		continue
	else
           	limite=`testa_limites $xn $yn`
                if [ "$limite" == "False" ]
                then
                        tput cup $(($height / 2)) $((($width / 2) - (22 / 2)))
                        echo "Você é CEGO? O Destino da peça não é válido"
                        width=$(($colunas - 30))
                        height=$(($linhas - 20))
                        read enter
                        continue
                else
                        faz_backup
                        ps[$x,$y]=" "
                        ps[$xn,$yn]="$testa"
                        quemjoga="branco"
                        width=$(($colunas - 30))
                        height=$(($linhas - 20))
                fi


################### após a ação devemos devolver o valor das variaveis width e height para poderem redesenhar o tabuleiro###########
	fi
fi 




done


####################################################################################################################################