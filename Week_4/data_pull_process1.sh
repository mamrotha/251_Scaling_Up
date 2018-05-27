cd /gpfs/gpfsfpo
for i in {0..99}
do
  wget http://storage.googleapis.com/books/ngrams/books/googlebooks-eng-all-2gram-20090715-$i.csv.zip
  unzip googlebooks-eng-all-2gram-20090715-$i.csv.zip
  rm -f googlebooks-eng-all-2gram-20090715-$i.csv.zip
  echo "---------------------cleaning--------------------"
  awk -f cleanup_raw.awk googlebooks-eng-all-2gram-20090715-$i.csv >> two_gram_$i.csv
  rm -f googlebooks-eng-all-2gram-20090715-$i.csv
done
  
