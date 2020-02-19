#!/bin/bash -x

#CONSTANTS
ISHEAD=1
SINGLE=1
DOUBLE=2
TRIPLE=3

#DECLARE A DICTIONARY TO STORE COMBINATIONS
declare -A coinFlip

read -p "Enter how many times to flip a coin " flipCoin

#FUNCTION TO CHECK COMBINATION
function isFlip(){
local NumberCoin=$1
for (( flip=0; flip<$flipCoin; flip++ ))
do
   for (( coin=0; coin<$NumberCoin; coin++ ))
   do
      randomCheck=$((RANDOM%2))
      if [ $randomCheck -eq $ISHEAD ]
      then
         echo "Head"
         coinSide+=H
      else
         echo "Tails"
         coinSide+=T
      fi
   done
#STORING THE COMBINATION IN DICTIONARY
   ((coinFlip[$coinSide]++))
   coinSide=""
done
echo ${!coinFlip[@]}
echo ${coinFlip[@]}
}
echo "Enter 1 for Single Combination"
echo "Enter 2 for Double Combination"
echo "Enter 3 for Triple Combination"

#FUNCTION TO GET PERCENTAGE
function getPercent(){
for index in ${!coinFlip[@]}
do
	coinFlip[$index]=`echo "scale=2; ${coinFlip[$index]}*100/$flipCoin" | bc`
done
}

#SWITCH CASE FOR CHOICES
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
