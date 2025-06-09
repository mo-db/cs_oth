#include <stdio.h>
int n = -5;
long l = 0x3000;
char c = 'A';
short h = 012;
long sum;
int main(){
	sum = n + l + c + h;
	printf("sum = %ld\n", sum);
	return 0;
}
