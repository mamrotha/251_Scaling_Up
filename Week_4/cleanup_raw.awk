{
if (($1 ~ "^[A-Za-z]*$") && ( $2 ~ "^[A-Za-z]*$"))
{ print tolower($1) " " tolower($2) " " $4}
}
