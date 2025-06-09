#include <stdio.h>
#define COUNT 5

int main() { 
	char choice, again, pattern = 'o';
	do {
		puts("Choose an option:");
		puts("1 - Count up using for loop");
		puts("2 - Print triangle pattern with '|'");
		puts("3 - Print triangle pattern with 'o'");
		printf("Your choice: ");
		scanf(" %c", &choice);
		switch (choice) {
		case '1':
			for (int i = 1; i <= COUNT; i++) {
				printf("%d ", i);
			}
			puts("");
			break;
		case '2':
			pattern = '|';
		case '3':
			if (choice == 3)
				pattern = 'o';
			for (int row = 1; row <= COUNT; row++) {
				int col = 1;
				do {
					if (col % 2 == 0)
						printf("%c", pattern);
					else
						printf("+");
					col++;
				} while (col <= row);
				puts("");
			}
			break;
		default:
			printf("Invalidselection.\n");
		}
		printf("Do you want to try again? (y/n): ");
		scanf(" %c", &again);
		pattern = 'o';
	} while (again == 'y' || again == 'Y');
	return 0;
}
