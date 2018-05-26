BEGIN{
sum = 0
string1 = "a"
string2 = "acceptor"
}

( $1 ~ /^[a-z]+$/ ) && ( $2 ~ /^[a-z]+$/ ) {
if ($1 == string1)
        {if ($2 == string2) { sum = sum + $4 }
        else {print string1 " " string2 " " sum
              string2=$2
              sum = $4}
        }
else {sum = $4
      string1=$1
      string2=$2}
}

END{
print string1 " " string2 " " sum
}
