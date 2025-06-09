#include <stdio.h>
#define DEFAULT_COUNT 5

void draw_pattern(char symbol, int count) {
	for (int row = 1; row <= count; row++) {
		int col = 1;
		do {
			if (col % 2 == 0) {
				printf("%c", symbol);
			} else {
				printf("+");
			}
			col++;
		} while(col <= row);
		puts(""); // new line
	}
}

int main() {
	char choice, again, symbol;
	int count = DEFAULT_COUNT;
	do {
		puts("Choose an option:");
		puts("1 - Set new pattern count");
		puts("2 - Print triangle pattern with '|'");
		puts("3 - Print triangle pattern with 'o'");
		printf("Your choice: ");
		scanf(" %c", &choice);
		switch (choice) {
		case '1':
			printf("Set count: ");
			scanf("%d", &count);
			for (int i = 1; i <= count; i++) {
				printf("%d ", i);
			}
			puts(""); // new line
			break;
		case '2':
			symbol = '|';
			draw_pattern(symbol, count);
			break;
		case '3':
			symbol = 'o';
			draw_pattern(symbol, count);
			break;
		default:
			printf("invalid selection!");
		}
		printf("Do you want to try again? (y/n): ");
		scanf(" %c", &again);
	} while(again == 'y' || again == 'Y');
	return 0;
}
