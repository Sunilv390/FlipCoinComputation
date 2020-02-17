#!/bin/bash -x

#CONSTANT
ISHEAD=1

#USERINPUT
declare -A coin
read -p "Enter number of times to flip " number

#RANDOM VALUE FOR HEADS AND TAIL
for (( counter=0; counter<number; counter++ ))
do
	randomFlip=$((RANDOM%2))
	if [ $randomFlip -eq $ISHEAD ]
	then
		coin[$counter]=H
		((headCount++))
		Headpercent=`echo "scale=2; $headCount*100/$number" | bc`
	else
		coin[$counter]=T
		((tailCount++))
		Tailpercent=`echo "scale=2; $tailCount*100/$number" | bc`
	fi
done
echo "Singlet Combination is "${coin[@]}
echo "Head percentage is $Headpercent%"
echo "Tail percentage is $Tailpercent%"
