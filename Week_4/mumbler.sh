#Ask for input and verify it's correct.
#while true
#do

  echo "Please enter a starting word in lower case."
  read WORD
  WORD=$(echo "$WORD" | awk '{print tolower($0)}')

  echo "Please enter a number of iterations the mumbler will run."
  read COUNT
#  if (($WORD =~ "^[A-Za-z]*$") && ($COUNT =~ "^[0-9]*$")); then break

#done

echo "Starting the mumbler!"

#Start the mumbler loop
for i in $(seq 1 $COUNT)
do

  look "$WORD" two_gram_final.csv | awk -v word_filter="$WORD" -f filter.awk > output.txt
  TOTAL=$(awk '{tot+=$3} END{print tot}' output.txt)
  RAND=$[ ( $RANDOM % $TOTAL ) + 1 ]
  WORD=$(awk -v random=$RAND -f next_word.awk output.txt)
  echo "$WORD"
  rm -f output.txt

done
