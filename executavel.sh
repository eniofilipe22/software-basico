
echo "COMPILANDO ..."
as $1.s -o $1.o
ld $1.o -o $1
echo "EXECUTANDO ..."
./$1
$?
echo "FINALIZANDO ..."