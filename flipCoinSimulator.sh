#!/bin/bash -x

#CONSTANTS
ISHEAD=1
SINGLE=1
DOUBLE=2
TRIPLE=3

#DECLARE A DICTIONARY TO STORE COMBINATIONS
declare -A singleFlip
declare -A doubleFlip
declare -A tripleFlip

read -p "Enter how many times to flip a coin " flipCoin

#FUNCTION TO CHECK DOUBLET COMBINATION
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
   if [ $NumberCoin -eq $SINGLE ]
   then
      ((singleFlip[$coinSide]++))
      echo ${!singleFlip[@]}
   elif [ $NumberCoin -eq $DOUBLE ]
   then
      ((doubleFlip[$coinSide]++))
      echo ${!doubleFlip[@]}
   elif [ $NumberCoin -eq $TRIPLE ]
	then
		((tripleFlip[$coinSide]++))
      echo ${!tripleFlip[@]}
   fi
   coinSide=""
done
}
echo "Enter 1 for Single Combination"
echo "Enter 2 for Double Combination"
echo "Enter 3 for Triple Combination"

#FUNCTION TO GET PERCENTAGE
function getPercent(){
local NumberCoin=$1
if [ $NumberCoin -eq $SINGLE ]
then
	for index in ${!singleFlip[@]}
   do
		singleFlip[$index]=`echo "scale=2; ${singleFlip[$index]}*100/$flipCoin" | bc`
   done
elif [ $NumberCoin -eq $DOUBLE ]
then
   for index in ${!doubleFlip[@]}
   do
		doubleFlip[$index]=`echo "scale=2; ${doubleFlip[$index]}*100/$flipCoin" | bc`
   done
elif [ $NumberCoin -eq $TRIPLE ]
then
	for index in ${!tripleFlip[@]}
	do
		tripleFlip[$index]=`echo "scale=2; ${tripleFlip[$index]}*100/$flipCoin" | bc`
	done
else
	echo "Enter choice from 1-3"
fi
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
