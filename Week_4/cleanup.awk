BEGIN{sum = 0}
{
{if (NR==1) {string1 = $1
             string2 = $2}}
if ($1 == string1)
        {if ($2 == string2) { sum = sum + $3 }
        else {print string1 " " string2 " " sum
              string2=$2
              sum = $3}
        }
else {print string1 " " string2 " " sum
      sum = $3
      string1=$1
      string2=$2}
}

END{
print string1 " " string2 " " sum
}
