#include <stdio.h>
#include <string.h>

#define max(a,b) ((a) > (b) ? a : b)
#define min(a,b) ((a) < (b) ? a : b)

int isDigit(char c) {
    return c >= '0' && c <= '9';
}

int isSymbol(char c) {
    return ! (isDigit(c) || c == '.');
}

int main() {
    FILE *fptr;
    fptr = fopen("input.txt", "r");

    char myString[140];
    
    int lines = 140;
    int lineLength = 140;

    int total = 0;

    char matrix[lines][lineLength];
    for (int y = 0; y < lines; y++) {
        fgets(myString, 140, fptr);

        for (int x = 0; x < lineLength; x++) {
            matrix[y][x] = myString[x];
        }
    }
    
    for (int y = 0; y < lines; y++) {

        int startX = -1;
        int parsedValue = 0;

        for (int x = 0; x < lineLength; x++) {
            char c = matrix[y][x];

            if (isDigit(c)) {
                if (parsedValue <= 0) {
                    startX = x;
                }

                parsedValue *= 10; // Prepare to add new digit
                parsedValue += c - '0';
            } else if (parsedValue > 0) {
                // endX = min(x + 1, lineLength - 1);
                // printf("%d\n", parsedValue);
                // printf("%d @ [x: %d - %d, y: %d - %d]\n", parsedValue, startX, endX, startY, endY);

                for (int sy = max(y - 1, 0); sy <= y + 1; sy++) {
                    for (int sx = max(0, startX - 1); sx <= x; sx++) {
                        if (isSymbol(matrix[sy][sx])) {
                            total += parsedValue;
                            goto afterFor;
                        }
                    }
                }

                // printf("%d @ [x: %d - %d, y: %d - %d]\n", parsedValue, startX, endX, startY, endY);
                // for (int sy = startY; sy <= endY; sy++) {
                //     for (int sx = startX; sx <= endX; sx++) {
                //         printf("%d,%d [%c] - ", sx, sy, matrix[sy][sx]);
                //     }
                //     printf("\n");
                // }
                // printf("\n");
                // continue;

                afterFor:
                parsedValue = 0;
            } else {
                parsedValue = 0;
            }
        }
    }

    printf("Total: %d\n", total);

    fclose(fptr);
    return 0;
}