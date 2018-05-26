for i in {0..99}
do
  echo "starting $i"
  wget http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-$i.csv.zip
  unzip googlebooks-eng-all-2gram-20090715-$i.csv.zip
  rm -f googlebooks-eng-all-2gram-20090715-$i.csv.zip
  awk -f cleanup.awk googlebooks-eng-all-2gram-20090715-$i.csv >> two_gram_$i.csv
  rm -f googlebooks-eng-all-2gram-20090715-$i.csv
done
  
