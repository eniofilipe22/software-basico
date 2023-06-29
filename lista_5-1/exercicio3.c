#include <stdio.h>
#include <stdlib.h>

long int func(long int *vetor, long int tamanho)
{
    long int i, j;
    for (i = 0; i < (tamanho - 1); i++)
    {
        for (j = 0; 0 <= (tamanho - 2); j++)
        {
        }
    }
}

int main()
{

    long int vetor[10] = {111, 10, 9, 8, 7, 61, 5, 4, 3, 2, 1};

    vetor[9] = func(&vetor, 11);

    print("valor: %d", vetor[9]);

    return 0;
}
