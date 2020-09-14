#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
int main(){
    FILE *fpi,*fpo;
    fpi=fopen("D:\\Documents\\Sophomore\\MCM_ICM_2020\\hcomment.txt","r");
    fseek(fpi,0,SEEK_END);
    int file_size,i,t=0;
    file_size=ftell(fpi);
    char *temp1,*temp2;
    fseek(fpi,0,SEEK_SET);
    temp1 = (char*)malloc(file_size * sizeof(char));
    fread(temp1,file_size,sizeof(char),fpi);
    fclose(fpi);
    temp2 = (char*)malloc(file_size * sizeof(char));
    fpo = fopen("hreview.txt","w+");
    for (i = 0; i < file_size; i++) {
        if (isprint(temp1[i])) temp2[t] = temp1[i];
        t++;
    }
    temp2[t] = '\0';
    fprintf(fpo, "%s", temp2);
    fclose(fpo);
    return 0;
}