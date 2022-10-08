#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#define len 100

typedef struct token{
	char name[100];
	char type[50];
}token;
struct list{
	token tok;
	struct list *next;
};
struct list *table[len];

void init()
{
	for(int i=0;i<len;i++)
		table[i]=NULL;
}
int hash(char str[])
{
	int x=0;
	for (int i = 0; str[i] != '\0'; i++)
		x+=str[i];
	x = x%len;
	return x;
}
int search(char str[])
{
	int x = hash(str);
	struct list *p=table[x];
	while(p!=NULL)
	{	if(strcmp(p->tok.name,str)==0)
			break;
		p=p->next;
	}
	if(p==NULL)	return 0;
	return 1;
}
void insert(token tk)
{
	if(search(tk.name))
		return;
	int x=hash(tk.name);
	struct list *newptr=(struct list *)malloc(sizeof(struct list));
	newptr->tok=tk;
	//newptr->x=x;
	newptr->next=NULL;
	if(table[x]==NULL)
		table[x]=newptr;
	else
	{
		struct list *p=table[x];
		while(p->next!=NULL)
			p=p->next;
		p->next=newptr;
	}

}
void print()
{
	int k=0;
	for(int i=0;i<len;i++)
	{
		struct list *p=table[i];
		while(p!=NULL)
		{
			token t=p->tok;
			printf("%d\t%s\t%s\n",k,t.name,t.type);
			k++;
			p=p->next;
		}
	}
}
/*int main()
{
	char str[20];
	printf("enter strings\t enter stop to stop");
	while(strcmp(str,"stop")!=0)
	{
		scanf("%s",str);
		if(strcmp(str,"stop")==0)
			break;
		token t;
		strcpy(t.name,str);
		//t.x=k;
		//k++;
		insert(t);
	}
	print();
	return 0;
}*/
