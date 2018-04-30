/* Ordenamento de vetor */
/* Versão com vetor Gloval */

#include <stdio.h>

#define N 10
static int v[N]={9,2,5,1,8,2,4,3,6,7};

void show(int v[], int n)
{
   int i;
   for(i=0;i<n;i++)
         printf("%d\t",v[i]);
   printf("\n");
}


void main()
{
   show(v,N);
   //sort(v,N);
   //show(v,N);
}	


