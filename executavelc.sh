
echo "COMPILANDO ..."
as $1.s -o $1.o
ld $1.o -o $1 -dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc
echo "EXECUTANDO ..."
./$1  $2  $3  $4  $5  $6  $7  $8
$?
echo "FINALIZANDO ..."