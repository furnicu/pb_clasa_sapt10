/*
Realizati un program in C in care avem un aprozar cu fructe, fiecare fruct este descris de : nume, tara, cod_bare, pret.
Codul de bare este considerat citit corect daca are forma 'ccc-01', unde 'ccc' reprezinta cifre
Pretul este dat automat fiind egal cu : (c + c + c) / 10
Realizati un meniu interactiv cu urmatoarele optiuni:
1. Adaugarea unui nou fruct in aprozar.
2. Afisarea fructelor din aprozar in ordine crescatoare dupa pret, folosind qsort.
3. Sa se copieze intr-un vector penultimul caracter din nume, apoi sa se afiseze vectorul ordine invers alfabetica folosind bubble sort.
4. Sa se calculeze suma lungimilor tarii fiecarui fruct, apoi sa se salveze intr-un fisier txt cu numele dat de utilizator nr de biti pe 1 din suma.
5. Iesire.
OBS
-Pentru fiecare cerinta se va crea o functie
-Se va crea si implementa cel putin o instructiune macro light function
*/
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #define cit(x) scanf("%d", &x);
typedef struct aprozar
{
    char cod[7];
    char nume[20];
    char tara[20];
    float pret;
}Apro;
int validare(char *x)
{
    if(strlen(x) == 3 && x[0] >= '0' && x[0] <= '9' && x[1] >= '0' && x[1] <= '9' && x[2] >= '0' && x[2] <= '9')
        return 1;
    return 0;
}
void adaugare_fructe(Apro *v, int *n)
{
 
    (*n)++;
    printf("Nume : ");
    scanf("%s", v[*n].nume);
    printf("Tara : ");
    scanf("%s", v[*n].tara);
    do
    {
        printf("Cod bare : ");
        scanf("%s", v[*n].cod);
    }while(!validare(v[*n].cod));
    strcat(v[*n].cod, "-01");
    v[*n].pret = ((v[*n].cod[0] - '0') + (v[*n].cod[1] - '0') + (v[*n].cod[2] - '0')) / 10.0;
 
}
void afisare_fructe(Apro *v, int n)
{
    int i;
    for(i = 0; i <= n; i++)
    {
        printf("%s %s %s %f\n", (v + i)->nume, (v+i)->tara, (v+i)->cod, (v+i)->pret);
    }
}
int sortare(const void *a, const void *b)
{
    Apro *ia = (Apro*)a;
    Apro *ib = (Apro*)b;
 
    return ia->pret - ib->pret;
}
void creare_vector(Apro *v, int n)
{
    char *x;
    int i, j;
 
    x = (char*)malloc((n+1) * sizeof(char));
 
    if(x == NULL)
    {
        printf("Err");
        exit(1);
    }
 
    for(i = 0; i <= n; i++)
        *(x+i) = v[i].nume[strlen(v[i].nume) - 2];
    for(i = 0; i <= n; i++)
        printf(" %c", *(x+i));
    for(i = 0; i < n; i++)
        for(j = i + 1; j <= n; j++)
            if(*(x+i) < *(x+j))
            {
                *(x+i) = *(x+i) ^ *(x+j);
                *(x+j) = *(x+i) ^ *(x+j);
                *(x+i) = *(x+i) ^ *(x+j);
            }
    printf("\n");
    for(i = 0; i <= n; i++)
        printf(" %c", *(x+i));
    free(x);
}
 
 int main()
 {
    int ok, n = -1;
    Apro v[100];
 
    do
    {
        printf("\nIntroduceti una dintre urmatoarele optiuni:\n");
        printf("1. Adaugarea unui nou fruct in aprozar.\n");
        printf("2. Afisarea fructelor din aprozar in ordine crescatoare dupa pret, folosind qsort.\n");
        printf("3. Sa se copieze intr-un vector penultimul caracter din nume, apoi sa se afiseze vectorul ordine invers alfabetica folosind bubble sort.\n");
        printf("4. Sa se calculeze suma lungimilor tarii fiecarui fruct, apoi sa se salveze intr-un fisier txt cu numele dat de utilizator nr de biti pe 1 din suma.\n");
        printf("5. Iesire.\n");
        scanf("%d", &ok);
 
        switch(ok)
        {
            case 1:
                    adaugare_fructe(v, &n);
                break;
 
            case 2:
                    qsort(v, n + 1, sizeof(Apro), sortare);
                    afisare_fructe(v, n);
                break;
           
            case 3:
                    creare_vector(v, n);
                break;
        }
    } while (ok != 5);
   
 
   
 
    return 0;
 }
