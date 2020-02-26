#!/bin/bash -x

#CONSTANTS
ISHEAD=1
SINGLE=1
DOUBLE=2
TRIPLE=3
declare -A coinFlip
read -p "Enter how many times to flip a coin " flipCoin
#CHECKING COMBINATION
function isFlip(){
	local NumberCoin=$1
	for (( flip=0; flip<$flipCoin; flip++ ))
	do
   	for (( coin=0; coin<$NumberCoin; coin++ ))
   	do
      	randomCheck=$((RANDOM%2))
      	if [ $randomCheck -eq $ISHEAD ]
      	then
         	coinSide+=H
      	else
         	coinSide+=T
      	fi
   	done
		#STORING THE COMBINATION
   	((coinFlip[$coinSide]++))
   	coinSide=""
	done
}
printf "Enter 1 for Single Combination\n"
printf "Enter 2 for Double Combination\n"
printf "Enter 3 for Triple Combination\n"
#FUNCTION TO GET PERCENTAGE
function getPercent(){
	for index in ${!coinFlip[@]}
	do
		coinFlip[$index]=`echo "scale=2; ${coinFlip[$index]}*100/$flipCoin" | bc`
	done
}
#PRINTING CHOICES
read -p "Enter your choice " choice
case $choice in
   $SINGLE)
   	isFlip $SINGLE
   	getPercent $SINGLE
	;;
   $DOUBLE)
   	isFlip $DOUBLE
   	getPercent $DOUBLE
   ;;
	$TRIPLE)
		isFlip $TRIPLE
		getPercent $TRIPLE
	;;
	*)
esac
#SHOWS THE WINNING COMBINATION
for k in ${!coinFlip[@]}
do
   echo $k '-Winning combination-' ${coinFlip[$k]}
done | sort -rn -k3 | head -1
